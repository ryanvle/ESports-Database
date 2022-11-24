CREATE PROCEDURE Russ_INSERT_Roster_Round
@W VARCHAR(60), 
@L VARCHAR(60), 
@Start SMALLDATETIME,
@End SMALLDATETIME,
@Round_T VARCHAR(30),
@T_Name VARCHAR(60),
@Roster_Name VARCHAR(30)


AS 

DECLARE @Round_ID INT, @Roster_ID INT, @T_ID INT

SET @Round_ID = (SELECT RoundID 
                    FROM tblROUND
                    WHERE RoundType = @Round_T)
SET @T_ID = (SELECT TournamentID 
                FROM tblTOURNAMENT
                WHERE TournamentName = @T_Name)
SET @Roster_ID = (SELECT RosterID 
                    FROM tblROSTER
                    WHERE RosterName = @Roster_Name)

BEGIN TRANSACTION rseng1
INSERT INTO tblROSTER_ROUND (RosterID, RoundID, TournamentID, Winner, Loser, StartTime, EndTime)
VALUES (@Roster_ID, @Round_ID, @T_ID, @W, @L, @Start, @End)
COMMIT TRANSACTION rseng1

GO


CREATE PROCEDURE insert_tblTOURNAMENT
@Game_Name varchar(100),
@Platform_Name varchar (60),
@Stadium_Name varchar(30),
@Tournament_Name varchar(60),
@Year char(4),
@Prize_Pool NUMERIC(9,2)

DECLARE @Game_Platform_ID INT, @Stadium_ID INT
SET @Game_Platform_ID = (SELECT GamePlatformID FROM tblGAME_PLATFORM GP
						JOIN tblGAME GAME ON GAME.GameID = GP.GameID
						JOIN tblPLATFORM P ON P.PlatformID = GP.PlatformID
						WHERE GAME.GameName = @Game_Name AND P.GamePlatform = @Platform_Name)

SET @Stadium_ID = (SELECT StatdiumID FROM tblSTADIUM S
					WHERE S.StadiumName = @Stadium_Name)

BEGIN TRANSACTION T1
INSERT INTO tblTOURNAMENT (GamePlatformID, StadiumID, TournamentName, Year, PrizePool)
VALUES (@Game_Platform_ID, @Stadium_ID, @Tournament_Name, @Year, @Prize_Pool)
COMMIT TRANSACTION T1

CREATE PROCEDURE insert_GAME_PLATFORM
@Game_Name varchar(100),
@Platform_Name varchar (60),
@Publish_Date DATE

DECLARE @Game_ID INT, @Platform_ID INT
SET @Game_ID = (SELECT GameID FROM tblGAME WHERE GameName = @Game_Name)

SET @Platform_ID = (SELECT PlatformID FROM tblPLATFORM WHERE GamePlatform = @Platform_Name)

BEGIN TRANSACTION GP1
INSERT INTO tblGAME_PLATFORM (GameID, PlatformID, PublishDate)
VALUES (@Game_ID, @Platform_ID, @Publish_Date)
COMMIT TRANSACTION GP1



CREATE PROCEDURE insert_GAME_DEVELOPER
@Game_Name varchar(100),
@Platform_Name varchar (60),
@Developer varchar(60)

DECLARE @Game_Platform_ID INT, @DeveloperID INT
SET @Game_Platform_ID = (SELECT GamePlatformID FROM tblGAME_PLATFORM GP
						JOIN tblGAME GAME ON GAME.GameID = GP.GameID
						JOIN tblPLATFORM P ON P.PlatformID = GP.PlatformID
						WHERE GAME.GameName = @Game_Name AND P.GamePlatform = @Platform_Name)

SET @DeveloperID = (SELECT DeveloperID FROM tblDEVELOPER WHERE tblDEVELOPER.Developer = @Developer)

BEGIN TRANSACTION GD1
INSERT INTO tblGAME_DEVELOPER (GamePlatformID, DeveloperID)
VALUES (@Game_Platform_ID, @Developer_ID)
COMMIT TRANSACTION GD1

CHRIS
-- Stored Procedures
-- tblCOUNTRY
CREATE PROCEDURE cku2NewCountry
@RegionName VARCHAR(60),
@CountryName VARCHAR(60)

AS
DECLARE @R_ID INT

SET @R_ID = (SELECT RegionID 
			 FROM tblREGION 
			 WHERE Region = @RegionName)

BEGIN TRANSACTION C1
INSERT INTO tblCOUNTRY (RegionID, CountryName)
VALUES (@R_ID, @CountryName)
COMMIT TRANSACTION C1
GO

