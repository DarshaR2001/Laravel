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
    time:Civil startDate;
    time:Civil enrolDdl;
    time:Civil endDate;
    int noOfCandidates;
|};

public type ElectionOptionalized record {|
    string id?;
    string electionName?;
    string description?;
    time:Civil startDate?;
    time:Civil enrolDdl?;
    time:Civil endDate?;
    int noOfCandidates?;
|};

public type ElectionTargetType typedesc<ElectionOptionalized>;

public type ElectionInsert Election;

public type ElectionUpdate record {|
    string electionName?;
    string description?;
    time:Civil startDate?;
    time:Civil enrolDdl?;
    time:Civil endDate?;
    int noOfCandidates?;
|};

public type Candidate record {|
    readonly string candidateId;
    string electionId;
    string candidateName;
    string partyName;
    string? partySymbol;
    string partyColor;
    string? candidateImage;
    int popularVotes;
    int electoralVotes;
    int? position;
    boolean isActive;
|};

public type CandidateOptionalized record {|
    string candidateId?;
    string electionId?;
    string candidateName?;
    string partyName?;
    string? partySymbol?;
    string partyColor?;
    string? candidateImage?;
    int popularVotes?;
    int electoralVotes?;
    int? position?;
    boolean isActive?;
|};

public type CandidateTargetType typedesc<CandidateOptionalized>;

public type CandidateInsert Candidate;

public type CandidateUpdate record {|
    string electionId?;
    string candidateName?;
    string partyName?;
    string? partySymbol?;
    string partyColor?;
    string? candidateImage?;
    int popularVotes?;
    int electoralVotes?;
    int? position?;
    boolean isActive?;
|};

public type DistrictResult record {|
    readonly string districtCode;
    readonly string electionId;
    string districtName;
    int totalVotes;
    int votesProcessed;
    string? winner;
    string status;
|};

public type DistrictResultOptionalized record {|
    string districtCode?;
    string electionId?;
    string districtName?;
    int totalVotes?;
    int votesProcessed?;
    string? winner?;
    string status?;
|};

public type DistrictResultTargetType typedesc<DistrictResultOptionalized>;

public type DistrictResultInsert DistrictResult;

public type DistrictResultUpdate record {|
    string districtName?;
    int totalVotes?;
    int votesProcessed?;
    string? winner?;
    string status?;
|};

public type ElectionSummary record {|
    readonly string electionId;
    int totalRegisteredVoters;
    int totalVotesCast;
    int totalRejectedVotes;
    decimal turnoutPercentage;
    string? winnerCandidateId;
    string electionStatus;
|};

public type ElectionSummaryOptionalized record {|
    string electionId?;
    int totalRegisteredVoters?;
    int totalVotesCast?;
    int totalRejectedVotes?;
    decimal turnoutPercentage?;
    string? winnerCandidateId?;
    string electionStatus?;
|};

public type ElectionSummaryTargetType typedesc<ElectionSummaryOptionalized>;

public type ElectionSummaryInsert ElectionSummary;

public type ElectionSummaryUpdate record {|
    int totalRegisteredVoters?;
    int totalVotesCast?;
    int totalRejectedVotes?;
    decimal turnoutPercentage?;
    string? winnerCandidateId?;
    string electionStatus?;
|};

