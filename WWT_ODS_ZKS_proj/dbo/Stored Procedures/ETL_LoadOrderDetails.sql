/**************************
* Procedure ETL_LoadOrderDetails
* Author: zstepp
* Create Date: 9/21/2024
* 
* Loads Orders
* Inserts, Deletes
*
* Updated 9/27/2024
* Adjusted joins for record accuracy
**************************/
create   procedure ETL_LoadOrderDetails
as
begin
Insert into OrderDetails(ODSOrderID, ODSProductID, UnitPrice, Quantity, Discount)
select distinct
ods_Orders.ODSOrderID,
ods_Products.ODSProductID,
stg_OrderDetails.UnitPrice,
stg_OrderDetails.Quantity,
stg_OrderDetails.Discount
from stg_OrderDetails
left join stg_Orders on
stg_Orders.OrderID = stg_OrderDetails.OrderID
and stg_Orders.SourceID = stg_OrderDetails.SourceID
left join Orders ods_Orders
on ods_Orders.SourceID = stg_Orders.SourceID
and ods_Orders.orig_OrderID = stg_Orders.OrderID
left join stg_Products on
stg_Products.ProductID = stg_OrderDetails.ProductID
and stg_Products.SourceID = stg_OrderDetails.SourceID
left join Products ods_Products
on ods_Products.SourceID = stg_Products.SourceID
and ods_Products.orig_ProductID = stg_Products.ProductID
left join OrderDetails tgt_OrderDetails
on tgt_OrderDetails.ODSOrderID = ods_Orders.ODSOrderID
and tgt_OrderDetails.ODSProductID = ods_Products.ODSProductID
where tgt_OrderDetails.ODSOrderID is null
and tgt_OrderDetails.ODSProductID is null

delete from OrderDetails
from OrderDetails
left join (
	select distinct
	ods_Orders.ODSOrderID,
	ods_Products.ODSProductID
	from stg_OrderDetails
	left join stg_Orders on
	stg_Orders.OrderID = stg_OrderDetails.OrderID
	and stg_Orders.SourceID = stg_OrderDetails.SourceID
	left join Orders ods_Orders
	on ods_Orders.SourceID = stg_Orders.SourceID
	and ods_Orders.orig_OrderID = stg_Orders.OrderID
	left join stg_Products on
	stg_Products.ProductID = stg_OrderDetails.ProductID
	and stg_Products.SourceID = stg_OrderDetails.SourceID
	left join Products ods_Products
	on ods_Products.SourceID = stg_Products.SourceID
	and ods_Products.orig_ProductID = stg_Products.ProductID
	left join OrderDetails tgt_OrderDetails
	on tgt_OrderDetails.ODSOrderID = ods_Orders.ODSOrderID
	and tgt_OrderDetails.ODSProductID = ods_Products.ODSProductID ) stg
on OrderDetails.ODSOrderID = stg.ODSOrderID
and OrderDetails.ODSProductID = stg.ODSProductID
where stg.ODSOrderID is null
end

