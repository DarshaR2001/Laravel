import online_election.store;
import ballerina/persist;
import ballerina/http;
import ballerina/time;
import ballerina/sql;

final store:Client dbClient = check new ();

// Type definitions for API responses
public type ElectionSummaryResponse record {
    store:Candidate[] candidates;
    store:DistrictResult[] districts;
    int totalVotes;
    string lastUpdated;
    string electionYear;
    ElectionStatistics statistics;
};
public type DistrictWinnerView record {
    string districtCode;
    string districtName;
    int electoralVotes;
    string winnerCandidateId;
    string winnerName;
    string winnerParty;
    string winnerColor;
    int winnerVotes;
};

public type ElectionStatistics record {
    int totalRegisteredVoters;
    int totalVotesCast;
    decimal turnoutPercentage;
    int totalCandidates;
    int totalDistricts;
    string electionStatus;
};

public type ProvinceResults record {
    string provinceName;
    store:DistrictResult[] districts;
    store:Candidate[] topCandidates;
    int totalVotes;
};

// Get complete election summary with all data needed for frontend
public function getCompleteElectionSummary() returns ElectionSummaryResponse|error {
    // Get candidates with their results
    store:Candidate[] candidates = check getCandidateResults();
    
    // Get district results
    store:DistrictResult[] districts = check getDistrictResults();
    
    // Calculate total votes
    int totalVotes = 0;
    foreach var candidate in candidates {
        totalVotes += candidate.popularVotes;
    }
    
    // Get statistics
    ElectionStatistics stats = check getElectionStatistics();
    
    return {
        candidates: candidates,
        districts: districts,
        totalVotes: totalVotes,
        lastUpdated: time:utcToString(time:utcNow()),
        electionYear: "2024",
        statistics: stats
    };
}


// Get election statistics
public function getElectionStatistics() returns ElectionStatistics|error {
    // Get candidates count
    stream<store:Candidate, persist:Error?> candidatesStream = dbClient->/candidates;
    store:Candidate[] candidates = check from store:Candidate candidate in candidatesStream
        select candidate;
    
    // Get districts count
    stream<store:DistrictResult, persist:Error?> districtsStream = dbClient->/districtresults;
    store:DistrictResult[] districts = check from store:DistrictResult district in districtsStream
        select district;
    
    // Calculate total votes
    int totalVotes = 0;
    foreach var candidate in candidates {
        totalVotes += candidate.popularVotes;
    }
    
    return {
        totalRegisteredVoters: 17500000,
        totalVotesCast: totalVotes,
        turnoutPercentage: <decimal>totalVotes / 17500000.0 * 100.0,
        totalCandidates: candidates.length(),
        totalDistricts: districts.length(),
        electionStatus: "COMPLETED"
    };
}

// Get results by province
public function getProvinceResults(string provinceName) returns ProvinceResults|error {
    // Get districts for the province
    stream<store:DistrictResult, persist:Error?> districtsStream = dbClient->/districtresults(whereClause = sql `WHERE province = ${provinceName}`);
    store:DistrictResult[] provinceDistricts = check from store:DistrictResult district in districtsStream
        select district;
    
    // Get top candidates
    stream<store:Candidate, persist:Error?> candidatesStream = dbClient->/candidates;
    store:Candidate[] candidates = check from store:Candidate candidate in candidatesStream
        select candidate;
    
    // Calculate total votes in province
    int totalVotes = 0;
    foreach var district in provinceDistricts {
        totalVotes += district.votesProcessed;
    }
    
    return {
        provinceName: provinceName,
        districts: provinceDistricts,
        topCandidates: candidates,
        totalVotes: totalVotes
    };
}

// Original functions
public function getElectionSummary() returns store:ElectionSummary[]|error {
    stream<store:ElectionSummary, persist:Error?> electionSummariesStream = dbClient->/electionsummaries;
    store:ElectionSummary[] electionSummaries = check from store:ElectionSummary electionSummary in electionSummariesStream
        select electionSummary;
    return electionSummaries;
}

