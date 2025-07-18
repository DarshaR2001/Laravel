// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

import ballerina/jballerina.java;
import ballerina/persist;
import ballerina/sql;
import ballerinax/persist.sql as psql;
import ballerinax/postgresql;
import ballerinax/postgresql.driver as _;
import ballerina/time;

const VOTER = "voters";
const ELECTION = "elections";
const CANDIDATE = "candidates";
const DISTRICT_RESULT = "districtresults";
const ELECTION_SUMMARY = "electionsummaries";

public isolated client class Client {
    *persist:AbstractPersistClient;

    private final postgresql:Client dbClient;

    private final map<psql:SQLClient> persistClients;

    private final record {|psql:SQLMetadata...;|} & readonly metadata = {
        [VOTER]: {
            entityName: "Voter",
            tableName: "Voter",
            fieldMetadata: {
                id: {columnName: "id"},
                nationalId: {columnName: "national_id"},
                fullName: {columnName: "full_name"},
                mobileNumber: {columnName: "mobile_number"},
                dob: {columnName: "dob"},
                gender: {columnName: "gender"},
                nicChiefOccupant: {columnName: "nic_chief_occupant"},
                address: {columnName: "address"},
                district: {columnName: "district"},
                householdNo: {columnName: "household_no"},
                gramaNiladhari: {columnName: "grama_niladhari"},
                password: {columnName: "password"}
            },
            keyFields: ["id"]
        },
        [ELECTION]: {
            entityName: "Election",
            tableName: "Election",
            fieldMetadata: {
                id: {columnName: "id"},
                electionName: {columnName: "election_name"},
                description: {columnName: "description"},
                startDate: {columnName: "start_date"},
                enrolDdl: {columnName: "enrol_ddl"},
                endDate: {columnName: "end_date"},
                noOfCandidates: {columnName: "no_of_candidates"}
            },
            keyFields: ["id"]
        },
        [CANDIDATE]: {
            entityName: "Candidate",
            tableName: "Candidate",
            fieldMetadata: {
                candidateId: {columnName: "candidate_id"},
                electionId: {columnName: "election_id"},
                candidateName: {columnName: "candidate_name"},
                partyName: {columnName: "party_name"},
                partySymbol: {columnName: "party_symbol"},
                partyColor: {columnName: "party_color"},
                candidateImage: {columnName: "candidate_image"},
                popularVotes: {columnName: "popular_votes"},
                electoralVotes: {columnName: "electoral_votes"},
                position: {columnName: "position"},
                isActive: {columnName: "is_active"}
            },
            keyFields: ["candidateId"]
        },
        [DISTRICT_RESULT]: {
            entityName: "DistrictResult",
            tableName: "DistrictResult",
            fieldMetadata: {
                districtCode: {columnName: "district_code"},
                electionId: {columnName: "election_id"},
                districtName: {columnName: "district_name"},
                totalVotes: {columnName: "total_votes"},
                votesProcessed: {columnName: "votes_processed"},
                winner: {columnName: "winner"},
                status: {columnName: "status"}
            },
            keyFields: ["districtCode", "electionId"]
        },
        [ELECTION_SUMMARY]: {
            entityName: "ElectionSummary",
            tableName: "ElectionSummary",
            fieldMetadata: {
                electionId: {columnName: "electionId"},
                totalRegisteredVoters: {columnName: "total_registered_voters"},
                totalVotesCast: {columnName: "total_votes_cast"},
                totalRejectedVotes: {columnName: "total_rejected_votes"},
                turnoutPercentage: {columnName: "turnout_percentage"},
                winnerCandidateId: {columnName: "winner_candidate_id"},
                electionStatus: {columnName: "election_status"}
            },
            keyFields: ["electionId"]
        }
    };

    public isolated function init() returns persist:Error? {
        postgresql:Client|error dbClient = new (host = host, username = user, password = password, database = database, port = port, options = connectionOptions);
        if dbClient is error {
            return <persist:Error>error(dbClient.message());
        }
        self.dbClient = dbClient;
        self.persistClients = {
            [VOTER]: check new (dbClient, self.metadata.get(VOTER), psql:POSTGRESQL_SPECIFICS),
            [ELECTION]: check new (dbClient, self.metadata.get(ELECTION), psql:POSTGRESQL_SPECIFICS),
            [CANDIDATE]: check new (dbClient, self.metadata.get(CANDIDATE), psql:POSTGRESQL_SPECIFICS),
            [DISTRICT_RESULT]: check new (dbClient, self.metadata.get(DISTRICT_RESULT), psql:POSTGRESQL_SPECIFICS),
            [ELECTION_SUMMARY]: check new (dbClient, self.metadata.get(ELECTION_SUMMARY), psql:POSTGRESQL_SPECIFICS)
        };
    }

    isolated resource function get voters(VoterTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor",
        name: "query"
    } external;

    isolated resource function get voters/[string id](VoterTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post voters(VoterInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(VOTER);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from VoterInsert inserted in data
            select inserted.id;
    }

    isolated resource function put voters/[string id](VoterUpdate value) returns Voter|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(VOTER);
        }
        _ = check sqlClient.runUpdateQuery(id, value);
        return self->/voters/[id].get();
    }

    isolated resource function delete voters/[string id]() returns Voter|persist:Error {
        Voter result = check self->/voters/[id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(VOTER);
        }
        _ = check sqlClient.runDeleteQuery(id);
        return result;
    }

    isolated resource function get elections(ElectionTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor",
        name: "query"
    } external;

    isolated resource function get elections/[string id](ElectionTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post elections(ElectionInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ELECTION);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from ElectionInsert inserted in data
            select inserted.id;
    }

    isolated resource function put elections/[string id](ElectionUpdate value) returns Election|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ELECTION);
        }
        _ = check sqlClient.runUpdateQuery(id, value);
        return self->/elections/[id].get();
    }

    isolated resource function delete elections/[string id]() returns Election|persist:Error {
        Election result = check self->/elections/[id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ELECTION);
        }
        _ = check sqlClient.runDeleteQuery(id);
        return result;
    }

    isolated resource function get candidates(CandidateTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor",
        name: "query"
    } external;

    isolated resource function get candidates/[string candidateId](CandidateTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post candidates(CandidateInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(CANDIDATE);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from CandidateInsert inserted in data
            select inserted.candidateId;
    }

    isolated resource function put candidates/[string candidateId](CandidateUpdate value) returns Candidate|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(CANDIDATE);
        }
        _ = check sqlClient.runUpdateQuery(candidateId, value);
        return self->/candidates/[candidateId].get();
    }

    isolated resource function delete candidates/[string candidateId]() returns Candidate|persist:Error {
        Candidate result = check self->/candidates/[candidateId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(CANDIDATE);
        }
        _ = check sqlClient.runDeleteQuery(candidateId);
        return result;
    }

    isolated resource function get districtresults(DistrictResultTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor",
        name: "query"
    } external;

    isolated resource function get districtresults/[string districtCode]/[string electionId](DistrictResultTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post districtresults(DistrictResultInsert[] data) returns [string, string][]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(DISTRICT_RESULT);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from DistrictResultInsert inserted in data
            select [inserted.districtCode, inserted.electionId];
    }

    isolated resource function put districtresults/[string districtCode]/[string electionId](DistrictResultUpdate value) returns DistrictResult|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(DISTRICT_RESULT);
        }
        _ = check sqlClient.runUpdateQuery({"districtCode": districtCode, "electionId": electionId}, value);
        return self->/districtresults/[districtCode]/[electionId].get();
    }

    isolated resource function delete districtresults/[string districtCode]/[string electionId]() returns DistrictResult|persist:Error {
        DistrictResult result = check self->/districtresults/[districtCode]/[electionId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(DISTRICT_RESULT);
        }
        _ = check sqlClient.runDeleteQuery({"districtCode": districtCode, "electionId": electionId});
        return result;
    }

    isolated resource function get electionsummaries(ElectionSummaryTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor",
        name: "query"
    } external;

    isolated resource function get electionsummaries/[string electionId](ElectionSummaryTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post electionsummaries(ElectionSummaryInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ELECTION_SUMMARY);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from ElectionSummaryInsert inserted in data
            select inserted.electionId;
    }

    isolated resource function put electionsummaries/[string electionId](ElectionSummaryUpdate value) returns ElectionSummary|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ELECTION_SUMMARY);
        }
        _ = check sqlClient.runUpdateQuery(electionId, value);
        return self->/electionsummaries/[electionId].get();
    }

    isolated resource function delete electionsummaries/[string electionId]() returns ElectionSummary|persist:Error {
        ElectionSummary result = check self->/electionsummaries/[electionId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ELECTION_SUMMARY);
        }
        _ = check sqlClient.runDeleteQuery(electionId);
        return result;
    }

    remote isolated function queryNativeSQL(sql:ParameterizedQuery sqlQuery, typedesc<record {}> rowType = <>) returns stream<rowType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor"
    } external;

    remote isolated function executeNativeSQL(sql:ParameterizedQuery sqlQuery) returns psql:ExecutionResult|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor"
    } external;

    public isolated function close() returns persist:Error? {
        error? result = self.dbClient.close();
        if result is error {
            return <persist:Error>error(result.message());
        }
        return result;
    }
}

