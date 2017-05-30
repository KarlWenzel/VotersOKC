/****** Object:  Table [dbo].[OkcCensusTracts]    Script Date: 5/28/2017 5:08:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CensusMetadata](
	[CensusYear] [int] NOT NULL,
	[Short_Name] [nvarchar](255) NOT NULL,
	[Full_Name] [nvarchar](1024) NULL,
 CONSTRAINT [PK_CensusMetadata] PRIMARY KEY CLUSTERED 
(
	[CensusYear] ASC,
	[Short_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[CensusTracts](
	[GEOID] [int] NOT NULL,
	[GEOID_Data] [nvarchar](255) NULL,
	[CensusTract] [int] NULL,
	[CensusTractName] [nvarchar](255) NULL,
	[StateFP] [int] NULL,
	[CountyFP] [int] NULL,
	[County] [nvarchar](255) NULL,
	[SquareFt] [float] NULL,
 CONSTRAINT [PK_CensusTracts] PRIMARY KEY CLUSTERED 
(
	[GEOID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[OkcCensusTracts](
	[rownames] [int] NOT NULL,
	[GEOID] [varchar](255) NULL,
	[CensusTract] [varchar](255) NULL,
	[Precinct] [int] NULL,
	[SquareFt] [float] NULL,
 CONSTRAINT [PK_OkcCensusTracts] PRIMARY KEY CLUSTERED 
(
	[rownames] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OkcVoterHistory](
	[VoterID] [int] NOT NULL,
	[ElectionDate] [datetime] NOT NULL,
	[VotingMethod] [nvarchar](50) NULL,
 CONSTRAINT [PK_OkcVoterHistory] PRIMARY KEY CLUSTERED 
(
	[VoterID] ASC,
	[ElectionDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OkcVoters](
	[Precinct] [int] NULL,
	[LastName] [varchar](255) NULL,
	[FirstName] [varchar](255) NULL,
	[MiddleName] [varchar](255) NULL,
	[Suffix] [varchar](255) NULL,
	[VoterID] [int] NOT NULL,
	[PolitalAff] [varchar](255) NULL,
	[Status] [varchar](255) NULL,
	[StreetNum] [varchar](255) NULL,
	[StreetDir] [varchar](255) NULL,
	[StreetName] [varchar](255) NULL,
	[StreetType] [varchar](255) NULL,
	[BldgNum] [varchar](255) NULL,
	[City] [varchar](255) NULL,
	[Zip] [varchar](255) NULL,
	[DateOfBirth] [datetime] NULL,
	[OriginalRegistration] [datetime] NULL,
	[MailStreet1] [varchar](255) NULL,
	[MailStreet2] [varchar](255) NULL,
	[MailCity] [varchar](255) NULL,
	[MailState] [varchar](255) NULL,
	[MailZip] [varchar](255) NULL,
	[Muni] [varchar](255) NULL,
	[MuniSub] [varchar](255) NULL,
	[School] [varchar](255) NULL,
	[SchoolSub] [varchar](255) NULL,
	[TechCenter] [varchar](255) NULL,
	[TechCenterSub] [varchar](255) NULL,
	[CountyComm] [varchar](255) NULL,
	[County] [varchar](255) NULL,
 CONSTRAINT [PK__OkcVoter__12D25BD8093918FC] PRIMARY KEY CLUSTERED 
(
	[VoterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[OkcVoterHistory]  WITH CHECK ADD  CONSTRAINT [FK_OkcVoterHistory_OkcVoters] FOREIGN KEY([VoterID])
REFERENCES [dbo].[OkcVoters] ([VoterID])
GO
ALTER TABLE [dbo].[OkcVoterHistory] CHECK CONSTRAINT [FK_OkcVoterHistory_OkcVoters]
GO

CREATE TABLE [dbo].[Precincts](
	[Precinct] [int] NOT NULL,
	[County] [nvarchar](255) NULL,
	[StateHouse] [nvarchar](255) NULL,
	[StateSenate] [nvarchar](255) NULL,
	[SquareFt] [float] NULL,
 CONSTRAINT [PK_Precincts] PRIMARY KEY CLUSTERED 
(
	[Precinct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[OkcPrecincts](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Precinct] [int] NULL,
	[County] [nvarchar](255) NULL,
	[Ward] [nvarchar](255) NULL,
	[StateHouse] [nvarchar](255) NULL,
	[StateSenate] [nvarchar](255) NULL,
	[SquareFt] [float] NULL,
 CONSTRAINT [PK_OkcPrecincts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[LoadOkcVoterHistory]
AS
INSERT INTO OkcVoterHistory (VoterID, ElectionDate, VotingMethod)
SELECT
	VoterID,
	CAST(ElectionDate AS DATETIME),
	VotingMethod
FROM
(
	SELECT * FROM [dbo].[CTY09_vh] WHERE VoterID IN (SELECT VoterID FROM OkcVoters)
	UNION
	SELECT * FROM [dbo].[CTY14_vh] WHERE VoterID IN (SELECT VoterID FROM OkcVoters)
	UNION
	SELECT * FROM [dbo].[CTY55_vh] WHERE VoterID IN (SELECT VoterID FROM OkcVoters)
	UNION
	SELECT * FROM [dbo].[CTY63_vh] WHERE VoterID IN (SELECT VoterID FROM OkcVoters)
) as tt
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[LoadOkcVoters]
AS
INSERT INTO [dbo].[OkcVoters]
(
	[Precinct]
	,[LastName]
	,[FirstName]
	,[MiddleName]
	,[Suffix]
	,[VoterID]
	,[PolitalAff]
	,[Status]
	,[StreetNum]
	,[StreetDir]
	,[StreetName]
	,[StreetType]
	,[BldgNum]
	,[City]
	,[Zip]
	,[DateOfBirth]
	,[OriginalRegistration]
	,[MailStreet1]
	,[MailStreet2]
	,[MailCity]
	,[MailState]
	,[MailZip]
	,[Muni]
	,[MuniSub]
	,[School]
	,[SchoolSub]
	,[TechCenter]
	,[TechCenterSub]
	,[CountyComm]
	,[County]
)
SELECT
	[Precinct]
	,[LastName]
	,[FirstName]
	,[MiddleName]
	,[Suffix]
	,[VoterID]
	,[PolitalAff]
	,[Status]
	,[StreetNum]
	,[StreetDir]
	,[StreetName]
	,[StreetType]
	,[BldgNum]
	,[City]
	,[Zip]
	,CASE IsDate([DateOfBirth]) WHEN 1 THEN CAST([DateOfBirth] AS DATETIME) ELSE NULL END
	,CASE IsDate([OriginalRegistration]) WHEN 1 THEN CAST([OriginalRegistration] AS DATETIME) ELSE NULL END
	,[MailStreet1]
	,[MailStreet2]
	,[MailCity]
	,[MailState]
	,[MailZip]
	,[Muni]
	,[MuniSub]
	,[School]
	,[SchoolSub]
	,[TechCenter]
	,[TechCenterSub]
	,[CountyComm]
	,[County]
FROM
(
 SELECT *, 'Canadian' AS County FROM CTY09_vr WHERE Muni = 'CITY OF OKLAHOMA CITY AT LARGE'
 UNION
 SELECT *, 'Cleveland' AS County FROM CTY14_vr WHERE Muni = 'CITY OF OKLAHOMA CITY AT LARGE'
 UNION
 SELECT *, 'Oklahoma' AS County FROM CTY55_vr WHERE Muni = 'CITY OF OKLAHOMA CITY AT LARGE'
 UNION
 SELECT *, 'Pottawatomie' AS County FROM CTY63_vr WHERE Muni = 'CITY OF OKLAHOMA CITY AT LARGE'
) AS TT
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SelectOkcPrecinctSummary]
as
select 
	t1.Precinct, 
	t1.RegisteredVoters, 
	isnull(t2.RepublicanVoters, 0) as RepublicanVoters, 
	100 * isnull(t2.RepublicanVoters, 0) / nullif(t1.RegisteredVoters,0) as PercentRepublican,
	isnull(t3.DemocratVoters, 0) as DemocratVoters,
	100 * isnull(t3.DemocratVoters, 0) / nullif(t1.RegisteredVoters,0) as PercentDemocrat, 
	isnull(t4.LibertarianVoters, 0) as LibertarianVoters, 
	100 * isnull(t4.LibertarianVoters, 0) / nullif(t1.RegisteredVoters,0) as PercentLibertarian,
	isnull(t5.IndependentVoters, 0) as IndependentVoters,
	100 * isnull(t5.IndependentVoters, 0) / nullif(t1.RegisteredVoters,0) as PercentIndependent
 from
	(select Precinct, count(*) as RegisteredVoters from OkcVoters group by Precinct) as t1
	left outer join (select Precinct, count(*) as RepublicanVoters from OkcVoters where PolitalAff='REP' group by Precinct) as t2 on t1.Precinct = t2.Precinct
	left outer join (select Precinct, count(*) as DemocratVoters from OkcVoters where PolitalAff='DEM' group by Precinct) as t3 on t1.Precinct = t3.Precinct
	left outer join (select Precinct, count(*) as LibertarianVoters from OkcVoters where PolitalAff='LIB' group by Precinct) as t4 on t1.Precinct = t4.Precinct
	left outer join (select Precinct, count(*) as IndependentVoters from OkcVoters where PolitalAff='IND' group by Precinct) as t5 on t1.Precinct = t5.Precinct

GO
