import online_election.results.types;
import ballerina/persist;
import ballerina/sql;

final persist:Store store = new;

public function getResults() returns Result[]|error {
    return from var result in store->/results select result;
}