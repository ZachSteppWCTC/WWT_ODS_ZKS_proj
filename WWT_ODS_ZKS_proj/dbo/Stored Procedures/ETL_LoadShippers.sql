/**************************
* Procedure ETL_LoadShippers
* Author: zstepp
* Create Date: 9/19/2024
* 
* Loads stage table Shippers into ODS Shippers table, updating Phones numbers based on Company Name.
* Inserts and Updates
**************************/
create   procedure ETL_LoadShippers
as
begin
update tgt_Shippers
set CompanyName = stg_Shippers.CompanyName,
Phone = stg_Shippers.Phone
from stg_Shippers
join Shippers tgt_Shippers
on stg_Shippers.CompanyName = tgt_Shippers.CompanyName
where not (ISNULL(stg_Shippers.Phone, '') = ISNULL(tgt_Shippers.Phone, ''))

Insert into Shippers(CompanyName, Phone, orig_ShippersID, SourceID)
select distinct stg_Shippers.CompanyName, stg_Shippers.Phone, stg_Shippers.ShipperID, stg_Shippers.SourceID from stg_Shippers
	Left join Shippers tgt_Shippers
	on stg_Shippers.CompanyName = tgt_Shippers.CompanyName
	where tgt_Shippers.ODSShipperID is null 
end

