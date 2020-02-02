Select AccountNumber, AccountName, State, NationalDirector, Rep, Year, Year_Gross as 'Year_Gross_2018', Year_Net as 'Year_Net_2018', null as 'Year_Gross_2019', null as 'Year_Net_2019'
from dbo.EOM_2018_Total
union
Select AccountNumber, AccountName, State, NationalDirector, Rep, Year, null, null, Year_Gross, Year_Net
from dbo.EOM_2019_Total
