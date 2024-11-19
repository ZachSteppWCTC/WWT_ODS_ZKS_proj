/**************************
* Procedure ETL_LoadProducts
* Author: zstepp
* Create Date: 9/20/2024
* 
* Loads Products
* Inserts and Updates
**************************/
create   procedure ETL_LoadProducts
as
begin
update tgt_Products set
ProductName = stg_Products.ProductName,
ODSSupplierId = s.ODSSupplierID,
QuantityPerUnit = stg_Products.QuantityPerUnit,
Cost = stg_Products.WholesalePrice,
RetailPrice = stg_Products.UnitPrice,
ODSCategoryId = c.ODSCategoryId,
UnitsInStock = stg_Products.UnitsInStock,
UnitsOnOrder = stg_Products.UnitsOnOrder,
ReorderLevel = stg_Products.ReorderLevel,
Discontinued = stg_Products.Discontinued
from stg_Products
left join Products tgt_Products
on tgt_Products.SourceID = stg_Products.SourceID
and tgt_Products.orig_ProductID = stg_Products.ProductID
left join Suppliers s
on s.orig_SupplierID = stg_Products.SupplierID
and s.SourceID = stg_Products.SourceID
left join stg_Category oldc
on oldc.CategoryID = stg_Products.CategoryID
and oldc.SourceID = stg_Products.SourceID
left join Category c
on oldc.CategoryName = c.Category
where not ( isnull(stg_Products.ProductName,'') = isnull(tgt_Products.ProductName,'')
	and isnull(s.ODSSupplierID,-1) = isnull(tgt_Products.ODSSupplierId,-1)
	and isnull(stg_Products.QuantityPerUnit,-1) = isnull(tgt_Products.QuantityPerUnit,-1)
	and isnull(stg_Products.WholesalePrice,-1) = isnull(tgt_Products.Cost,-1)
	and isnull(stg_Products.UnitPrice,-1) = isnull(tgt_Products.RetailPrice,-1)
	and isnull(c.ODSCategoryId,-1) = isnull(tgt_Products.ODSCategoryId,-1)
	and isnull(stg_Products.UnitsInStock,'') = isnull(tgt_Products.UnitsInStock,'')
	and isnull(stg_Products.UnitsOnOrder,'') = isnull(tgt_Products.UnitsOnOrder,'')
	and isnull(stg_Products.ReorderLevel,'') = isnull(tgt_Products.ReorderLevel,'')
	and isnull(stg_Products.Discontinued,'') = isnull(tgt_Products.Discontinued,'')
)

insert into Products(SourceID, orig_ProductID, ProductName, ODSSupplierId, QuantityPerUnit, Cost, RetailPrice, ODSCategoryId, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
select distinct
stg_Products.SourceID, stg_Products.ProductID, stg_Products.ProductName, s.ODSSupplierID, stg_Products.QuantityPerUnit, stg_Products.WholesalePrice,
stg_Products.UnitPrice, c.ODSCategoryId, stg_Products.UnitsInStock, stg_Products.UnitsOnOrder, stg_Products.ReorderLevel, stg_Products.Discontinued
from stg_Products
left join Products tgt_Products
on tgt_Products.SourceID = stg_Products.SourceID
and tgt_Products.orig_ProductID = stg_Products.ProductID
left join Suppliers s
on s.orig_SupplierID = stg_Products.SupplierID
and s.SourceID = stg_Products.SourceID
left join stg_Category oldc
on oldc.CategoryID = stg_Products.CategoryID
and oldc.SourceID = stg_Products.SourceID
left join Category c
on oldc.CategoryName = c.Category
where tgt_Products.ODSProductID is null
end

