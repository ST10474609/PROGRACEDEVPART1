# RaceDay — Part 1 Portfolio of Evidence

## Project overview

RaceDay is a planned full-stack event management platform for the South African road running, walking and cycling community.

Part 1 establishes the database and API foundation before application development. It contains:

- Entity Relationship Diagram (ERD)
- API endpoint plan
- SQL Server database creation and seed script
- GitHub Actions repository-structure validation
- Documentation explaining the two roles and key design decisions

## Roles

### Organiser
An organiser can:
- Create, edit and delete their events
- Create, edit and delete categories belonging to their events
- View event enrolments
- Capture and maintain participant results

### Participant
A participant can:
- Register and log in
- View and browse events
- Enter an event by selecting a category
- View their own enrolments
- View their personal performance history/results

Role and ownership enforcement will be implemented at the API level in Part 2 and reflected in the MVC interface in Part 3.

## Repository structure

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

## Database design summary

The core model uses six entities:

1. `Users` — stores both required roles.
2. `Events` — stores organiser-owned events.
3. `EventRoutes` — stores structured route information for an event.
4. `Categories` — stores event-specific race/walk/cycling categories.
5. `Enrolments` — resolves the participant/category many-to-many relationship.
6. `Results` — stores participant performance results.

The SQL constraints are designed to protect data integrity. Examples include unique email addresses, valid role/status values, positive distances and fees, foreign keys, and prevention of duplicate participant/category enrolments.

## Running the SQL script

1. Open SQL Server Management Studio.
2. Open `docs/RaceDay_Database.sql`.
3. Execute the script on a SQL Server instance where you have permission to create databases.
4. The script creates the `RaceDay` database and all tables.
5. Seed data is inserted for:
   - 2 organisers
   - 2 participants
   - 3 events
   - 6 categories
   - 4 sample enrolments
   - 2 sample results
6. Run the verification `SELECT` statements at the bottom to confirm the data.

### Important

The sample `PasswordHash` values are placeholders for Part 1 database seeding. Part 2 should use a proper password hashing approach rather than storing plaintext passwords.

## API planning

`docs/API_Endpoint_Plan.md` defines the intended Part 2 REST API before implementation. It covers:

- Authentication
- User profile
- Events
- Categories
- Enrolments
- Results

The implementation should remain aligned with this plan. If a route changes during Part 2, update the documentation and explain the reason.

## CI/CD

The GitHub Actions workflow in `.github/workflows/validate-part1.yml` validates that the required Part 1 repository structure and files exist.

After pushing the repository to GitHub:

1. Open the **Actions** tab.
2. Open the Part 1 validation workflow.
3. Confirm the workflow finishes successfully.
4. Take a screenshot showing the green successful build.
5. Replace the placeholder below with the actual screenshot in your final repository.

**CI/CD screenshot:**  
`[INSERT YOUR REAL GITHUB ACTIONS GREEN-BUILD SCREENSHOT HERE]`

## Video presentation

The assessment requires an unlisted YouTube presentation with your own voiceover.

**YouTube video:**  
`[INSERT YOUR UNLISTED YOUTUBE LINK HERE]`

The video should demonstrate the running/working planning artefacts, explain the ERD relationships and cardinalities, walk through the endpoint plan, and execute the SQL script in SSMS.

## AI-use disclosure

AI assistance was used during the preparation of this Part 1 reference package for planning, drafting documentation, database modelling assistance, proofreading and generating a starting structure. The student must review, understand, test and adapt the work, and should disclose AI assistance according to the assessment instructions. The student remains responsible for the final submission and all explanations presented in the video.

## Commit-history requirement

The brief requires at least 20 meaningful commits for Part 1. Do **not** fabricate commit history. Build the repository progressively using your own GitHub account and make meaningful commits as you create, test and improve the artefacts.

Suggested meaningful milestones are provided in `docs/COMMIT_PLAN.md`.
