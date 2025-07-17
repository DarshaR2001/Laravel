import ballerina/time;

# Update types for API operations (these are NOT persist entities)
# + popularVotes - Updated number of popular votes
# + electoralVotes - Updated number of electoral votes
# + position - Candidate’s position (1st, 2nd, etc.)
# + updatedAt - Time when the candidate’s record was last updated
public type CandidateUpdate record {| 
    int? popularVotes;
    int? electoralVotes;
    int? position;
    time:Utc? updatedAt;
|};

public type DistrictResultUpdate record {|
    int? votesProcessed;
    string? winner;
    decimal? margin;
    decimal? turnoutPercentage;
    string? status;
    time:Utc? updatedAt;
|};

public type ElectionSummaryUpdate record {|
    int? totalVotesCast;
    int? totalValidVotes;
    int? totalRejectedVotes;
    decimal? turnoutPercentage;
    string? winnerCandidateId;
    decimal? winningMargin;
    string? electionStatus;
    int? completedDistricts;
    boolean? resultsPublished;
    time:Utc? lastUpdated;
|};
