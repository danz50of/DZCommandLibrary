USE [Peerless-AVAnalytics]
GO

/****** Object:  Table [dbo].[EOM_Rolling_5YR]    Script Date: 2/3/2020 6:05:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EOM_Rolling_5YR](
	[AccountNumber] [varchar](50) NOT NULL,
	[AccountName] [varchar](max) NOT NULL,
	[City] [varchar](max) NULL,
	[State] [varchar](20) NULL,
	[Zip] [varchar](20) NULL,
	[NationalDirector] [varchar](20) NULL,
	[Rep] [varchar](20) NULL,
	[Period_Date] [date] NOT NULL,
	[Year_Char] [varchar](4) NOT NULL,
	[Year_Gross] [float] NULL,
	[Year_Net] [float] NULL,
	[Period_Gross] [float] NOT NULL,
	[Period_Net] [float] NOT NULL,
 CONSTRAINT [PK_EOM_Rolling_5YR] PRIMARY KEY CLUSTERED 
(
	[AccountNumber] ASC,
	[Period_Date] ASC,
	[Year_Char] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

--DZ  2-2-2020:  Create 2018 EOM table to begin analytics for 2018 v 2019
--               When creating new tables, use script, change year!!