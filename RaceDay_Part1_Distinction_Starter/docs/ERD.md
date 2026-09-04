# RaceDay Part 1 — ERD Specification

```text
USERS
-----
PK UserId
   FirstName
   LastName
   Email (UQ)
   PasswordHash
   Role
   PhoneNumber
   CreatedAt

        1
        |
        | organises
        |
        N
EVENTS
------
PK EventId
FK OrganiserId -> USERS.UserId
   EventName
   Description
   EventDate
   Venue
   City
   Province
   EventType
   Status
   CreatedAt

        1
        |
        | has
        |
        N
EVENTROUTES
----------
PK RouteId
FK EventId -> EVENTS.EventId
   RouteName
   StartLocation
   FinishLocation
   RouteDistanceKm
   RouteDescription

EVENTS
  1
  |
  | contains
  |
  N
CATEGORIES
----------
PK CategoryId
FK EventId -> EVENTS.EventId
   CategoryName
   DistanceKm
   EntryFee
   MaximumParticipants
   UQ(EventId, CategoryName)

USERS (Participant)
        1
        |
        | enters
        |
        N
ENROLMENTS
----------
PK EnrolmentId
FK ParticipantId -> USERS.UserId
FK CategoryId -> CATEGORIES.CategoryId
   EnrolmentDate
   EmergencyContactName
   EmergencyContactPhone
   PaymentStatus
   EnrolmentStatus
   UQ(ParticipantId, CategoryId)

CATEGORIES 1 ---- N ENROLMENTS

ENROLMENTS
     1
     |
     | produces
     |
     0..1
RESULTS
-------
PK ResultId
FK EnrolmentId -> ENROLMENTS.EnrolmentId
   FinishPosition
   FinishTimeSeconds
   ResultStatus
   RecordedAt
   UQ(EnrolmentId)
```

### Relationship rationale

1. One organiser can create many events; each event has one organiser.
2. One event can offer many categories; each category belongs to one event.
3. One participant can have many enrolments; each enrolment belongs to one participant.
4. One category can have many enrolments; the `Enrolments` entity resolves the participant/category many-to-many relationship.
5. One event can have many route definitions; each route belongs to one event.
6. An enrolment can have zero or one result while an event is in progress, and one result after the participant's performance is captured.
7. `Users.Role` distinguishes the two required application roles while keeping authentication/profile data in one entity.
