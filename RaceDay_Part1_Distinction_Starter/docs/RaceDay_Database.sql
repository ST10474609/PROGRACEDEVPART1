/*
    RaceDay - Part 1 Database Script
    SQL Server / SSMS

    NOTE:
    This script is a planning/reference implementation produced with AI assistance.
    Review, understand, test, and adapt it before submission.
*/

IF DB_ID(N'RaceDay') IS NOT NULL
BEGIN
    ALTER DATABASE RaceDay SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE RaceDay;
END;
GO

CREATE DATABASE RaceDay;
GO

USE RaceDay;
GO

CREATE TABLE Users (
    UserId INT IDENTITY(1,1) CONSTRAINT PK_Users PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(255) NOT NULL CONSTRAINT UQ_Users_Email UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Role NVARCHAR(20) NOT NULL
        CONSTRAINT CK_Users_Role CHECK (Role IN ('Organiser', 'Participant')),
    PhoneNumber NVARCHAR(30) NULL,
    CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_Users_CreatedAt DEFAULT SYSUTCDATETIME()
);
GO

CREATE TABLE Events (
    EventId INT IDENTITY(1,1) CONSTRAINT PK_Events PRIMARY KEY,
    OrganiserId INT NOT NULL,
    EventName NVARCHAR(150) NOT NULL,
    Description NVARCHAR(1000) NULL,
    EventDate DATE NOT NULL,
    Venue NVARCHAR(200) NOT NULL,
    City NVARCHAR(100) NOT NULL,
    Province NVARCHAR(100) NOT NULL,
    EventType NVARCHAR(30) NOT NULL
        CONSTRAINT CK_Events_EventType CHECK (EventType IN ('Running', 'Walking', 'Cycling')),
    Status NVARCHAR(20) NOT NULL
        CONSTRAINT DF_Events_Status DEFAULT 'Upcoming'
        CONSTRAINT CK_Events_Status CHECK (Status IN ('Draft', 'Upcoming', 'Completed', 'Cancelled')),
    CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_Events_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_Events_Organiser FOREIGN KEY (OrganiserId) REFERENCES Users(UserId)
);
GO

CREATE TABLE EventRoutes (
    RouteId INT IDENTITY(1,1) CONSTRAINT PK_EventRoutes PRIMARY KEY,
    EventId INT NOT NULL,
    RouteName NVARCHAR(150) NOT NULL,
    StartLocation NVARCHAR(200) NOT NULL,
    FinishLocation NVARCHAR(200) NOT NULL,
    RouteDistanceKm DECIMAL(6,2) NOT NULL,
    RouteDescription NVARCHAR(1000) NULL,
    CONSTRAINT CK_EventRoutes_Distance CHECK (RouteDistanceKm > 0),
    CONSTRAINT UQ_EventRoutes_Event_RouteName UNIQUE (EventId, RouteName),
    CONSTRAINT FK_EventRoutes_Event FOREIGN KEY (EventId) REFERENCES Events(EventId) ON DELETE CASCADE
);
GO

CREATE TABLE Categories (
    CategoryId INT IDENTITY(1,1) CONSTRAINT PK_Categories PRIMARY KEY,
    EventId INT NOT NULL,
    CategoryName NVARCHAR(100) NOT NULL,
    DistanceKm DECIMAL(6,2) NOT NULL,
    EntryFee DECIMAL(10,2) NOT NULL,
    MaximumParticipants INT NULL,
    CONSTRAINT CK_Categories_Distance CHECK (DistanceKm > 0),
    CONSTRAINT CK_Categories_EntryFee CHECK (EntryFee >= 0),
    CONSTRAINT CK_Categories_MaxParticipants CHECK (MaximumParticipants IS NULL OR MaximumParticipants > 0),
    CONSTRAINT UQ_Categories_Event_Category UNIQUE (EventId, CategoryName),
    CONSTRAINT FK_Categories_Event FOREIGN KEY (EventId) REFERENCES Events(EventId) ON DELETE CASCADE
);
GO

CREATE TABLE Enrolments (
    EnrolmentId INT IDENTITY(1,1) CONSTRAINT PK_Enrolments PRIMARY KEY,
    ParticipantId INT NOT NULL,
    CategoryId INT NOT NULL,
    EnrolmentDate DATETIME2 NOT NULL CONSTRAINT DF_Enrolments_Date DEFAULT SYSUTCDATETIME(),
    EmergencyContactName NVARCHAR(100) NULL,
    EmergencyContactPhone NVARCHAR(30) NULL,
    PaymentStatus NVARCHAR(20) NOT NULL
        CONSTRAINT DF_Enrolments_PaymentStatus DEFAULT 'Pending'
        CONSTRAINT CK_Enrolments_PaymentStatus CHECK (PaymentStatus IN ('Pending', 'Paid', 'Refunded')),
    EnrolmentStatus NVARCHAR(20) NOT NULL
        CONSTRAINT DF_Enrolments_Status DEFAULT 'Active'
        CONSTRAINT CK_Enrolments_Status CHECK (EnrolmentStatus IN ('Active', 'Cancelled')),
    CONSTRAINT UQ_Enrolments_Participant_Category UNIQUE (ParticipantId, CategoryId),
    CONSTRAINT FK_Enrolments_Participant FOREIGN KEY (ParticipantId) REFERENCES Users(UserId),
    CONSTRAINT FK_Enrolments_Category FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId)
);
GO

