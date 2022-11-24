
--tblTeam:
INSERT INTO tblTEAM(TeamName, Founded, TeamEmail, TeamLogo)
VALUES ('Team Solomid', 'January 15 2011', 'tsm@gmail.com', 'TSM_2019_lightmode.png')
INSERT INTO tblTEAM(TeamName, Founded, TeamEmail, TeamLogo)
VALUES ('Team Liquid', 'February 11 2013', 'teamliquid@gmail.com', 'Team_Liquid_2017_lightmode.png')
INSERT INTO tblTEAM(TeamName, Founded, TeamEmail, TeamLogo)
VALUES ('Team CRRB', 'May 12 2010', 'crrb@gmail.com', 'teamCRRB.png')
INSERT INTO tblTEAM(TeamName, Founded, TeamEmail, TeamLogo)
VALUES ('Team Hay', 'October 1 2011', 'thay@gmail.com', 'teamHay.png')
INSERT INTO tblTEAM(TeamName, Founded, TeamEmail, TeamLogo)
VALUES ('Cloud 9', 'December 15 2015', 'c9@gmail.com', 'c9,png')
INSERT INTO tblTEAM(TeamName, Founded, TeamEmail, TeamLogo)
VALUES ('Royal Never Give Up', 'March 15 2012', 'rng@gmail.com', 'rng.png')
INSERT INTO tblTEAM(TeamName, Founded, TeamEmail, TeamLogo)
VALUES ('T1', 'August 22 2011', 't1@gmail.com', 't1.png')
INSERT INTO tblTEAM(TeamName, Founded, TeamEmail, TeamLogo)
VALUES ('100 Thieves', 'November 11 2014', '100t@gmail.com', '100t.png')

--tblRole:
INSERT INTO tblROLE(RoleName, Salary)
VALUES ('Coach', 120000.12)
INSERT INTO tblROLE(RoleName, Salary)
VALUES ('Assistant Coach', 100000)
INSERT INTO tblROLE(RoleName, Salary)
VALUES ('Manager', 200000.65)
INSERT INTO tblROLE(RoleName, Salary)
VALUES ('Assistant Manager', 150000.20)
INSERT INTO tblROLE(RoleName, Salary)
VALUES ('Player', 300000.15)

--tblStatistic:
INSERT INTO tblSTATISTIC_TYPE(StatisticTypeName, StatisticTypeDesc)
VALUES ('Kills', 'Number of kills in a game or round')
INSERT INTO tblSTATISTIC_TYPE(StatisticTypeName, StatisticTypeDesc)
VALUES ('Deaths', 'Number of deaths or failed attempts in a game or round')
INSERT INTO tblSTATISTIC_TYPE(StatisticTypeName, StatisticTypeDesc)
VALUES ('Assists', 'Number of assists in a game or round')
INSERT INTO tblSTATISTIC_TYPE(StatisticTypeName, StatisticTypeDesc)
VALUES ('Accuracy', 'Total landed shots for a player in a game or round')
INSERT INTO tblSTATISTIC_TYPE(StatisticTypeName, StatisticTypeDesc)
VALUES ('Average Elixir', 'Currency in the form of exlixir for clash royale for a single card deck')
INSERT INTO tblSTATISTIC_TYPE(StatisticTypeName, StatisticTypeDesc)
VALUES ('Rank', 'The rank of a player or team in a game')
INSERT INTO tblSTATISTIC_TYPE(StatisticTypeName, StatisticTypeDesc)
VALUES ('Trophies', 'Total trophies earned by a player in Clash Royale')
INSERT INTO tblSTATISTIC_TYPE(StatisticTypeName, StatisticTypeDesc)
VALUES ('Goals', 'Total goals scored by a player or team in Rocket League')
INSERT INTO tblSTATISTIC_TYPE(StatisticTypeName, StatisticTypeDesc)
VALUES ('Creep Score', 'Total farm accumulated by a player in League of Legends')
INSERT INTO tblSTATISTIC_TYPE(StatisticTypeName, StatisticTypeDesc)
VALUES ('Final Team Gold', 'Total gold earned by a team or player in League of Legends')

--tblROUND:
INSERT INTO tblROUND(RoundType)
VALUES ('Grand Finals')
GO

INSERT INTO tblROUND(RoundType)
VALUES ('Finals')
GO

INSERT INTO tblROUND(RoundType)
VALUES ('Semifinals')
GO

INSERT INTO tblROUND(RoundType)
VALUES ('Quarterfinals')
GO

INSERT INTO tblROUND(RoundType)
VALUES ('Round of 16')
GO

INSERT INTO tblROUND(RoundType)
VALUES ('Round of 32')
GO