-- tblPERSON
CREATE PROCEDURE cku2NewPerson
@GenderName VARCHAR(30),
@CountryName VARCHAR(60),
@FirstName VARCHAR(60),
@LastName VARCHAR(60),
@PersonBirth DATE,
@SocialMedia VARCHAR(120)

AS
DECLARE @G_ID INT, @C_ID INT

SET @G_ID = (SELECT GenderID
			 FROM tblGENDER 
			 WHERE GenderName = @GenderName)

SET @C_ID = (SELECT CountryID 
			 FROM tblCOUNTRY 
			 WHERE CountryName = @CountryName)

BEGIN TRANSACTION C2
INSERT INTO tblPERSON (GenderID, CountryID, FirstName, LastName, PersonBirth, SocialMedia)
VALUES (@G_ID, @C_ID, @FirstName, @LastName, @PersonBirth, @SocialMedia)
COMMIT TRANSACTION C2
GO

-- tblPERSON_ROSTER
CREATE PROCEDURE cku2NewPersonRoster
@FName VARCHAR(60),
@LName VARCHAR(60),
@RName VARCHAR(30),
@BeginDate DATE,
@EndDate DATE

AS
DECLARE @P_ID INT, @R_ID INT

SET @P_ID = (SELECT PersonID 
			 FROM tblPERSON
			 WHERE FirstName = @FName
			 AND LastName = @LName)

SET @R_ID = (SELECT RosterID
			 FROM tblROSTER 
			 WHERE RosterName = @RName)

BEGIN TRANSACTION C3
INSERT INTO tblPERSON_ROSTER (RosterID, PersonID, BeginDate, EndDate)
VALUES (@R_ID, @P_ID, @BeginDate, @EndDate)
COMMIT TRANSACTION C3
GO

CREATE PROCEDURE Russ_INSERT_Stat
@VALUE NUMERIC(7, 2),
@Type_Name VARCHAR(30)

AS
DECLARE @ST_ID INT = (SELECT StatTypeID
                        FROM tblSTATISTIC_TYPE
                        WHERE StatisticTypeName = @Type_Name)

BEGIN TRANSACTION rseng2
INSERT INTO tblSTATISTIC (StatTypeID, StatValue)
VALUES (@ST_ID, @Value)
COMMIT TRANSACTION rseng2

GO


--tblROSTER
CREATE PROCEDURE insert_tblROSTER
@RosterName varchar(60),
@Team_Name varchar(30), 
@Role varchar(30)

AS
DECLARE @T_ID INT, @R_ID INT

SET @T_ID = (SELECT TeamID FROM tblTEAM WHERE TeamName = @Team_Name)

SET @R_ID = (SELECT RoleID FROM tblROLE WHERE RoleName = @Role)


BEGIN TRANSACTION ROST1
INSERT INTO tblROSTER (TeamID, RoleID, RosterName)
VALUES (@T_ID, @R_ID, @RosterName)
COMMIT TRANSACTION ROST1
GO



CREATE PROCEDURE Russ_INSERT_Roster_RoundStat
@DT DATETIME,
@Round_Type VARCHAR(30),
@T_Name VARCHAR(60),
@Roster_Name VARCHAR(30),
@Stat_Type_Name VARCHAR(30),
@Stat_Value NUMERIC(7, 2)

AS
DECLARE @RR_ID INT, @S_ID INT, @Roster_ID INT, @Round_ID INT, @T_ID INT, @Stat_Type_ID INT
SET @Stat_Type_ID = (SELECT StatTypeID 
                        FROM tblSTATISTIC_TYPE
                        WHERE StatisticTypeName = @Stat_Type_Name)
SET @T_ID = (SELECT TournamentID 
                FROM tblTOURNAMENT 
                WHERE TournamentName = @T_Name)
SET @Round_ID = (SELECT RoundID FROM tblROUND 
                    WHERE RoundType = @Round_Type)
SET @Roster_ID = (SELECT RosterID 
                    FROM tblROSTER 
                    WHERE RosterName = @Roster_Name)
SET @RR_ID = (SELECT RosterRoundID
                FROM tblROSTER_ROUND
                WHERE RosterID = @Roster_ID
                AND RoundID = @Round_ID
                AND TournamentID = @T_ID)
SET @S_ID = (SELECT StatID  
                FROM tblSTATISTIC 
                WHERE StatTypeID = @Stat_Type_ID
                AND StatValue = @Stat_Value)

BEGIN TRANSACTION rseng3
INSERT INTO tblROSTER_ROUNDSTAT (RosterRoundID, StatID, [DateTime])
VALUES (@RR_ID, @S_ID, @DT)
COMMIT TRANSACTION rseng3

GO