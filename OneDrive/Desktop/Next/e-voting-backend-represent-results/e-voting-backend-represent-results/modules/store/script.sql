-- AUTO-GENERATED FILE.

-- This file is an auto-generated file by Ballerina persistence layer for model.
-- Please verify the generated scripts and execute them against the target DB server.

DROP TABLE IF EXISTS "Candidate";
DROP TABLE IF EXISTS "Voter";
DROP TABLE IF EXISTS "Election";
DROP TABLE IF EXISTS "DistrictResult";
DROP TABLE IF EXISTS "electionSummary";

CREATE TABLE "electionSummary" (
	"electionId" VARCHAR(191) NOT NULL,
	"total_registered_voters" INT NOT NULL,
	"total_votes_cast" INT NOT NULL,
	"total_rejected_votes" INT NOT NULL,
	"turnout_percentage" DECIMAL(65,30) NOT NULL,
	"winner_candidate_id" VARCHAR(191),
	"election_status" VARCHAR(191) NOT NULL,
	PRIMARY KEY("electionId")
);

CREATE TABLE "DistrictResult" (
	"district_code" VARCHAR(191) NOT NULL,
	"election_id" VARCHAR(191) NOT NULL,
	"district_name" VARCHAR(191) NOT NULL,
	"province" VARCHAR(191) NOT NULL,
	"total_votes" INT NOT NULL,
	"votes_processed" INT NOT NULL,
	"winner" VARCHAR(191),
	"margin" DECIMAL(65,30) NOT NULL,
	"status" VARCHAR(191) NOT NULL,
	PRIMARY KEY("district_code","election_id")
);

CREATE TABLE "Election" (
	"id" VARCHAR(191) NOT NULL,
	"election_name" VARCHAR(191) NOT NULL,
	"description" VARCHAR(191) NOT NULL,
	"start_date" DATE NOT NULL,
	"enrol_ddl" DATE NOT NULL,
	"end_date" DATE NOT NULL,
	"no_of_candidates" INT NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE "Voter" (
	"id" VARCHAR(191) NOT NULL,
	"national_id" VARCHAR(191) NOT NULL,
	"full_name" VARCHAR(191) NOT NULL,
	"mobile_number" VARCHAR(191),
	"dob" VARCHAR(191),
	"gender" VARCHAR(191),
	"nic_chief_occupant" VARCHAR(191),
	"address" VARCHAR(191),
	"district" VARCHAR(191),
	"household_no" VARCHAR(191),
	"grama_niladhari" VARCHAR(191),
	"password" VARCHAR(191) NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE "Candidate" (
	"candidate_id" VARCHAR(191) NOT NULL,
	"election_id" VARCHAR(191) NOT NULL,
	"candidate_name" VARCHAR(191) NOT NULL,
	"party_name" VARCHAR(191) NOT NULL,
	"party_symbol" VARCHAR(191),
	"party_color" VARCHAR(191) NOT NULL,
	"candidate_image" VARCHAR(191),
	"popular_votes" INT NOT NULL,
	"electoral_votes" INT NOT NULL,
	"position" INT,
	"is_active" BOOLEAN NOT NULL,
	PRIMARY KEY("candidate_id","election_id")
);


