
-- Write the query to find the most used gaming platform in a tournament held in Poland.
SELECT TOP 1 P.GamePlatform, COUNT(*) AS Platform_Count
FROM tblPLATFORM P
    JOIN tblGAME_PLATFORM GP ON P.PlatformID = GP.PlatformID
    JOIN tblTOURNAMENT T ON GP.GamePlatformID = T.TournamentID
    JOIN tblSTADIUM S ON S.StadiumID = T.StadiumID
WHERE S.StadiumCountry = 'Poland'
GROUP BY GP.PlatformID, P.GamePlatform
ORDER BY Platform_Count DESC
GO

-- Write the query to find teams with the most Final Team Gold of each game in every region.
SELECT T.TeamID, T.TeamName, G.GameID, G.GameName,RG.Region, MAX(S.StatValue) AS StatVal
FROM tblTEAM T
    JOIN tblROSTER RT ON T.TeamID = RT.TeamID
    JOIN tblROSTER_ROUND RR ON RT.RosterID = RR.RosterID
    JOIN tblROSTER_ROUNDSTAT RRS ON RR.RosterRoundID = RRS.RosterRoundID
    JOIN tblSTATISTIC S ON S.StatID = RRS.StatID
    JOIN tblSTATISTIC_TYPE ST ON ST.StatTypeID = S.StatTypeID
    JOIN tblTOURNAMENT TM ON TM.TournamentID = RR.TournamentID
    JOIN tblGAME_PLATFORM GP ON GP.GamePlatformID = TM.GamePlatformID
    JOIN tblGAME G ON G.GameID = GP.GameID
    JOIN tblPERSON_ROSTER PR ON RT.RosterID = PR.RosterID
    JOIN tblPERSON P ON P.PersonID = PR.PersonID
    JOIN tblCOUNTRY C ON C.CountryID = P.CountryID
    JOIN tblREGION RG ON RG.RegionID = C.RegionID
WHERE ST.StatisticTypeName = 'Final Team Gold'
GROUP BY T.TeamID, T.TeamName, RG.RegionID, RG.Region, G.GameID, G.GameName
GO

-- Find regions that have less than 3 persons and at least 1 female person
SELECT A.RegionID, A.Region, A.totalPerson, B.totalFemale
FROM (SELECT R.RegionID, R.Region, COUNT(P.PersonID) AS totalPerson
	  FROM tblREGION R
		JOIN tblCOUNTRY C ON R.RegionID  = C.RegionID
		JOIN tblPERSON P ON C.CountryID = P.CountryID
	  GROUP BY R.RegionID, R.Region
	  HAVING totalPlayers < 3) A,
	 (SELECT R.RegionID, R.Region, COUNT(P.PersonID) AS totalFemale
	  FROM tblREGION R
		JOIN tblCOUNTRY C ON R.RegionID  = C.RegionID
		JOIN tblPERSON P ON C.CountryID = P.CountryID
		JOIN tblGENDER G ON P.GenderID = G.GenderID
	  WHERE G.GenderName = 'F'
	  GROUP BY R.RegionID, R.Region
	  HAVING COUNT(P.PersonID) >= 1) B
WHERE A.RegionID = B.RegionID

-- Find developers that made games which are played in Stadiums in the United States and is available on the PC
SELECT D.DeveloperID, D.Developer
FROM tblDEVELOPER D
	JOIN tblGAME_DEVELOPER GD ON D.DeveloperID = GD.DeveloperID
	JOIN tblGAME_PLATFORM GP ON GD.GamePlatformID = GP.GamePlatformID
	JOIN tblTOURNAMENT T ON GP.GamePlatformID = T.GamePlatformID
	JOIN tblSTADIUM S ON T.StadiumID = S.StadiumID
	JOIN tblPLATFORM P ON GP.PlatformID = P.PlatformID
WHERE P.GamePlatform = 'PC'
AND S.StadiumCountry = 'United States'

--Games released on multiple platforms that also have been played in more than one tournament
SELECT A.GameID, A.GameName, A.NumPlatforms, B.NumTournaments
FROM (SELECT G.GameID, G.GameName, COUNT(P.PlatformID) AS NumPlatforms 
		FROM tblGAME G
		JOIN tblGAME_PLATFORM GP ON G.GameID = GP.GameID
		JOIN tblPLATFORM P ON P.PlatformID = GP.PlatformID
		HAVING COUNT(P.PlatformID) > 1
		GROUP BY G.GameID) A,
	(SELECT G.GameID, G.GameName, COUNT(T.TournamentID) AS NumTournaments
		FROM tblGAME
		JOIN tblGAME_PLATFORM GP ON G.GameID = GP.GameID
		JOIN tblTOURNAMENT T ON T.GamePlatformID = GP.GamePlatformID
		HAVING COUNT(T.TournamentID) > 1
		GROUP BY G.GameID) B
WHERE A.GameID = B.GameID

--Select Rosters that have participated in at least 2 rounds lasting less than 1 hour and have at least 3 people who are older than 20
SELECT A.RosterID, A.RosterName, A.NumRounds, B.Num20Plus
FROM (SELECT R.RosterID, R.RosterName, COUNT(RR.RosterRoundID) AS NumRounds
		FROM tblROSTER R
		JOIN tblROSTER_ROUND RR ON R.RosterID = RR.RosterID
		WHERE DATEPART(HOUR, RR.StartTime - RR.EndTime) < 1)
		HAVING COUNT(RosterRoundID >= 2)
		GROUP BY R.RosterID) A,
	(SELECT R.RosterID, R.RosterName, COUNT(P.PersonID) AS Num20Plus
	FROM tblROSTER R
	JOIN tblPERSON_ROSTER PR ON PR.RosterID = R.RosterID
	JOIN tblPERSON P ON P.PersonID = PR.PersonID
	WHERE P.PersonBirth < DATEADD(MONTH, -12 * 20, GETDATE())
	HAVING COUNT(P.PersonID) >= 3
	GROUP BY R.RosterID) B
WHERE A.RosterID = B.RosterID

--Write the query to return the average salary for the teams from the United States
SELECT T.TeamID, T.TeamName, AVG(RO.Salary) AS SalaryAVG
FROM tblROSTER R
    JOIN tblTEAM T ON R.TeamID = T.TeamID
    JOIN tblROLE RO ON R.RoleID = RO.RoleID
    JOIN tblPERSON_ROSTER PR ON R.RosterID = PR.RosterID
    JOIN tblPERSON P ON PR.PersonID = P.PersonID
    JOIN tblCOUNTRY C ON P.CountryID = C.CountryID
WHERE C.CountryName = 'United States'
GROUP BY T.TeamID, T.TeamName, SalaryAVG
GO

--Count the total number of coaches from China
SELECT COUNT(*) AS totalCoaches
FROM tblROSTER R
    JOIN tblTEAM T ON R.TeamID = T.TeamID
    JOIN tblROLE RO ON R.RoleID = RO.RoleID
    JOIN tblPERSON_ROSTER PR ON R.RosterID = PR.RosterID
    JOIN tblPERSON P ON PR.PersonID = P.PersonID
    JOIN tblCOUNTRY C ON P.CountryID = C.CountryID
WHERE C.CountryName = 'China'
AND RO.RoleName = 'Coach'