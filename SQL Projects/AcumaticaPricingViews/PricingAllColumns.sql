/************************************************************************************************
 *																								*
 *   7-30-24:    Created to list prices based on part number, if on a price list.               *
 *																								*
 ***********************************************************************************************/
select InventoryItem.CompanyID as "CompanyID", InventoryItem.InventoryCD, InventoryItem.InventoryID, InventoryItem.Descr, InventoryItem.BasePrice, InventoryItem.CountryOfOrigin
	   , TSPriceGroup.PriceGroupCode, ARSalesPrice.SalesPrice as "Dealer", 
	   (select B.SalesPrice from ARSalesPrice B where ARSalesPrice.CompanyID = B.CompanyID and ARSalesPrice.InventoryID = B.InventoryID and B.CustPriceClassID = 'PART') as "Part",
	   (select B.SalesPrice from ARSalesPrice B where ARSalesPrice.CompanyID = B.CompanyID and ARSalesPrice.InventoryID = B.InventoryID and B.CustPriceClassID = 'DIST') as "Dist",
	   (select B.SalesPrice from ARSalesPrice B where ARSalesPrice.CompanyID = B.CompanyID and ARSalesPrice.InventoryID = B.InventoryID and B.CustPriceClassID = 'SPEC') as "Spec"
from InventoryItem, TSPriceGroup, ARSalesPrice
where InventoryItem.UsrPriceGroupID = TSPriceGroup.RecID
  and tspricegroup.pricegroupcode in ('CORE','ET','KIOSK','DS','E-TAIL','RETAIL','SHADE','HOSP')
  and InventoryItem.CompanyID = TSPriceGroup.CompanyID
  and InventoryItem.CompanyID = '2'
  --and InventoryItem.InventoryCD = 'ST660'
  and InventoryItem.InventoryID = ARSalesPrice.InventoryID
  and InventoryItem.companyID = ARsalesPrice.CompanyID
  and ARSalesPrice.CustPriceClassID = 'DEAL'
