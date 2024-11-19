/**************************
* Procedure ETL_LoadAddresses
* Author: zstepp
* Create Date: 9/19/2024
* 
* Loads Addresses from Customers, Orders, Suppliers, and Employees.
* Insert Only
*
* Updated: 9/27/2024
* Removed stg_Address table and concatenate versions of Address1 and Address2 when joining
**************************/
create   procedure ETL_LoadAddresses
as
begin
Insert into Address(AddressLine1, AddressLine2, City, StateOrRegion, ZipCode, Country)
--Customer Table
select distinct min(c.Address), min(c.Address2), min(c.City), 
min(c.Region), min(c.PostalCode), min(c.Country)
from stg_Customer c
	left join Address tgt_Address
	on replace(isnull(c.Address,'') + isnull(c.Address2,''),' ','') = replace(isnull(tgt_Address.AddressLine1,'') + isnull(tgt_Address.AddressLine2,''),' ','')
	and isnull(c.City,'') = isnull(tgt_Address.City,'')
	and isnull(c.Region,'') = isnull(tgt_Address.StateOrRegion,'')
	and isnull(c.PostalCode,'') = isnull(tgt_Address.ZipCode,'')
	and isnull(c.Country,'') = isnull(tgt_Address.Country,'')
	where tgt_Address.ODSAddressID is Null 
	and c.Address is not null
	group by replace(isnull(c.Address,'') + isnull(c.Address2,''),' ','')
UNION
--Order Table
select distinct min(o.ShipAddress), min(o.ShipAddress2), min(o.ShipCity),
min(o.ShipStateOrRegion), min(o.ShipPostalCode), min(o.ShipCountry)
from stg_Orders o
	left join Address tgt_Address
	on replace(isnull(o.ShipAddress,'') + isnull(o.ShipAddress2,''),' ','') = replace(isnull(tgt_Address.AddressLine1,'') + isnull(o.ShipAddress2,''),' ','')
	and isnull(o.ShipCity,'') = isnull(tgt_Address.City,'')
	and isnull(o.ShipStateOrRegion,'') = isnull(tgt_Address.StateOrRegion,'')
	and isnull(o.ShipPostalCode,'') = isnull(tgt_Address.ZipCode,'')
	and isnull(o.ShipCountry,'') = isnull(tgt_Address.Country,'')
	where tgt_Address.ODSAddressID is Null 
	and o.ShipAddress is not null
	group by replace(isnull(o.ShipAddress,'') + isnull(o.ShipAddress2,''),' ','')
UNION
--Supplier Table
select distinct min(s.Address), min(s.Address2), min(s.City), 
min(s.StateOrRegion), min(s.PostalCode), min(s.Country)
from stg_Supplier s
	left join Address tgt_Address
	on replace(isnull(s.Address,'') + isnull(s.Address2,''),' ','') = replace(isnull(tgt_Address.AddressLine1,'') + isnull(tgt_Address.AddressLine2,''),' ','')
	and isnull(s.City,'') = isnull(tgt_Address.City,'')
	and isnull(s.StateOrRegion,'') = isnull(tgt_Address.StateOrRegion,'')
	and isnull(s.PostalCode,'') = isnull(tgt_Address.ZipCode,'')
	and isnull(s.Country,'') = isnull(tgt_Address.Country,'')
	where tgt_Address.ODSAddressID is Null 
	and s.Address is not null
	group by replace(isnull(s.Address,'') + isnull(s.Address2,''),' ','')
UNION
--Employees Table
select distinct min(e.Address), min(e.Address2), min(e.City), 
min(e.StateOrRegion), min(e.PostalCode), min(e.Country)
from stg_Employees e
	left join Address tgt_Address
	on replace(isnull(e.Address,'') + isnull(e.Address2,''),' ','') = replace(isnull(tgt_Address.AddressLine1,'') + isnull(tgt_Address.AddressLine2,''),' ','')
	and isnull(e.City,'') = isnull(tgt_Address.City,'')
	and isnull(e.StateOrRegion,'') = isnull(tgt_Address.StateOrRegion,'')
	and isnull(e.PostalCode,'') = isnull(tgt_Address.ZipCode,'')
	and isnull(e.Country,'') = isnull(tgt_Address.Country,'')
	where tgt_Address.ODSAddressID is Null 
	and e.Address is not null
	group by replace(isnull(e.Address,'') + isnull(e.Address2,''),' ','')
end

