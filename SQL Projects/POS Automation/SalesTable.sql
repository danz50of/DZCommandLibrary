/****** Object:  Table [dbo].[Sales]    Script Date: 1/13/2023 7:33:05 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Sales](
	[Id] [uniqueidentifier] NOT NULL,
	[UploadId] [uniqueidentifier] NULL,
	[Customer] [nvarchar](max) NULL,
	[SoldToName] [nvarchar](max) NULL,
	[SaleDate] [datetime2](7) NOT NULL,
	[CustomerPartNumber] [nvarchar](max) NULL,
	[PiiPartNumber] [nvarchar](max) NULL,
	[PiiCategory] [nvarchar](max) NULL,
	[PartId] [uniqueidentifier] NULL,
	[ShipQuantity] [int] NOT NULL,
	[ExtendedSales] [decimal](18, 2) NOT NULL,
	[BillToCustomerZip] [nvarchar](max) NULL,
	[BillToCustomerState] [nvarchar](max) NULL,
	[SalesRep] [nvarchar](max) NULL,
	[ShipToState] [nvarchar](max) NULL,
	[ShipToZip] [nvarchar](max) NULL,
	[Period] [datetime2](7) NOT NULL,
	[SalesRepAssignedRule] [nvarchar](max) NULL,
	[PeriodDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Sales] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Sales]  WITH CHECK ADD  CONSTRAINT [FK_Sales_Parts_PartId] FOREIGN KEY([PartId])
REFERENCES [dbo].[Parts] ([Id])
GO

ALTER TABLE [dbo].[Sales] CHECK CONSTRAINT [FK_Sales_Parts_PartId]
GO

ALTER TABLE [dbo].[Sales]  WITH CHECK ADD  CONSTRAINT [FK_Sales_Uploads_UploadId] FOREIGN KEY([UploadId])
REFERENCES [dbo].[Uploads] ([Id])
GO

ALTER TABLE [dbo].[Sales] CHECK CONSTRAINT [FK_Sales_Uploads_UploadId]
GO


