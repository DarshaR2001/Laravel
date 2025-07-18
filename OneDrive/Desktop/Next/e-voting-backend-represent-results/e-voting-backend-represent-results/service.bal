import online_election.auth;
import online_election.election;
import online_election.store;
import ballerina/http;
import online_election.results;
import ballerina/time;

// Single listener for all services
listener http:Listener SharedListener = new (8080);

// Voter registration service
 service /voter\-registration/api/v1 on SharedListener {
//     // Register a new voter
     resource function post voters/register(store:Voter newVoter)
    returns http:Created|http:Forbidden|error {
        return check auth:registerVoter(newVoter);
    }
    
//     // Voter Login
    resource function post voters/login(auth:VoterLogin loginDetails)
    returns http:Response|http:Unauthorized|error {
        return check auth:loginVoter(loginDetails);
    }
 }

// Election management service
 service /election/api/v1 on SharedListener {
    resource function get elections() returns store:Election[]|error {
        return check election:getElections();
    }
    
   resource function get elections/[string electionId]() returns store:Election|error {
       return check election:getOneElection(electionId);
   }
    
    resource function post elections/create(@http:Header string authorization, election:ElectionConfig newElectionConfig)
    returns http:Created|http:Forbidden|error {
        return check election:createElection(newElectionConfig);
    }
    
    resource function put elections/[string electionId]/update(@http:Header string authorization, store:ElectionUpdate updatedElection)
    returns http:Ok|http:Forbidden|error {
         return check election:updateElection(electionId, updatedElection);
     }
    
     resource function delete elections/[string electionId]/delete(@http:Header string authorization)
     returns http:NoContent|http:Forbidden|error {
        return check election:deleteElection(electionId);
    }
 }

// Results service for frontend integration (FIXED - using same listener)
@http:ServiceConfig {
    cors: {
        allowOrigins: ["http://localhost:3000", "https://your-frontend-domain.com"],
        allowCredentials: false,
        allowHeaders: ["CORELATION_ID", "Authorization", "Content-Type"],
        allowMethods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
        maxAge: 84900
    }
}
service /api/election on SharedListener {
    
    // Health check endpoint
    resource function get health() returns json {
        return {
            "status": "healthy",
            "service": "Sri Lanka Election Results API",
            "timestamp": time:utcToString(time:utcNow())
        };
    }
    
    // Main endpoint for frontend - Get complete election summary
    resource function get summary() returns results:ElectionSummaryResponse|error {
        return check results:getCompleteElectionSummary();
    }
    
    // Get all candidate results
    resource function get candidates() returns store:Candidate[]|error {
        return check results:getCandidateResults();
    }
    
    // Get specific candidate by ID (FIXED - using simple version)
    resource function get candidates/[string candidateId]() returns store:Candidate|error {
        return check results:getCandidateByIdSimple(candidateId);
    }
    
    // Get specific candidate with election ID (composite key version)
    resource function get candidates/[string candidateId]/[string electionId]() returns store:Candidate|error {
        return check results:getCandidateById(candidateId, electionId);
    }
    
    // Get all district results
    resource function get districts() returns store:DistrictResult[]|error {
        return check results:getDistrictResults();
    }
    
    // Get specific district by code (FIXED - using simple version)
    resource function get districts/[string districtCode]() returns store:DistrictResult|error {
        return check results:getDistrictByIdSimple(districtCode);
    }
    
    // Get specific district with election ID (composite key version)
    resource function get districts/[string districtCode]/[string electionId]() returns store:DistrictResult|error {
        return check results:getDistrictById(districtCode, electionId);
    }
    
    // Get election statistics
    resource function get statistics() returns results:ElectionStatistics|error {
        return check results:getElectionStatistics();
    }
    
    // Get results by province
    resource function get provinces/[string provinceName]() returns results:ProvinceResults|error {
        return check results:getProvinceResults(provinceName);
    }
    
    // Get district winners view
    resource function get district-winners() returns results:DistrictWinnerView[]|error {
        return check results:getDistrictWinnersView();
    }
}

