// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

import ballerina/time;

public type Voter record {|
    readonly string id;
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
|};

public type VoterOptionalized record {|
    string id?;
    string nationalId?;
    string fullName?;
    string? mobileNumber?;
    string? dob?;
    string? gender?;
    string? nicChiefOccupant?;
    string? address?;
    string? district?;
    string? householdNo?;
    string? gramaNiladhari?;
    string password?;
|};

public type VoterTargetType typedesc<VoterOptionalized>;

public type VoterInsert Voter;

public type VoterUpdate record {|
    string nationalId?;
    string fullName?;
    string? mobileNumber?;
    string? dob?;
    string? gender?;
    string? nicChiefOccupant?;
    string? address?;
    string? district?;
    string? householdNo?;
    string? gramaNiladhari?;
    string password?;
|};

public type Election record {|
    readonly string id;
    string electionName;
    string description;
    time:Date startDate;
    time:Date enrolDdl;
    time:Date endDate;
    int noOfCandidates;
|};

public type ElectionOptionalized record {|
    string id?;
    string electionName?;
    string description?;
    time:Date startDate?;
    time:Date enrolDdl?;
    time:Date endDate?;
    int noOfCandidates?;
|};

public type ElectionTargetType typedesc<ElectionOptionalized>;

public type ElectionInsert Election;

public type ElectionUpdate record {|
    string electionName?;
    string description?;
    time:Date startDate?;
    time:Date enrolDdl?;
    time:Date endDate?;
    int noOfCandidates?;
|};

public type Candidate record {|
    readonly string candidateId;
    string partyName;
    string candidateName;
|};

public type CandidateOptionalized record {|
    string candidateId?;
    string partyName?;
    string candidateName?;
|};

public type CandidateTargetType typedesc<CandidateOptionalized>;

public type CandidateInsert Candidate;

public type CandidateUpdate record {|
    string partyName?;
    string candidateName?;
|};

public type Votes record {|
    readonly string voteId;
    string electionId;
    string candidateId;
    int numberOfVotes;
|};

public type VotesOptionalized record {|
    string voteId?;
    string electionId?;
    string candidateId?;
    int numberOfVotes?;
|};

public type VotesTargetType typedesc<VotesOptionalized>;

public type VotesInsert Votes;

public type VotesUpdate record {|
    string electionId?;
    string candidateId?;
    int numberOfVotes?;
|};

public type electionSummary record {|
    readonly string electionId;
    string registeredVotes;
    string publishVotes;
    int rejectedVotes;
|};

public type electionSummaryOptionalized record {|
    string electionId?;
    string registeredVotes?;
    string publishVotes?;
    int rejectedVotes?;
|};

public type electionSummaryTargetType typedesc<electionSummaryOptionalized>;

public type electionSummaryInsert electionSummary;

public type electionSummaryUpdate record {|
    string registeredVotes?;
    string publishVotes?;
    int rejectedVotes?;
|};

