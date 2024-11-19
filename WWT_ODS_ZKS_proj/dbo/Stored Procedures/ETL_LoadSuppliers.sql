/**************************
* Procedure ETL_LoadSuppliers
* Author: zstepp
* Create Date: 9/20/2024
* 
* Loads Suppliers
* Inserts and Updates
*
* Updated: 9/27/2024
* Concatenate versions of Address1 and Address2 when joining
**************************/
create   procedure ETL_LoadSuppliers
as
begin
--Update based on source and original ID
update tgt_Suppliers set
CompanyName = stg_Supplier.CompanyName
from stg_Supplier 
left join Address a
on replace(isnull(a.AddressLine1,'') + isnull(a.AddressLine2,''),' ','') = replace(isnull(stg_Supplier.Address,'') + ISNULL(stg_Supplier.Address2,''),' ','')
and isnull(a.City,'') = isnull(stg_Supplier.City,'')
and isnull(a.StateOrRegion,'') = isnull(Cast(stg_Supplier.StateOrRegion as varchar),'')
and isnull(a.ZipCode,'') = isnull(stg_Supplier.PostalCode,'')
and isnull(a.Country,'') = isnull(stg_Supplier.Country,'')
left join Suppliers tgt_Suppliers
on tgt_Suppliers.SourceID = stg_Supplier.SourceID
and tgt_Suppliers.orig_SupplierID = stg_Supplier.SupplierID
where not ( isnull(stg_Supplier.CompanyName,'') = isnull(tgt_Suppliers.CompanyName,'')
	and isnull(stg_Supplier.ContactName,'') = isnull(tgt_Suppliers.ContactName,'')
	and isnull(stg_Supplier.ContactTitle,'') = isnull(tgt_Suppliers.ContactTitle,'')
	and isnull(stg_Supplier.Website,'') = isnull(tgt_Suppliers.Website,'')
	and isnull(stg_Supplier.Phone,'') = isnull(tgt_Suppliers.Phone,'')
	and isnull(stg_Supplier.Fax,'') = isnull(tgt_Suppliers.Fax,'')
	and isnull(a.ODSAddressID,-1)=isnull(tgt_Suppliers.ODSAddressID,-1)
)
--Insert
insert into Suppliers(SourceID, orig_SupplierID, CompanyName, ContactName, ContactTitle, Website, Phone, Fax, ODSAddressID)
select distinct
stg_Supplier.SourceID, stg_Supplier.SupplierID, stg_Supplier.CompanyName, stg_Supplier.ContactName,
stg_Supplier.ContactTitle, stg_Supplier.Website, stg_Supplier.Phone, stg_Supplier.Fax, a.ODSAddressID
from stg_Supplier
left join Address a
on replace(isnull(a.AddressLine1,'') + isnull(a.AddressLine2,''),' ','') = replace(isnull(stg_Supplier.Address,'') + ISNULL(stg_Supplier.Address2,''),' ','')
and isnull(a.City,'') = isnull(stg_Supplier.City,'')
and isnull(a.StateOrRegion,'') = isnull(Cast(stg_Supplier.StateOrRegion as varchar),'')
and isnull(a.ZipCode,'') = isnull(stg_Supplier.PostalCode,'')
and isnull(a.Country,'') = isnull(stg_Supplier.Country,'')
left join Suppliers tgt_Suppliers
on tgt_Suppliers.SourceID = stg_Supplier.SourceID
and tgt_Suppliers.orig_SupplierID = stg_Supplier.SupplierID
where tgt_Suppliers.ODSSupplierID is null
end

