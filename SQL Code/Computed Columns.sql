-- Compute the number of people born after 2000 and are currently enrolled in a role for each role
CREATE FUNCTION Role_Volume (@PK INT)
RETURNS INT
AS
BEGIN
 
    DECLARE @RET INT = (SELECT COUNT(P.PersonID)
                        FROM tblROLE R 
                            JOIN tblROSTER RT ON R.RoleID = RT.RoleID
                            JOIN tblPERSON_ROSTER PR ON RT.RosterID = PR.RosterID
                            JOIN tblPERSON P ON P.PersonID = PR.PersonID
                        WHERE YEAR(P.PersonBirth) >= '2000'
                        AND PR.EndDate IS NULL
                        AND R.RoleID = @PK)
    RETURN @RET
 
END
GO
 
ALTER TABLE tblROLE
ADD Num_People_In_Role AS (dbo.Role_Volume(RoleID))
GO

-- Compute the age of a player for the PLAYER table
CREATE FUNCTION Tell_Me_Your_Age (@PK INT)
RETURNS INT 
AS
BEGIN 
    DECLARE @RET INT = (SELECT DATEDIFF(year, PersonBirth, GETDATE())
                        FROM tblPERSON 
                        WHERE PersonID = @PK)
RETURN @RET
END
GO

ALTER TABLE tblPERSON 
ADD Age AS (dbo.Tell_Me_Your_Age(PersonID))
GO

-- Calculate the average value of each statistic type
CREATE FUNCTION fn_TotalStatTypes(@PK INT)
RETURNS INTEGER
AS
BEGIN

DECLARE @RET INTEGER = (SELECT AVG(S.StatValue)
			   FROM tblSTATISTIC_TYPE ST
				 JOIN tblSTATISTIC S ON ST.StatTypeID = S.StatTypeID
			   WHERE ST.StatTypeID = @PK)		
RETURN @RET
END
GO

ALTER TABLE tblSTATISTIC_TYPE
ADD Calc_AvgStatVal AS (fn_TotalStatTypes(StatTypeID))
GO

-- Calculate the total players from each region
CREATE FUNCTION fn_TotalPlayersPerRegion(@PK INT)
RETURNS INTEGER
AS
BEGIN

DECLARE @RET INTEGER = (SELECT COUNT(*)
			    FROM tblREGION R
  JOIN tblCOUNTRY C ON C.RegionID = R.RegionID
				  JOIN tblPERSON P ON C.PersonID = P.PersonID
			    WHERE R.RegionID = @PK)
RETURN @RET
END
GO

ALTER TABLE tblREGION
ADD Calc_TotalPlayers AS (fn_TotalPlayersPerRegion(RegionID))
GO

-- How many times a game has been played within the context of a tournament
CREATE FUNCTION Tournament_Count(@PK INT)
RETURNS INT
AS
BEGIN
DECLARE @RET INT = (SELECT COUNT(*)
                    FROM tblTOURNAMENT T
                JOIN tblGAME_PLATFORM GP ON T.GamePlatformID = GP.GamePlatformID
                JOIN tblGAME G ON GP.GameID = G.GameID
            WHERE G.GameID = @PK)
RETURN @RET
END
GO
 
ALTER TABLE tblGAME
ADD NumTournaments AS (dbo.Tournament_Count(tblGAME.GameID))
GO

-- How many times a team has made it to Finals
CREATE FUNCTION Grand_Finals_Count(@PK INT)
RETURNS INT
AS
BEGIN
 
DECLARE @RET INT = (SELECT COUNT(*)
                    FROM tblTEAM T
                JOIN tblROSTER R ON R.TeamID = T.TeamID
                JOIN tblROSTER_ROUND RR ON RR.RosterID = R.RosterID
                JOIN tblROUND RND ON RR.RoundID = RND.RoundID
               WHERE RND.RoundType = 'Finals'
                AND T.TeamID = @PK)
RETURN @RET
END
GO
 
ALTER TABLE tblTEAM
ADD NumGrandFinals AS (dbo.Grand_Finals_Count(tblTEAM.TeamID))
GO

--Compute the total number of players in each team for the tblTEAM table
CREATE FUNCTION fn_TotalPlayersTeam(@PK INT)
RETURNS INTEGER 
AS 
BEGIN

DECLARE @RET INTEGER = (SELECT COUNT(*)
                            FROM tblROSTER R
                            JOIN tblROLE RO ON R.RoleID = RO.RoleID
                            JOIN tblTEAM T ON R.TeamID = T.TeamID
                            JOIN tblPERSON_ROSTER PR ON PR.RosterID = R.RosterID
                            JOIN tblPERSON P ON PR.PersonID = P.PersonID
WHERE R.RoleName = 'Player'
AND T.TeamID = @PK
GROUP BY P.PersonID)

RETURN @RET
END
GO

ALTER TABLE tblTEAM
ADD Calc_TotalPlayers AS (dbo.fn_TotalPlayersTeam(TeamID))
GO

--Compute the total number of teams in each region for the REGION table
CREATE FUNCTION fn_TotalTeamsRegion(@PK INT)
RETURNS INTEGER
AS
BEGIN
 
DECLARE @RET INTEGER = (SELECT COUNT(*)
                            FROM tblROSTER R
                            JOIN tblTEAM T ON R.TeamID = T.TeamID
                            JOIN tblPERSON_ROSTER PR ON R.RosterID = PR.RosterID
                            JOIN tblPERSON P ON PR.PersonID = P.PersonID
                            JOIN tblCOUNTRY C ON P.CountryID = C.CountryID
                            JOIN tblREGION RE ON C.RegionID = RE.RegionID
                        WHERE RE.RegionID = @PK)    
 
RETURN @RET
END
GO
 
ALTER TABLE tblREGION
ADD Calc_TotalTeams AS (dbo.fn_TotalTeamsRegion(RegionID))
GO