-- ================================================
-- Template generated from Template Explorer using:
-- Create Scalar Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufnGetGLBatch](@prod_ord_nbr nvarchar(15))
returns nvarchar(15)
AS
BEGIN
	-- Declare the return variable here
	DECLARE <@ResultVar, sysname, @Result> <Function_Data_Type, ,int>

	-- Add the T-SQL statements to compute the return value here
	SELECT [CompanyID]
      ,[GLBatNbr]
	FROM [dbo].[AMMTran] where ProdOrdID = 'RO00000059'
		AND  GLBATNBR IS NOT NULL
	UNION
	SELECT [CompanyID]
		  ,OrigBatNbr
	FROM [dbo].[AMMTran] where ProdOrdID = 'RO00000059'
		AND GLBATNBR IS NULL AND ORIGBATNBR IS NOT NULL

	-- Return the result of the function
	RETURN <@ResultVar, sysname, @Result>

END
GO

