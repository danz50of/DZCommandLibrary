/****** Script for SelectTopNRows command from SSMS  ******/
SELECT sum(Year_2018_Gross), sum(Year_2018_net), sum(year_2019_gross), sum(year_2019_net)
  FROM [Peerless-AVAnalytics].[dbo].[EOM_2018_2019_Summary]