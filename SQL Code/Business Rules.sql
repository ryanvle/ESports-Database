--Each role must have a salary of higher than 0 dollars
CREATE FUNCTION fn_MinSalary()
RETURNS INT
AS
BEGIN

DECLARE @RET INT = 0
IF EXISTS (SELECT * FROM tblROLE R WHERE R.Salary = 0)
    BEGIN
SET @RET = 1
    END
RETURN @RET
END
GO

ALTER TABLE tblROLE
ADD CONSTRAINT CK_MinSalary
CHECK(dbo.fn_MinSalary() = 0)
GO

--NO STRINGS THAT AREN’T IN AN EMAIL FORMAT CAN BE ENTERED INTO THE TEAM EMAIL
CREATE FUNCTION Is_Real_Email()
RETURNS INT
AS
BEGIN
DECLARE @RET INT = 0
IF EXISTS (SELECT * FROM tblTEAM
            WHERE TeamEmail LIKE '%@%')
    	     BEGIN
        SET @RET = 1
           END
RETURN @RET
END
GO

ALTER TABLE tblTEAM
ADD CONSTRAINT Real_Email
CHECK (dbo.Is_Real_Email() = 1)
GO

--All PERSONS MUST BE 16 OR OLDER TO PARTICIPATE
CREATE FUNCTION Sixteen_Plus_Only()
RETURNS INT
 
AS
BEGIN
DECLARE @RET INT = 0
IF EXISTS (SELECT *
     FROM tblPERSON
           WHERE PersonBirth >= DATEADD(MONTH, -16 * 12, GETDATE())
)
           BEGIN
        SET @RET = 1
           END
RETURN @RET
END
GO
 
ALTER TABLE tblPERSON
ADD CONSTRAINT Sixteen_And_Up
CHECK(dbo.Sixteen_Plus_Only() = 0)
GO

-- A Stadium named "Seattle Stadium" cannot host any tournament related to "League of Legends" after 2020
CREATE FUNCTION Seattle_Banned_League ()
RETURNS INT 
 
AS
 
BEGIN
 
    DECLARE @RET INT = 0
 
    IF EXISTS (SELECT * 
                FROM tblSTADIUM S 
                    JOIN tblTOURNAMENT T ON S.StadiumID = T.StadiumID
                    JOIN tblGAME_PLATFORM GP ON GP.GamePlatformID = T.GamePlatformID
                    JOIN tblGAME G ON G.GameID = GP.GameID
                WHERE S.StadiumName = 'Seattle Stadium'
                AND G.GameName = 'League of Legends'
                AND T.[Year] > '2020')
    BEGIN 
 
        SET @RET = 1
 
    END
 
    RETURN @RET
 
    END
 
GO
 
ALTER TABLE tblTOURNAMENT
ADD CONSTRAINT League_Banned_At_Seattle_Stadium
CHECK (dbo.Seattle_Banned_League() = 0)
 
GO

-- A Game name starting with "Husky" cannot be on Xbox platform after 2012
CREATE FUNCTION Xbox_Doesnt_Like_Husky ()
RETURNS INT
 
AS
 
BEGIN
 
    DECLARE @RET INT = 0 
 
    IF EXISTS (SELECT * 
                FROM tblGAME G
                    JOIN tblGAMEPLATFORM GP ON G.GameID = GP.GameID
                    JOIN tblPLATFORM P ON P.PlatformID = GP.PlatformID
                WHERE G.GameName LIKE 'Husky%'
                AND GP.GamePlatform = 'Microsoft''s Xbox'
                AND GP.PublishDate > '2012')
 
    BEGIN 
 
        SET @RET = 1
    
    END
 
    RETURN @RET
 
END 
 
GO
 
ALTER TABLE tblGAME_PLATFORM
ADD CONSTRAINT No_Husky_After_2012
CHECK (dbo.Xbox_Doesnt_Like_Husky() = 0)
GO

-- A Roster's End Date must be larger than its beginning date
CREATE FUNCTION fn_noRosterLifeSpanViolation()
RETURNS INT
AS
BEGIN

DECLARE @RET INT = 0
IF EXISTS (SELECT *
           FROM tblROSTER R
            JOIN tblPERSON_ROSTER PR ON R.RosterID = PR.PersonRosterID
           WHERE PR.EndDate < PR.BeginDate)
    BEGIN
        SET @RET = 1
    END
RETURN @RET
END
GO

ALTER TABLE tblROSTER
ADD CONSTRAINT noInvalidLifeSpan
CHECK (dbo.fn_noRosterLifeSpanViolation() = 0)
GO

-- A Tournament cannot begin before a game’s publish date
CREATE FUNCTION fn_noPublishDateViolation()
RETURNS INT
AS
BEGIN

DECLARE @RET INT = 0
IF EXISTS (SELECT *
           FROM tblTOURNAMENT T
                JOIN tblGAME_PLATFORM GP ON T.GamePlatformID = GP.GamePlatformID
                JOIN tblGAME G ON GP.GameID = G.GameID
           WHERE T.[Year] < YEAR(GP.PublishDate))
    BEGIN
        SET @RET = 1
    END
RETURN @RET
END
GO

ALTER TABLE tblTOURNAMENT
ADD CONSTRAINT noInvalidTournamentStart
CHECK (dbo.fn_noPublishDateViolation() = 0)
GO

--A ROSTER cannot participate in a tournament within two weeks of being founded
CREATE FUNCTION fn_NoRoster()
RETURNS INT
AS
BEGIN

DECLARE @RET INT = 0
IF EXISTS  (SELECT *
        FROM tblROSTER R
               JOIN tblROSTER_ROUND RR ON R.RosterID = RR.RosterID
                JOIN tblTOURNAMENT TOURN ON RR.TournamentID = TOURN.TournamentID
                JOIN tblPERSON_ROSTER PR ON R.RosterID = PR.PersonRosterID
                    WHERE PR.BeginDate > DATEADD(day, 14, GETDATE()))
                     BEGIN 
                          SET @RET = 1
                     END
RETURN @RET
END
GO

ALTER TABLE tblTOURNAMENT
ADD CONSTRAINT CK_NoRoster
CHECK(dbo.fn_NoRoster() = 0)
GO