public function getCandidateResults() returns store:Candidate[]|error {
    stream<store:Candidate, persist:Error?> candidatesStream = dbClient->/candidates;
    store:Candidate[] candidates = check from store:Candidate candidate in candidatesStream
        select candidate;
    return candidates;
}

public function getDistrictResults() returns store:DistrictResult[]|error {
    stream<store:DistrictResult, persist:Error?> districtsStream = dbClient->/districtresults;
    store:DistrictResult[] districts = check from store:DistrictResult district in districtsStream
        select district;
    return districts;
}

// Fixed function using query instead of direct access
public function getCandidateById(string candidateId, string electionId) returns store:Candidate|error {
    stream<store:Candidate, persist:Error?> candidatesStream = dbClient->/candidates(whereClause = sql `WHERE candidateId = ${candidateId} AND electionId = ${electionId}`);
    store:Candidate[] candidates = check from store:Candidate candidate in candidatesStream
        select candidate;
    
    if candidates.length() == 0 {
        return error("Candidate not found");
    }
    
    return candidates[0];
}

public function getDistrictById(string districtCode, string electionId) returns store:DistrictResult|error {
    stream<store:DistrictResult, persist:Error?> districtsStream = dbClient->/districtresults(whereClause = sql `WHERE districtCode = ${districtCode} AND electionId = ${electionId}`);
    store:DistrictResult[] districts = check from store:DistrictResult district in districtsStream
        select district;
    
    if districts.length() == 0 {
        return error("District not found");
    }
    
    return districts[0];
}

// Alternative: Simple versions without composite keys (for testing)
public function getCandidateByIdSimple(string candidateId) returns store:Candidate|error {
    stream<store:Candidate, persist:Error?> candidatesStream = dbClient->/candidates(whereClause = sql `WHERE candidateId = ${candidateId}`);
    store:Candidate[] candidates = check from store:Candidate candidate in candidatesStream
        select candidate;
    
    if candidates.length() == 0 {
        return error("Candidate not found");
    }
    
    return candidates[0];
}

public function getDistrictByIdSimple(string districtCode) returns store:DistrictResult|error {
    stream<store:DistrictResult, persist:Error?> districtsStream = dbClient->/districtresults(whereClause = sql `WHERE districtCode = ${districtCode}`);
    store:DistrictResult[] districts = check from store:DistrictResult district in districtsStream
        select district;
    
    if districts.length() == 0 {
        return error("District not found");
    }
    
    return districts[0];
}

// Update functions using queries

public function getDistrictWinnersView() returns DistrictWinnerView[]|error {
    // Get all district results
    stream<store:DistrictResult, persist:Error?> districtsStream = dbClient->/districtresults;
    store:DistrictResult[] districts = check from store:DistrictResult district in districtsStream
        select district;

    // Get all candidates and create a map for efficient lookup
    stream<store:Candidate, persist:Error?> candidatesStream = dbClient->/candidates;
    store:Candidate[] candidates = check from store:Candidate candidate in candidatesStream
        select candidate;
    
    map<store:Candidate> candidateMap = {};
    foreach var candidate in candidates {
        candidateMap[candidate.candidateId] = candidate;
    }

    // Create the view by joining district results with winners
    DistrictWinnerView[] districtWinners = [];
    foreach var district in districts {
        if district.winner is string {
            string winnerId = <string>district.winner;
            if candidateMap.hasKey(winnerId) {
                store:Candidate winner = candidateMap.get(winnerId);
                DistrictWinnerView winnerView = {
                    districtCode: district.districtCode,
                    districtName: district.districtName,
                    electoralVotes: district.totalVotes / 1000, // Placeholder logic
                    winnerCandidateId: winner.candidateId,
                    winnerName: winner.candidateName,
                    winnerParty: winner.partyName,
                    winnerColor: winner.partyColor,
                    winnerVotes: district.votesProcessed
                };
                districtWinners.push(winnerView);
            }
        }
    }
    
    return districtWinners;
}
