import ballerina/persist as _;
import ballerinax/persist.sql;
import ballerina/time;

# Description.
#
# + id - Voter ID (Auto-incrementing Primary Key)
# + nationalId - National Identity Card Number (Unique Identifier)
# + fullName - Full Name of the voter
# + mobileNumber - Contact Number (Nullable)
# + dob - Date of Birth (Stored as String MM/DD/YYYY)
# + gender - Gender (Male/Female - Nullable)
# + nicChiefOccupant - NIC of Chief Occupant (Nullable)
# + address - Registered Address of the voter
# + district - Voter's District
# + householdNo - Household Number (Nullable)
# + gramaNiladhari - Grama Niladhari Division (Nullable)
# + password - Hashed Password for Authentication

public type Voter record {|
    readonly string id;
    @sql:Name { value: "national_id" }
    string nationalId;
    @sql:Name { value: "full_name" }
    string fullName;
    @sql:Name { value: "mobile_number" }
    string? mobileNumber;
    string? dob;
    string? gender;
    @sql:Name { value: "nic_chief_occupant" }
    string? nicChiefOccupant;
    string? address;
    string? district;
    @sql:Name { value: "household_no" }
    string? householdNo;
    @sql:Name { value: "grama_niladhari" }
    string? gramaNiladhari;
    string password;
|};

# Description for elections to be insterted.
#
# + id - election id (Primary Key)
# + electionName - election title
# + description - election description
# + startDate - election start date
# + enrolDdl - election enrollment deadline
# + endDate - election end date
# + noOfCandidates - election number of candidates

public type Election record {|
    readonly string id;
    @sql:Name {value: "election_name"}
    string electionName;
    string description;
    @sql:Name {value: "start_date"}
    time:Date startDate;
    @sql:Name {value: "enrol_ddl"}
    time:Date enrolDdl;
    @sql:Name {value: "end_date"}
    time:Date endDate;
    @sql:Name {value: "no_of_candidates"}
    int noOfCandidates;
|};

# Enhanced Candidates table for Sri Lanka Electoral System
# + candidateId - Candidate id (Primary Key)
# + electionId - Reference to election
# + candidateName - Full name of the candidate
# + partyName - Political party name
# + partySymbol - Party symbol (e.g., "Compass", "Telephone")
# + partyColor - Party color in hex format
# + candidateImage - URL/path to candidate image
# + popularVotes - Total popular votes received
# + electoralVotes - Electoral votes (district wins)
# + position - Final position in election (1st, 2nd, etc.)
# + isActive - Whether candidate is active
public type Candidate record {| 
    @sql:Name {value: "candidate_id"}
    readonly string candidateId;
    @sql:Name {value: "election_id"}
    readonly string electionId;
    @sql:Name {value: "candidate_name"}
    string candidateName;
    @sql:Name {value: "party_name"}
    string partyName;
    @sql:Name {value: "party_symbol"}
    string? partySymbol;
    @sql:Name {value: "party_color"}
    string partyColor;
    @sql:Name {value: "candidate_image"}
    string? candidateImage;
    @sql:Name {value: "popular_votes"}
    int popularVotes;
    @sql:Name {value: "electoral_votes"}
    int electoralVotes;
    int? position;
    @sql:Name {value: "is_active"}
    boolean isActive;
|};


# District Results table for detailed electoral analysis
# + districtCode - District code (Primary Key)
# + electionId - Reference to election
# + districtName - Full district name
# + province - Province name                           //dont need
# + totalVotes - Total electoral votes for district
# + votesProcessed - Number of votes processed
# + winner - Winning candidate ID
# + margin - Victory margin percentage                 // no need 
# + status - Counting status (PENDING, COUNTING, COMPLETED)
public type DistrictResult record {| 
    @sql:Name {value: "district_code"}
    readonly string districtCode;
    @sql:Name {value: "election_id"}
    readonly string electionId;
    @sql:Name {value: "district_name"}
    string districtName;
    string province;
    @sql:Name {value: "total_votes"}
    int totalVotes;
    @sql:Name {value: "votes_processed"}
    int votesProcessed;
    string? winner;
    decimal margin;
    string status;
|};



# Comprehensive Election Summary
# + electionId - Election ID (Primary Key)
# + totalRegisteredVoters - Total registered voters nationwide
# + totalVotesCast - Total votes cast
# + totalRejectedVotes - Rejected votes count
# + turnoutPercentage - Overall turnout percentage
# + winnerCandidateId - ID of winning candidate
# + electionStatus - Current election status
public type electionSummary record {| 
    readonly string electionId;
    @sql:Name {value: "total_registered_voters"}
    int totalRegisteredVoters;
    @sql:Name {value: "total_votes_cast"}
    int totalVotesCast;
    @sql:Name {value: "total_rejected_votes"}
    int totalRejectedVotes;
    @sql:Name {value: "turnout_percentage"}
    decimal turnoutPercentage;
    @sql:Name {value: "winner_candidate_id"}
    string? winnerCandidateId;
    @sql:Name {value: "election_status"}
    string electionStatus;
|};
