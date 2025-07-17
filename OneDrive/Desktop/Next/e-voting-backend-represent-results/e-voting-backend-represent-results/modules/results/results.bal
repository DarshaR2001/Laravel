import online_election.store;
import ballerina/persist;
import ballerina/http;
import ballerina/time;

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


public type CandidateUpdateRequest record {
    int popularVotes;
    int electoralVotes;
};

public type DistrictUpdateRequest record {
    string winner;
    decimal margin;
    int votesProcessed;
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
    stream<store:DistrictResult, persist:Error?> districtsStream = dbClient->/districtresults;
    store:DistrictResult[] provinceDistricts = check from store:DistrictResult district in districtsStream
        where district.province == provinceName
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
public function getElectionSummary() returns store:electionSummary[]|error {
    stream<store:electionSummary, persist:Error?> electionSummariesStream = dbClient->/electionsummaries;
    store:electionSummary[] electionSummaries = check from store:electionSummary electionSummary in electionSummariesStream
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
    stream<store:Candidate, persist:Error?> candidatesStream = dbClient->/candidates;
    store:Candidate[] candidates = check from store:Candidate candidate in candidatesStream
        where candidate.candidateId == candidateId && candidate.electionId == electionId
        select candidate;
    
    if candidates.length() == 0 {
        return error("Candidate not found");
    }
    
    return candidates[0];
}

public function getDistrictById(string districtCode, string electionId) returns store:DistrictResult|error {
    stream<store:DistrictResult, persist:Error?> districtsStream = dbClient->/districtresults;
    store:DistrictResult[] districts = check from store:DistrictResult district in districtsStream
        where district.districtCode == districtCode && district.electionId == electionId
        select district;
    
    if districts.length() == 0 {
        return error("District not found");
    }
    
    return districts[0];
}

// Alternative: Simple versions without composite keys (for testing)
public function getCandidateByIdSimple(string candidateId) returns store:Candidate|error {
    stream<store:Candidate, persist:Error?> candidatesStream = dbClient->/candidates;
    store:Candidate[] candidates = check from store:Candidate candidate in candidatesStream
        where candidate.candidateId == candidateId
        select candidate;
    
    if candidates.length() == 0 {
        return error("Candidate not found");
    }
    
    return candidates[0];
}

public function getDistrictByIdSimple(string districtCode) returns store:DistrictResult|error {
    stream<store:DistrictResult, persist:Error?> districtsStream = dbClient->/districtresults;
    store:DistrictResult[] districts = check from store:DistrictResult district in districtsStream
        where district.districtCode == districtCode
        select district;
    
    if districts.length() == 0 {
        return error("District not found");
    }
    
    return districts[0];
}

// Update functions using queries
public function updateCandidateResults(string candidateId, string electionId, CandidateUpdateRequest updateData) returns store:Candidate|error {
    // First get the candidate
    store:Candidate candidate = check getCandidateById(candidateId, electionId);
    
    // For now, return the candidate (update functionality would need custom SQL)
    // This is a limitation of Ballerina persist with composite keys
    return candidate;
}

public function updateDistrictResults(string districtCode, string electionId, DistrictUpdateRequest updateData) returns store:DistrictResult|error {
    // First get the district
    store:DistrictResult district = check getDistrictById(districtCode, electionId);
    
    // For now, return the district (update functionality would need custom SQL)
    // This is a limitation of Ballerina persist with composite keys
    return district;
}

// WebSocket handler for real-time updates (optional)
public function handleWebSocketConnection() returns http:Response|error {
    return new http:Response();
}
