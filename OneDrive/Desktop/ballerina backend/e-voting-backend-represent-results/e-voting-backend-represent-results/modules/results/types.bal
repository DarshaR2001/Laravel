public type Election record {
    string id;
    string electionName;
    string description;
    string startDate; // Could be string or `time:Utc` if you want to parse
    string enrolDdl;
    string endDate;
    int noOfCandidates;
};

public type Candidate record {
    string candidateId;
    string partyName;
    string candidateName;
};

public type Vote record {
    string voteId;
    string electionId;
    string candidateId;
    int numberOfVotes;
};

public type Voter record {
    string id;
    string nationalId;
    string fullName;
    string? mobileNumber;
    string? dob;
    string? gender;
    string? nicChiefOccupant;
    string? address;
    string? district;
    string? householdNo;
    string? gramaNiladhari;
    string password;
};

public type ElectionSummary record {
    string electionId;
    string registeredVotes;
    string publishVotes;
    int rejectedVotes;
};

# Complete election result
#
# + electionId - election id
# + summary - election summary
# + candidates - list of candidate results
# + totalVotes - total votes cast
public type ElectionResult record {|
    string electionId;
    ElectionSummary summary;
    CandidateResult[] candidates;
    int totalVotes;
|};

# Candidate result with vote details
#
# + candidateId - candidate id
# + candidateName - candidate name
# + partyName - party name
# + electoralVotes - electoral votes received
# + popularVotes - popular votes received
# + popularVotePercentage - percentage of popular votes


public type CandidateResult record {|
    string candidateId;
    string candidateName;
    string partyName;
    int electoralVotes;
    int popularVotes;
    decimal popularVotePercentage;
|};
