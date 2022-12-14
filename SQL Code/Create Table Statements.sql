--Country Table:
CREATE TABLE tblCOUNTRY (
	CountryID INTEGER IDENTITY(1,1) PRIMARY KEY,
	RegionID INTEGER,
	CountryName VARCHAR(30)
)
GO

ALTER TABLE tblCOUNTRY
ADD CONSTRAINT FK_Region
FOREIGN KEY (RegionID) REFERENCES REGION(RegionID)
GO

Statistic Table:
CREATE TABLE tblSTATISTIC (
	StatID INTEGER IDENTITY(1,1) PRIMARY KEY,
	StatTypeID INTEGER,
	StatValue NUMERIC(7,2)
)
GO

ALTER TABLE tblSTATISTIC
ADD CONSTRAINT FK_Statistic_Type
FOREIGN KEY (StatTypeID) REFERENCES STATISTIC_TYPE(StatTypeID)
GO

--PERSON_ROSTER Table:
CREATE TABLE tblPERSON_ROSTER (
	PersonRosterID INTEGER IDENTITY(1,1) PRIMARY KEY,
	PersonID INTEGER,
	RosterID INTEGER,
	BeginDate DATE,
	EndDate DATE
)
GO

ALTER TABLE tblPERSON_ROSTER
ADD CONSTRAINT FK_Person
FOREIGN KEY (PersonID) REFERENCES PERSON(PersonID)
GO

ALTER TABLE tblPERSON_ROSTER
ADD CONSTRAINT FK_Roster
FOREIGN KEY (RosterID) REFERENCES ROSTER(RosterID)
GO

--ROSTER Table:
CREATE TABLE tblROSTER (
RosterID INT IDENTITY(1, 1) PRIMARY KEY, 
TeamID INT NOT NULL,
RoleID INT NOT NULL, 
RosterName VARCHAR(30)
)
GO

ALTER TABLE tblROSTER
ADD CONSTRAINT FK_Team
FOREIGN KEY (TeamID) REFERENCES TEAM(TeamID)
GO

ALTER TABLE tblROSTER
ADD CONSTRAINT FK_Roster_RoleID
FOREIGN KEY (RoleID)
REFERENCES [ROLE] (RoleID)
GO

--Region Table:
CREATE TABLE tblREGION(
RegionID INT IDENTITY (1,1) PRIMARY KEY,
Region varchar(50) NOT NULL)
GO

--Role Table:
CREATE TABLE tblROLE(
RoleID INT IDENTITY (1,1) PRIMARY KEY,
RoleName varchar(50) NOT NULL,
Salary NUMERIC(9,2))
GO

--Game Table:
CREATE TABLE tblGAME (
    GameID INT IDENTITY(1, 1) PRIMARY KEY,
    GameName VARCHAR(100) NOT NULL,
)
GO

--Platform Table:
CREATE TABLE tblPLATFORM (
    PlatformID INT IDENTITY(1, 1) PRIMARY KEY, 
    GamePlatform VARCHAR(60) NOT NULL
)
GO

--Developer Table:
CREATE TABLE tblDEVELOPER (
    DeveloperID INT IDENTITY(1, 1) PRIMARY KEY, 
    Developer VARCHAR(60) NOT NULL
)
GO

--Region Table
CREATE TABLE tblREGION(
    RegionID INT IDENTITY (1,1) PRIMARY KEY,
    Region varchar(50) NOT NULL
)
GO

--Role Table:
CREATE TABLE tblROLE(
    RoleID INT IDENTITY (1,1) PRIMARY KEY,
    RoleName varchar(50) NOT NULL,
    Salary NUMERIC(9,2)
    )
GO

--Round Table:
CREATE TABLE tblROUND (
    RoundID INTEGER IDENTITY(1,1) PRIMARY KEY,
    RoundType varchar(30) NOT NULL
)
GO

--Stadium Table:
CREATE TABLE tblSTADIUM(
    StadiumID INTEGER IDENTITY(1,1) PRIMARY KEY,
    StadiumCapacity INT, 
    StadiumName varchar(30) NOT NULL,
    StadiumCountry varchar(30) NOT NULL
)
GO

--Gender Table:
CREATE TABLE tblGENDER(
    GenderID INT IDENTITY(1,1) PRIMARY KEY,
    GenderName VARCHAR(30) NOT NULL
)
GO

--Team Table:
CREATE TABLE tblTEAM(
    TeamID INT IDENTITY(1,1) PRIMARY KEY,
    TeamName VARCHAR(30) NOT NULL,
    Founded DATE,
    TeamEmail VARCHAR(50) NOT NULL,
    TeamLogo VARCHAR(50) NOT NULL
)
GO

