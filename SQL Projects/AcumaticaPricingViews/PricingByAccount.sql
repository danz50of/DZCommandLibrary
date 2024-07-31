/****************************************************************************
 *																			*
 * 7-30-2024:  SQL will pull pricing by account, listing all products with  *
 *             price groups, and then all account specific pricing.         *
 *																			*
 ***************************************************************************/
select TSCustomerPriceGroup.CompanyID, TSCustomerPriceGroup.Description as "Customer Name", BAccount.AcctCD as "Customer", TSCustomerpriceGroup.PriceClassID as "Customer Price Class", InventoryItem.InventoryCD as "Part Number", InventoryItem.Descr as "Description", TSPriceGroup.PriceGroupDescription as "Product Group", arsalesprice.SalesPrice as "Price"
, (CASE InventoryItem.ItemStatus
		when 'AC' then 'Active'
		when 'NS' then 'No Sale'
		when 'NP' then 'No Purchase'
		when 'NR' then 'No Request'
		when 'IN' then 'Inactive'
		when 'DE' then 'Marked for Deletion'
   End)as "Item Status"
, ARSalesPrice.ExpirationDate
, (select B.SalesPrice from ARSalesPrice B where B.CompanyID = ARSalesPrice.CompanyID and ARSalesPrice.InventoryID = B.InventoryID and B.CustPriceClassID = 'MAPCA' and B.EffectiveDate = '4/12/2024') AS "MAP CA"
, (select B.SalesPrice from ARSalesPrice B where B.CompanyID = ARSalesPrice.CompanyID and ARSalesPrice.InventoryID = B.InventoryID and B.CustPriceClassID = 'MAPUS' and B.EffectiveDate = '4/12/2024') AS "MAP NA"
from TSCustomerPriceGroup, BAccount, TSPriceGroup, InventoryItem, ARSalesPrice
where TSCustomerPriceGroup.CompanyID = 2
and TSCustomerPriceGroup.CompanyID = BAccount.CompanyID
and TSCustomerPriceGroup.Description = BAccount.AcctName
and TSCustomerPriceGroup.CompanyID = TSPriceGroup.CompanyID
and TSCustomerPriceGroup.PriceGroupID = TSPriceGroup.RecID
and inventoryitem.CompanyID = TSCustomerPriceGroup.CompanyID
and InventoryItem.usrPriceGroupID = TSCustomerPriceGroup.PriceGroupID
and BAccount.AcctCD in ('DIV186550', 'BHP074571')
and InventoryItem.InventoryID = ARSalesPrice.InventoryID
and ARSalesprice.CompanyID = TSCustomerPriceGroup.CompanyID
and arsalesprice.CustPriceClassID = TSCustomerPriceGroup.PriceClassID
--and InventoryItem.InventoryCD = 'ST660'
Union
select BAccount.CompanyID, BAccount.AcctName, BAccount.AcctCD, 'Customer Pricing', InventoryItem.InventoryCD, InventoryItem.Descr, TSPriceGroup.PriceGroupDescription, arsalesprice.SalesPrice
, (CASE InventoryItem.ItemStatus
		when 'AC' then 'Active'
		when 'NS' then 'No Sale'
		when 'NP' then 'No Purchase'
		when 'NR' then 'No Request'
		when 'IN' then 'Inactive'
		when 'DE' then 'Marked for Deletion'
   End)
, ARSalesPrice.ExpirationDate
, (select C.SalesPrice from ARSalesPrice C where C.CompanyID = ARSalesPrice.CompanyID and ARSalesPrice.InventoryID = C.InventoryID and C.CustPriceClassID = 'MAPCA' and c.EffectiveDate = '4/12/2024') AS "MAP CA"
, (select C.SalesPrice from ARSalesPrice C where C.CompanyID = ARSalesPrice.CompanyID and ARSalesPrice.InventoryID = C.InventoryID and C.CustPriceClassID = 'MAPUS' and c.EffectiveDate = '4/12/2024') AS "MAP NA"
from BAccount, TSPriceGroup, InventoryItem, ARSalesPrice
where BAccount.CompanyID = 2
and ARSalesPrice.CustomerID = BAccount.BAccountID
and BAccount.CompanyID = TSPriceGroup.CompanyID
and inventoryitem.CompanyID = BAccount.CompanyID
and BAccount.AcctCD in ('DIV186550', 'BHP074571')
and InventoryItem.InventoryID = ARSalesPrice.InventoryID
--and InventoryItem.InventoryCD = 'ST660'
and inventoryItem.UsrPriceGroupID = TSPriceGroup.RecID





