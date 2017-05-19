USE [Votes]
GO

/****** Object:  Table [dbo].[OkcVoters]    Script Date: 5/18/2017 6:14:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[OkcVoters](
	[Precinct] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[FirstName] [varchar](50) NULL,
	[MiddleName] [varchar](50) NULL,
	[Suffix] [varchar](50) NULL,
	[VoterID] [varchar](50) PRIMARY KEY,
	[PolitalAff] [varchar](50) NULL,
	[Status] [varchar](50) NULL,
	[StreetNum] [varchar](50) NULL,
	[StreetDir] [varchar](50) NULL,
	[StreetName] [varchar](50) NULL,
	[StreetType] [varchar](50) NULL,
	[BldgNum] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[Zip] [varchar](50) NULL,
	[DateOfBirth] [varchar](50) NULL,
	[OriginalRegistration] [varchar](50) NULL,
	[MailStreet1] [varchar](50) NULL,
	[MailStreet2] [varchar](50) NULL,
	[MailCity] [varchar](50) NULL,
	[MailState] [varchar](50) NULL,
	[MailZip] [varchar](50) NULL,
	[Muni] [varchar](50) NULL,
	[MuniSub] [varchar](50) NULL,
	[School] [varchar](50) NULL,
	[SchoolSub] [varchar](50) NULL,
	[TechCenter] [varchar](50) NULL,
	[TechCenterSub] [varchar](50) NULL,
	[CountyComm] [varchar](50) NULL,
	[VoterHist1] [varchar](50) NULL,
	[HistMethod1] [varchar](50) NULL,
	[VoterHist2] [varchar](50) NULL,
	[HistMethod2] [varchar](50) NULL,
	[VoterHist3] [varchar](50) NULL,
	[HistMethod3] [varchar](50) NULL,
	[VoterHist4] [varchar](50) NULL,
	[HistMethod4] [varchar](50) NULL,
	[VoterHist5] [varchar](50) NULL,
	[HistMethod5] [varchar](50) NULL,
	[VoterHist6] [varchar](50) NULL,
	[HistMethod6] [varchar](50) NULL,
	[VoterHist7] [varchar](50) NULL,
	[HistMethod7] [varchar](50) NULL,
	[VoterHist8] [varchar](50) NULL,
	[HistMethod8] [varchar](50) NULL,
	[VoterHist9] [varchar](50) NULL,
	[HistMethod9] [varchar](50) NULL,
	[VoterHist10] [varchar](50) NULL,
	[HistMethod10] [varchar](50) NULL,
	County varchar(50) NULL
) ON [PRIMARY]

GO


