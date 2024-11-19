/**************************
* Procedure ETL_LoadCustomers
* Author: zstepp
* Create Date: 9/22/2024
* 
* Loads Customers
* Inserts and Updates
*
* Updated: 9/27/2024
* Concatenate versions of Address1 and Address2 when joining
**************************/
create   procedure ETL_LoadCustomers
as
begin
with unique_stg_customer (CompanyName, ContactName, ContactTitle, Phone, Fax, BillingAddress) as ( 
select
min(stg_Customer.CompanyName), min(stg_Customer.ContactName), min(stg_Customer.ContactTitle), max(stg_Customer.Phone), min(stg_Customer.Fax), min(a.ODSAddressID) 
from stg_Customer
left join Address a
on replace(isnull(a.AddressLine1,'') + isnull(a.AddressLine2,''),' ','') = replace(isnull(stg_Customer.Address,'') + isnull(stg_Customer.Address2,''),' ','')
and isnull(a.City,'') = isnull(stg_Customer.City,'')
and isnull(a.StateOrRegion,'') = isnull(Cast(stg_Customer.Region as varchar),'')
and isnull(a.ZipCode,'') = isnull(stg_Customer.PostalCode,'')
and isnull(a.Country,'') = isnull(stg_Customer.Country,'')
left join Customers tgt_Customer
on tgt_Customer.CustomerName = stg_Customer.CompanyName
and tgt_Customer.Phone = stg_Customer.Phone
group by stg_Customer.CompanyName, stg_Customer.Phone )

update tgt_Customers set
CustomerName = unique_stg_customer.CompanyName,
ContactName = unique_stg_customer.ContactName,
ContactTitle = unique_stg_customer.ContactTitle,
Phone = unique_stg_customer.Phone,
Fax = unique_stg_customer.Fax,
BillingAddressID = unique_stg_customer.BillingAddress
from unique_stg_customer
left join Customers tgt_Customers
on tgt_Customers.CustomerName = unique_stg_customer.CompanyName
and tgt_Customers.Phone = unique_stg_customer.Phone
where not (isnull(unique_stg_customer.ContactName,'')=isnull(tgt_Customers.ContactName,'')
	and isnull(unique_stg_customer.ContactTitle,'')=isnull(tgt_Customers.ContactTitle,'')
	and isnull(unique_stg_customer.Fax,'')=isnull(tgt_Customers.Fax,'')
	and isnull(unique_stg_customer.BillingAddress,-1)=isnull(tgt_Customers.BillingAddressID,-1)
)

insert into Customers(CustomerName, ContactName, ContactTitle, Phone, Fax, BillingAddressID)
select
min(stg_Customer.CompanyName), min(stg_Customer.ContactName), min(stg_Customer.ContactTitle), max(stg_Customer.Phone), min(stg_Customer.Fax), min(a.ODSAddressID) 
from stg_Customer
left join Address a
on replace(isnull(a.AddressLine1,'') + isnull(a.AddressLine2,''),' ','') = replace(isnull(stg_Customer.Address,'') + isnull(stg_Customer.Address2,''),' ','')
and isnull(a.City,'') = isnull(stg_Customer.City,'')
and isnull(a.StateOrRegion,'') = isnull(Cast(stg_Customer.Region as varchar),'')
and isnull(a.ZipCode,'') = isnull(stg_Customer.PostalCode,'')
and isnull(a.Country,'') = isnull(stg_Customer.Country,'')
left join Customers tgt_Customer
on tgt_Customer.CustomerName = stg_Customer.CompanyName
and tgt_Customer.Phone = stg_Customer.Phone
where tgt_Customer.ODSCustomerID is null
group by stg_Customer.CompanyName, stg_Customer.Phone

insert into Customer_Lookup(ODSCustomerID, SourceID, source_CustomerID)
select distinct
Customers.ODSCustomerID, stg_Customer.SourceID, stg_Customer.CustomerID
from Customers
left join stg_Customer
on Customers.CustomerName = stg_Customer.CompanyName
and Customers.Phone = stg_Customer.Phone
left join Customer_Lookup tgt_cl
on tgt_cl.ODSCustomerID = Customers.ODSCustomerID
and tgt_cl.source_CustomerID = stg_Customer.CustomerID
and tgt_cl.SourceID = stg_Customer.SourceID
where tgt_cl.ODSCustomerID is null or tgt_cl.SourceID is null

end

