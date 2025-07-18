import online_election.store;
import ballerina/http;

@http:ServiceConfig {
    basePath: "/results"
}
service on new http:Listener(8080) {
    resource function get .() returns store:Result[]|error {
        return store:getResults();
    }
}