--STATISTIC_TYPE Table:
CREATE TABLE tblSTATISTIC_TYPE(
    StatTypeID INT IDENTITY(1,1) PRIMARY KEY,
    StatisticTypeName VARCHAR(30) NOT NULL,
    StatisticTypeDesc VARCHAR(100) NULL
)
GO

--Person Table:
CREATE TABLE tblPERSON(
    PersonID INT IDENTITY(1, 1) PRIMARY KEY, 
    GenderID INT NOT NULL,
    CountryID INT NOT NULL, 
    FirstName VARCHAR(60) NOT NULL,
    LastName VARCHAR(60) NOT NULL,
    PersonBirth DATE NOT NULL, 
    SocialMedia VARCHAR(120)
)
GO

--GAME_PLATFORM Table:
CREATE TABLE tblGAME_PLATFORM (
    GamePlatformID INT IDENTITY(1, 1) PRIMARY KEY, 
    GameID INT NOT NULL ,
    PlatformID INT NOT NULL, 
    PublishDate DATE

)
GO
ALTER TABLE tblGAME_PLATFORM 
ADD CONSTRAINT FK_Game_Platform_GameID
FOREIGN KEY (GameID)
REFERENCES GAME(GameID)
GO

ALTER TABLE tblGAME_PLATFORM 
ADD CONSTRAINT FK_Game_Platform_PlatformID
FOREIGN KEY (PlatformID)
REFERENCES PLATFORM(PlatformID)
GO

--GAME_DEVELOPER Table:
CREATE TABLE tblGAME_DEVELOPER (
    GameDeveloperID INT IDENTITY(1, 1) PRIMARY KEY, 
    GamePlatformID INT NOT NULL, 
    DeveloperID INT NOT NULL
)
GO
ALTER TABLE tblGAME_DEVELOPER 
ADD CONSTRAINT FK_Game_Developer_DeveloperID
FOREIGN KEY (DeveloperID)
REFERENCES DEVELOPER(DeveloperID)
GO

ALTER TABLE tblGAME_DEVELOPER 
ADD CONSTRAINT FK_Game_Developer_GamePlatformID
FOREIGN KEY (GamePlatformID)
REFERENCES GAME_PLATFORM(GamePlatformID)
GO

--ROSTER_ROUND Table:
CREATE TABLE tblROSTER_ROUND (
    RosterRoundID INT IDENTITY(1, 1) PRIMARY KEY, 
    RosterID INT NOT NULL, 
    RoundID INT NOT NULL,
    TournamentID INT NOT NULL, 
    Winner VARCHAR(60) ,
    Loser VARCHAR(60),
    StartTime SMALLDATETIME NOT NULL,
    EndTime SMALLDATETIME
)
GO
ALTER TABLE tblROSTER_ROUND 
ADD CONSTRAINT FK_Roster_Round_RoundID
FOREIGN KEY (RoundID)
REFERENCES tblROUND (RoundID)
GO

ALTER TABLE tblROSTER_ROUND 
ADD CONSTRAINT FK_Roster_Round_RosterID
FOREIGN KEY (RosterID)
REFERENCES tblROSTER (RosterID)
GO

ALTER TABLE tblROSTER_ROUND 
ADD CONSTRAINT FK_Roster_Round_TournamentID
FOREIGN KEY (TournamentID)
REFERENCES tblTOURNAMENT (TournamentID)
GO


--ROSTER_ROUNDSTAT Table:
CREATE TABLE tblROSTER_ROUNDSTAT(
    RosterRoundStatID INT IDENTITY(1, 1) PRIMARY KEY, 
    RosterRoundID INT NOT NULL, 
    StatID INT NOT NULL, 
    [DATETIME] DATE NOT NULL
)
GO
ALTER TABLE tblROSTER_ROUNDSTAT 
ADD CONSTRAINT FK_Roster_RoundStat_RosterRoundID 
FOREIGN KEY (RosterRoundID)
REFERENCES tblROSTER_ROUND (RosterRoundID)
GO

ALTER TABLE tblROSTER_ROUNDSTAT 
ADD CONSTRAINT FK_Roster_RoundStat_StatID
FOREIGN KEY (StatID)
REFERENCES tblSTATISTIC (StatID)
GO

ALTER TABLE tblTOURNAMENT
ADD CONSTRAINT FN_TournamentGamePlatform
FOREIGN KEY (GamePlatformID) REFERENCES tblGAME_PLATFORM(GamePlatformID);
GO

ALTER TABLE tblTOURNAMENT 
ADD CONSTRAINT FK_TournamentStadium
FOREIGN KEY (StadiumID) REFERENCES tblSTADIUM(StadiumID);
GO