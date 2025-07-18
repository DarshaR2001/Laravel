import ballerinax/persist.sql;
import ballerina/time;

public type Result record {|
    readonly int id;
    string election_id;
    string candidate_id;
    int votes;
|};

public entity ResultEntity {
    *Result;

    /electionId ["election_id"];
    /candidateId ["candidate_id"];
}