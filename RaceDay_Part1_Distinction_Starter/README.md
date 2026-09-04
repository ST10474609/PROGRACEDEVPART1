# RaceDay — Part 1 Portfolio of Evidence

## Project Overview

RaceDay is a planned full-stack event management system designed around road running, walking and cycling events in South Africa.

For Part 1, my main focus was on planning the system properly before moving on to the actual application development. I started by designing the database structure, planning the API endpoints and preparing the documentation that will be used during the later parts of the project.

The main work completed in this part includes:

* Entity Relationship Diagram (ERD)
* API endpoint planning
* SQL Server database creation and sample data
* GitHub Actions validation
* Documentation of the system roles and database design decisions

The purpose of this part is to make sure that the structure of the system is clear before I start developing the API and user interface.

## System Roles

RaceDay has two main types of users: **Organisers** and **Participants**.

### Organiser

An organiser will be responsible for managing the events they create. They will be able to:

* Create new events
* Edit their events
* Delete their events
* Create and manage categories for their events
* View participants who have enrolled in their events
* Record and manage participant results

### Participant

Participants will use the system mainly to find and enter events. They will be able to:

* Register for an account
* Log in to the system
* Browse available events
* Select a category and enter an event
* View their own event enrolments
* View their results and performance history

The actual role and ownership checks will be implemented in the API during Part 2 and will then be connected to the MVC interface in Part 3.

## Repository Structure

I have organised the project so that the planning and database documentation is kept inside the `docs` folder.

```text
RaceDay/
├── .github/
│   └── workflows/
│       └── validate-part1.yml
├── docs/
│   ├── API_Endpoint_Plan.md
│   ├── ERD.md
│   ├── RaceDay_Database.sql
│   ├── RaceDay_ERD.png
│   └── RaceDay_ERD.pdf
└── README.md
```

This structure keeps the Part 1 documentation separate from the application code that will be added in the next parts.

## Database Design

For the database, I decided to use six main entities:

1. `Users` — stores the users of the system, including Organisers and Participants.
2. `Events` — stores the events created by organisers.
3. `EventRoutes` — stores the route information connected to each event.
4. `Categories` — stores the different categories available for an event.
5. `Enrolments` — keeps track of participants entering specific categories.
6. `Results` — stores the results and finishing information for participants.

One of the important relationships in my design is between **Participants and Categories**. A participant can enter multiple categories, and a category can have multiple participants. I therefore used the `Enrolments` table to handle this many-to-many relationship.

I also added constraints to the database to help prevent invalid data. For example, email addresses must be unique, roles and statuses have allowed values, distances and fees must contain valid values, and foreign keys are used to maintain the relationships between tables.

## Running the SQL Script

The database script can be run using **SQL Server Management Studio (SSMS)**.

To test the database:

1. Open SQL Server Management Studio.
2. Open `docs/RaceDay_Database.sql`.
3. Run the script on a SQL Server instance where I have permission to create databases.
4. The script creates the `RaceDay` database and its tables.
5. Sample data is then inserted into the database.
6. The `SELECT` statements at the bottom of the script can be used to check that the data was inserted correctly.

The sample data includes:

* 2 Organisers
* 2 Participants
* 3 Events
* 6 Categories
* 4 Enrolments
* 2 Results

### Password Hashes

The password hash values used in the Part 1 seed data are placeholders. This is because authentication is not being fully implemented in Part 1.

When authentication is developed in Part 2, I will use a proper password hashing method rather than storing passwords as plain text.

## API Planning

I created `docs/API_Endpoint_Plan.md` to plan the REST API before starting the implementation.

The endpoint plan covers the main areas that will be needed for the RaceDay system:

* Authentication
* User profiles
* Events
* Categories
* Enrolments
* Results

The purpose of planning the endpoints first is to have a clear idea of how the frontend and backend will communicate.

I will use this plan as a reference when developing Part 2. If I need to change an endpoint during development, I will also update the documentation so that the plan and implementation remain consistent.

## CI/CD

I also added a GitHub Actions workflow under:

`.github/workflows/validate-part1.yml`

The workflow checks that the required Part 1 files and repository structure are present.

Once the project has been pushed to GitHub, I will check the **Actions** section and make sure that the workflow completes successfully.

I will then add a screenshot of the successful green build below.

**CI/CD Screenshot:**

`[INSERT REAL GITHUB ACTIONS GREEN-BUILD SCREENSHOT HERE]`

## Video Presentation

The assessment requires an unlisted YouTube video explaining my work for this part.

In the video, I will explain the planning documents, walk through my ERD and its relationships, explain the API endpoint plan and demonstrate the SQL database being created and tested in SSMS.

**YouTube Video:**

`[https://youtu.be/oQiN9OmZ4FA]`

## AI Use Disclosure

I used AI as a supporting tool while working on this Part 1 documentation and database planning. It was mainly used to help with ideas, structuring the documentation, database modelling, proofreading and getting a starting point for some of the work.

I understand that the work still needs to be reviewed and understood by me before submission. I will test the SQL myself, check that the ERD matches the database, make any necessary changes and be able to explain my design decisions in my video.

Any AI assistance will be disclosed according to the assessment requirements.

## GitHub Commit History

The assessment requires at least **20 meaningful commits** for Part 1.

I will build the repository progressively instead of creating all the files and making one large commit at the end. My commits will represent actual stages of the work, such as creating the repository, adding the ERD, adding the database script, testing the SQL, adding the API documentation and making corrections.

I will not create fake commit history. The commit history should reflect the actual development and improvement of my Part 1 work.

A suggested commit progression is included in:

`docs/COMMIT_PLAN.md`
