USE [caWeb4_TEST]
GO

SELECT [Customer]
      ,[CustomerName]
      ,[Part]
      ,[Supplier]
      ,[Trade]
      ,[ID]
  FROM [dbo].[I_CustomerData]
  WHERE CustomerName like 'VOLT%'
GO


