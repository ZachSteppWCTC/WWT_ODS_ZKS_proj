/**************************
* Procedure ETL_LoadOrders
* Author: zstepp
* Create Date: 9/21/2024
* 
* Loads Orders
* Inserts and Updates
*
* Updated: 9/27/2024
* Concatenate versions of Address1 and Address2 when joining
* Adjusted joins for record accuracy
**************************/
create   procedure ETL_LoadOrders
as
begin
--Update Orders first
update tgt_Orders set
SourceID = stg_Orders.SourceID,
orig_OrderID = stg_Orders.OrderID,
ODSCustomerID = c.ODSCustomerID,
ODSEmployeeID = e.ODSEmployeeID,
OrderDate = stg_Orders.OrderDate,
RequiredDate = stg_Orders.RequiredDate,
ShippedDate = stg_Orders.ShippedDate,
ShipVia = s.ODSShipperID,
Freight = stg_Orders.Freight,
Shipname = stg_Orders.ShipName,
DeliveryAddressID = a.ODSAddressID
from stg_Orders
left join Customer_Lookup cl
on cl.source_CustomerID = stg_Orders.CustomerID
and cl.SourceID = stg_Orders.SourceID
left join Customers c
on c.ODSCustomerID = cl.ODSCustomerID
left join Employees e
on e.orig_EmployeeID = stg_Orders.EmployeeID
and e.SourceID = stg_Orders.SourceID
left join Shippers s
on s.orig_ShippersID = stg_Orders.ShipVia
and s.SourceID = stg_Orders.SourceID
left join Address a
on replace(isnull(a.AddressLine1,'') + isnull(a.AddressLine2,''),' ','') = replace(isnull(stg_Orders.ShipAddress,'') + isnull(stg_Orders.ShipAddress2,''),' ','')
and isnull(a.City,'') = isnull(stg_Orders.ShipCity,'')
and isnull(a.StateOrRegion,'') = isnull(Cast(stg_Orders.ShipStateOrRegion as varchar),'')
and isnull(a.ZipCode,'') = isnull(stg_Orders.ShipPostalCode,'')
and isnull(a.Country,'') = isnull(stg_Orders.ShipCountry,'')
left join Orders tgt_Orders
on tgt_Orders.SourceID = stg_Orders.SourceID
and tgt_Orders.orig_OrderID = stg_Orders.OrderID
where not ( isnull(c.ODSCustomerID,-1)=isnull(tgt_Orders.ODSCustomerID,-1)
	and isnull(e.ODSEmployeeID,-1)=isnull(tgt_Orders.ODSEmployeeID,-1)
	and isnull(stg_Orders.OrderDate,'')=isnull(tgt_Orders.OrderDate,'')
	and isnull(stg_Orders.RequiredDate,'')=isnull(tgt_Orders.RequiredDate,'')
	and isnull(stg_Orders.ShippedDate,'')=isnull(tgt_Orders.ShippedDate,'')
	and isnull(s.ODSShipperID,-1)=isnull(tgt_Orders.ShipVia,-1)
	and isnull(stg_Orders.Freight,'')=isnull(tgt_Orders.Freight,'')
	and isnull(stg_Orders.ShipName,'')=isnull(tgt_Orders.ShipName,'')
	and isnull(a.ODSAddressID,-1)=isnull(tgt_Orders.DeliveryAddressID,-1)
)
--Inserts into Orders
Insert into Orders(SourceID, orig_OrderID, ODSCustomerID, ODSEmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, DeliveryAddressID)
select distinct
stg_Orders.SourceID,
stg_Orders.OrderID,
c.ODSCustomerID,
e.ODSEmployeeID,
stg_Orders.OrderDate,
stg_Orders.RequiredDate,
stg_Orders.ShippedDate,
s.ODSShipperID,
stg_Orders.Freight,
stg_Orders.ShipName,
a.ODSAddressID
from stg_Orders
left join Customer_Lookup cl
on cl.source_CustomerID = stg_Orders.CustomerID
and cl.SourceID = stg_Orders.SourceID
left join Customers c
on c.ODSCustomerID = cl.ODSCustomerID
left join Employees e
on e.orig_EmployeeID = stg_Orders.EmployeeID
and e.SourceID = stg_Orders.SourceID
left join Shippers s
on s.orig_ShippersID = stg_Orders.ShipVia
and s.SourceID = stg_Orders.SourceID
left join Address a
on replace(isnull(a.AddressLine1,'') + isnull(a.AddressLine2,''),' ','') = replace(isnull(stg_Orders.ShipAddress,'') + isnull(stg_Orders.ShipAddress2,''),' ','')
and isnull(a.City,'') = isnull(stg_Orders.ShipCity,'')
and isnull(a.StateOrRegion,'') = isnull(Cast(stg_Orders.ShipStateOrRegion as varchar),'')
and isnull(a.ZipCode,'') = isnull(stg_Orders.ShipPostalCode,'')
and isnull(a.Country,'') = isnull(stg_Orders.ShipCountry,'')
left join Orders tgt_Orders
on tgt_Orders.SourceID = stg_Orders.SourceID
and tgt_Orders.orig_OrderID = stg_Orders.OrderID
where tgt_Orders.ODSOrderID is null
end

