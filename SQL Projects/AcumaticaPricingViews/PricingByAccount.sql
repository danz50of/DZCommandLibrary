/****************************************************************************
 *																			*
 * 7-30-2024:  SQL will pull pricing by account, listing all products with  *
 *             price groups, and then all account specific pricing.         *
 *																			*
 ***************************************************************************/
select TSCustomerPriceGroup.CompanyID, TSCustomerPriceGroup.Description, BAccount.AcctCD, TSCustomerpriceGroup.PriceClassID, InventoryItem.InventoryCD, InventoryItem.Descr, TSPriceGroup.PriceGroupDescription, arsalesprice.SalesPrice
from TSCustomerPriceGroup, BAccount, TSPriceGroup, InventoryItem, ARSalesPrice
where TSCustomerPriceGroup.CompanyID = 2
and TSCustomerPriceGroup.CompanyID = BAccount.CompanyID
and TSCustomerPriceGroup.Description = BAccount.AcctName
and TSCustomerPriceGroup.CompanyID = TSPriceGroup.CompanyID
and TSCustomerPriceGroup.PriceGroupID = TSPriceGroup.RecID
and inventoryitem.CompanyID = TSCustomerPriceGroup.CompanyID
and InventoryItem.usrPriceGroupID = TSCustomerPriceGroup.PriceGroupID
and BAccount.AcctCD = 'DIV186550'
and InventoryItem.InventoryID = ARSalesPrice.InventoryID
and ARSalesprice.CompanyID = TSCustomerPriceGroup.CompanyID
and arsalesprice.CustPriceClassID = TSCustomerPriceGroup.PriceClassID
and InventoryItem.InventoryCD = 'ST660'
Union
select BAccount.CompanyID, BAccount.AcctName, BAccount.AcctCD, 'Customer Pricing', InventoryItem.InventoryCD, InventoryItem.Descr, TSPriceGroup.PriceGroupDescription, arsalesprice.SalesPrice
from BAccount, TSPriceGroup, InventoryItem, ARSalesPrice
where BAccount.CompanyID = 2
and ARSalesPrice.CustomerID = BAccount.BAccountID
and BAccount.CompanyID = TSPriceGroup.CompanyID
and inventoryitem.CompanyID = BAccount.CompanyID
and BAccount.AcctCD = 'DIV186550'
and InventoryItem.InventoryID = ARSalesPrice.InventoryID
and InventoryItem.InventoryCD = 'ST660'
and inventoryItem.UsrPriceGroupID = TSPriceGroup.RecID


select * from TSPriceGroup