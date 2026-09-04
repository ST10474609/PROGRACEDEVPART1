# Part 1 Distinction Checklist

Before submitting, personally verify every item:

- [ ] ERD has at least six entities if your lecturer interprets the requirement literally.
- [ ] ERD primary keys, foreign keys and cardinalities are clear.
- [ ] ERD exactly matches the SQL schema.
- [ ] Endpoint plan covers authentication, profile, events, categories, enrolments and results.
- [ ] Endpoint roles are consistent with the two required roles.
- [ ] SQL executes successfully on a clean SQL Server instance.
- [ ] SQL includes all required constraints.
- [ ] SQL contains 2 organisers.
- [ ] SQL contains 2 participants.
- [ ] SQL contains 3 events.
- [ ] Every event has categories.
- [ ] Sample enrolments are included.
- [ ] GitHub Actions shows a green build.
- [ ] README contains a real CI screenshot.
- [ ] README contains your real unlisted YouTube link.
- [ ] You made at least 20 genuine meaningful commits using your own GitHub account.
- [ ] Your video uses your own voice and explains your actual understanding.
- [ ] AI assistance is disclosed as required by the brief.

## Six-entity requirement

The model contains six database entities:

1. Users
2. Events
3. EventRoutes
4. Categories
5. Enrolments
6. Results

`EventRoutes` is justified by the brief's road-event context and gives RaceDay a dedicated relational structure for route information rather than storing route data as unstructured fields inside Events.