CREATE TABLE Results (
    ResultId INT IDENTITY(1,1) CONSTRAINT PK_Results PRIMARY KEY,
    EnrolmentId INT NOT NULL,
    FinishPosition INT NULL,
    FinishTimeSeconds INT NULL,
    ResultStatus NVARCHAR(20) NOT NULL
        CONSTRAINT DF_Results_Status DEFAULT 'Finished'
        CONSTRAINT CK_Results_Status CHECK (ResultStatus IN ('Finished', 'DNF', 'DNS', 'Disqualified')),
    RecordedAt DATETIME2 NOT NULL CONSTRAINT DF_Results_RecordedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT UQ_Results_Enrolment UNIQUE (EnrolmentId),
    CONSTRAINT CK_Results_Position CHECK (FinishPosition IS NULL OR FinishPosition > 0),
    CONSTRAINT CK_Results_Time CHECK (FinishTimeSeconds IS NULL OR FinishTimeSeconds > 0),
    CONSTRAINT FK_Results_Enrolment FOREIGN KEY (EnrolmentId) REFERENCES Enrolments(EnrolmentId) ON DELETE CASCADE
);
GO

-- Organisers
INSERT INTO Users (FirstName, LastName, Email, PasswordHash, Role, PhoneNumber)
VALUES
('Lerato', 'Mokoena', 'lerato.mokoena@raceday.example', 'HASH_PLACEHOLDER_1', 'Organiser', '0710000001'),
('Sipho', 'Dlamini', 'sipho.dlamini@raceday.example', 'HASH_PLACEHOLDER_2', 'Organiser', '0720000002');

-- Participants
INSERT INTO Users (FirstName, LastName, Email, PasswordHash, Role, PhoneNumber)
VALUES
('Thando', 'Ndlovu', 'thando.ndlovu@raceday.example', 'HASH_PLACEHOLDER_3', 'Participant', '0730000003'),
('Anele', 'Jacobs', 'anele.jacobs@raceday.example', 'HASH_PLACEHOLDER_4', 'Participant', '0740000004');

-- Events
INSERT INTO Events
(OrganiserId, EventName, Description, EventDate, Venue, City, Province, EventType, Status)
VALUES
(1, 'Mbombela Spring Run', 'Community road running event through Mbombela.', '2026-10-10',
 'Mbombela Stadium', 'Mbombela', 'Mpumalanga', 'Running', 'Upcoming'),
(1, 'Lowveld Cycle Challenge', 'Road cycling event for recreational and competitive cyclists.', '2026-11-07',
 'Riverside Mall', 'Mbombela', 'Mpumalanga', 'Cycling', 'Upcoming'),
(2, 'Soweto Community Walk', 'Inclusive community walking event.', '2026-11-21',
 'Orlando Stadium', 'Soweto', 'Gauteng', 'Walking', 'Upcoming');

-- Event routes
INSERT INTO EventRoutes
(EventId, RouteName, StartLocation, FinishLocation, RouteDistanceKm, RouteDescription)
VALUES
(1, 'Mbombela City Loop', 'Mbombela Stadium', 'Mbombela Stadium', 10.00, 'Urban loop through central Mbombela.'),
(2, 'Lowveld Scenic Route', 'Riverside Mall', 'Riverside Mall', 60.00, 'Road cycling route through the Lowveld.'),
(3, 'Orlando Community Route', 'Orlando Stadium', 'Orlando Stadium', 10.00, 'Community walking route through Soweto.');

-- Categories: each event has multiple categories
INSERT INTO Categories (EventId, CategoryName, DistanceKm, EntryFee, MaximumParticipants)
VALUES
(1, '10 km Open Run', 10.00, 120.00, 1000),
(1, '5 km Fun Run', 5.00, 80.00, 1500),
(2, '60 km Cycle', 60.00, 250.00, 500),
(2, '30 km Cycle', 30.00, 180.00, 700),
(3, '10 km Community Walk', 10.00, 100.00, 1200),
(3, '5 km Family Walk', 5.00, 70.00, 1800);

-- Sample enrolments
INSERT INTO Enrolments
(ParticipantId, CategoryId, EmergencyContactName, EmergencyContactPhone, PaymentStatus, EnrolmentStatus)
VALUES
(3, 1, 'Nomsa Ndlovu', '0750000010', 'Paid', 'Active'),
(3, 5, 'Nomsa Ndlovu', '0750000010', 'Pending', 'Active'),
(4, 2, 'David Jacobs', '0760000011', 'Paid', 'Active'),
(4, 4, 'David Jacobs', '0760000011', 'Paid', 'Active');

-- Sample results for completed/recorded performance history
INSERT INTO Results (EnrolmentId, FinishPosition, FinishTimeSeconds, ResultStatus)
VALUES
(1, 42, 3120, 'Finished'),
(3, 17, 1560, 'Finished');
GO

-- Verification queries
SELECT * FROM Users;
SELECT * FROM Events;
SELECT * FROM Categories;
SELECT * FROM Enrolments;
SELECT * FROM Results;
GO