INSERT INTO tblROUND(RoundType)
VALUES ('Losers Finals')
GO

INSERT INTO tblROUND(RoundType)
VALUES ('Losers Semifinals')
GO

INSERT INTO tblROUND(RoundType)
VALUES ('Losers Quarterfinals')
GO

INSERT INTO tblROUND(RoundType)
VALUES ('Losers Round of 16')
GO

--tblSTADIUM:
INSERT INTO tblSTADIUM(StadiumCapacity, StadiumName, StadiumCountry, StadiumCity)
VALUES(2500, 'ESports Stadium', 'United States', 'Arlington, TX')
GO

INSERT INTO tblSTADIUM(StadiumCapacity, StadiumName, StadiumCountry, StadiumCity)
VALUES(7500, 'Anaheim Convention Center', 'United States', 'Anaheim, CA')
GO

INSERT INTO tblSTADIUM(StadiumCapacity, StadiumName, StadiumCountry, StadiumCity)
VALUES(7500, 'Copper Box Arena', 'England', 'London')
GO

INSERT INTO tblSTADIUM(StadiumCapacity, StadiumName, StadiumCountry, StadiumCity)
VALUES(11500, 'Spodek Arena', 'Poland', 'Katowice')
GO

INSERT INTO tblSTADIUM(StadiumCapacity, StadiumName, StadiumCountry, StadiumCity)
VALUES(17000, 'Royal Arena', 'Denmark', 'Copenhagen')
GO


--tblGENDER:
INSERT INTO tblGENDER (GenderName)
VALUES ('M')
GO

INSERT INTO tblGENDER (GenderName)
VALUES ('F')
GO

--tblREGION:
INSERT INTO tblREGION(Region)
VALUES ('Africa')
GO

INSERT INTO tblREGION(Region)
VALUES ('Asia')
GO

INSERT INTO tblREGION(Region)
VALUES ('The Caribbean')
GO

INSERT INTO tblREGION(Region)
VALUES ('Central America')
GO

INSERT INTO tblREGION(Region)
VALUES ('Europe')
GO

INSERT INTO tblREGION(Region)
VALUES ('North America')
GO

INSERT INTO tblREGION(Region)
VALUES ('Oceania')
GO

INSERT INTO tblREGION(Region)
VALUES ('South America')
GO

--tblPLATFORM:
INSERT INTO tblPLATFORM(GamePlatform)
VALUES('The Sony PlayStation')
GO

INSERT INTO tblPLATFORM(GamePlatform)
VALUES('Microsoft''s Xbox')
GO

INSERT INTO tblPLATFORM(GamePlatform)
VALUES('Nintendo''s Switch')
GO

INSERT INTO tblPLATFORM(GamePlatform)
VALUES('PC')
GO

--tblGAME:
INSERT INTO tblGAME
(GameName)
VALUES ('Fortnite')

INSERT INTO tblGAME
(GameName)
VALUES ('Valorant')

INSERT INTO tblGAME
(GameName)
VALUES ('Apex Legends')

INSERT INTO tblGAME
(GameName)
VALUES ('Call of Duty: Warzone')

INSERT INTO tblGAME
(GameName)
VALUES ('League of Legends')

INSERT INTO tblGAME
(GameName)
VALUES ('Rocket League')

INSERT INTO tblGAME
(GameName)
VALUES ('Counter-Strike: Global Offensive')

INSERT INTO tblGAME
(GameName)
VALUES ('Overwatch')

INSERT INTO tblGAME
(GameName)
VALUES ('Tom Clancy''s Rainbow Six Siege')

INSERT INTO tblGAME
(GameName)
VALUES ('Clash Royale')

INSERT INTO tblGAME
(GameName)
VALUES ('Dota 2')

INSERT INTO tblGAME
(GameName)
VALUES ('Super Smash Bros. Ultimate')

--tblDEVELOPER:
INSERT INTO tblDEVELOPER
(Developer)
VALUES ('Riot Games')

INSERT INTO tblDEVELOPER
(Developer)
VALUES ('Electronic Arts')

INSERT INTO tblDEVELOPER
(Developer)
VALUES ('Ubisoft')

INSERT INTO tblDEVELOPER
(Developer)
VALUES ('Epic Games')

INSERT INTO tblDEVELOPER
(Developer)
VALUES ('Infinity Ward')

INSERT INTO tblDEVELOPER
(Developer)
VALUES ('Blizzard Entertainment')

INSERT INTO tblDEVELOPER
(Developer)
VALUES ('Psyonix')

INSERT INTO tblDEVELOPER
(Developer)
VALUES ('Valve')

INSERT INTO tblDEVELOPER
(Developer)
VALUES ('Supercell')