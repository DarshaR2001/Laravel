import online_election.store;
import ballerina/persist;

final store:Client dbClient = check new ();



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
