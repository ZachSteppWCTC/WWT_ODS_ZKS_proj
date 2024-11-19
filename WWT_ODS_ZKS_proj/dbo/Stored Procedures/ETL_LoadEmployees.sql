/**************************
* Procedure ETL_LoadEmployees
* Author: zstepp
* Create Date: 9/20/2024
* 
* Loads Employees
* Inserts and Updates
*
* Updated: 9/27/2024
* Concatenate versions of Address1 and Address2 when joining
**************************/
create   procedure ETL_LoadEmployees
as
begin
Insert into Employees(SourceID, orig_EmployeeID, LastName, FirstName, JobTitle,
Title, BirthDate, HireDate, TerminationDate, isActive, AddressID, HomePhone, Extension,
EmailAddress, Notes)
-- Ignoring reportsTo for now, handled in update
Select distinct
stg_Employees.SourceID, stg_Employees.EmployeeID, stg_Employees.LastName, stg_Employees.FirstName, stg_Employees.JobTitle,
stg_Employees.Title, stg_Employees.BirthDate, stg_Employees.HireDate, stg_Employees.TerminationDate, stg_Employees.IsActive,
a.ODSAddressID, stg_Employees.HomePhone, stg_Employees.Extension, stg_Employees.EmailAddress, isnull(stg_Employees.Notes,'') notes
from stg_Employees
left join Employees tgt_Employees
on tgt_Employees.SourceID = stg_Employees.SourceID
and tgt_Employees.orig_EmployeeID = stg_Employees.EmployeeID
left join Address a
on replace(isnull(a.AddressLine1,'') + isnull(a.AddressLine2,''),' ','') = replace(isnull(stg_Employees.Address,'') + isnull(stg_Employees.Address2,''),' ','')
and isnull(a.City,'') = isnull(stg_Employees.City,'')
and isnull(a.StateOrRegion,'') = isnull(Cast(stg_Employees.StateOrRegion as varchar),'')
and isnull(a.ZipCode,'') = isnull(stg_Employees.PostalCode,'')
and isnull(a.Country,'') = isnull(stg_Employees.Country,'')
where tgt_Employees.ODSEmployeeID is null
--Update AFTER to correct self referencing ReportsTo in case the ID someone reports to is just added
--Somebody could even change their name, taking advantage of source and orig IDs here to leave room for typo fixing
update tgt_Employees set
LastName = stg_Employees.LastName,
FirstName = stg_Employees.FirstName,
JobTitle = stg_Employees.JobTitle,
Title = stg_Employees.Title,
BirthDate = stg_Employees.BirthDate,
HireDate = stg_Employees.HireDate,
TerminationDate = stg_Employees.TerminationDate,
isActive = stg_Employees.IsActive,
AddressID = a.ODSAddressID,
HomePhone = stg_Employees.HomePhone,
Extension = stg_Employees.Extension,
EmailAddress = stg_Employees.EmailAddress,
Notes = stg_Employees.Notes,
ReportsTo = reports.ODSEmployeeID
from stg_Employees stg_Employees
left join Address a
on replace(isnull(a.AddressLine1,'') + isnull(a.AddressLine2,''),' ','') = replace(isnull(stg_Employees.Address,'') + isnull(stg_Employees.Address2,''),' ','')
and isnull(a.City,'') = isnull(stg_Employees.City,'')
and isnull(a.StateOrRegion,'') = isnull(Cast(stg_Employees.StateOrRegion as varchar),'')
and isnull(a.ZipCode,'') = isnull(stg_Employees.PostalCode,'')
and isnull(a.Country,'') = isnull(stg_Employees.Country,'')
left join Employees tgt_Employees
on tgt_Employees.SourceID = stg_Employees.SourceID
and tgt_Employees.orig_EmployeeID = stg_Employees.EmployeeID
left join Employees reports
on reports.orig_EmployeeID = isnull(stg_Employees.ReportsTo,-1)
and reports.SourceID = stg_Employees.SourceID
where not (isnull(stg_Employees.LastName,'')=isnull(tgt_Employees.LastName,'')
	and isnull(stg_Employees.FirstName,'')=isnull(tgt_Employees.FirstName,'')
	and isnull(stg_Employees.JobTitle,'')=isnull(tgt_Employees.JobTitle,'')
	and isnull(stg_Employees.Title,'')=isnull(tgt_Employees.Title,'')
	and isnull(stg_Employees.BirthDate,'')=isnull(tgt_Employees.BirthDate,'')
	and isnull(stg_Employees.HireDate,'')=isnull(tgt_Employees.HireDate,'')
	and isnull(stg_Employees.TerminationDate,'')=isnull(tgt_Employees.TerminationDate,'')
	and isnull(stg_Employees.IsActive,'')=isnull(tgt_Employees.isActive,'')
	and isnull(a.ODSAddressID,-1)=isnull(tgt_Employees.AddressID,-1)
	and isnull(stg_Employees.HomePhone,'')=isnull(tgt_Employees.HomePhone,'')
	and isnull(stg_Employees.Extension,'')=isnull(tgt_Employees.Extension,'')
	and isnull(stg_Employees.EmailAddress,'')=isnull(tgt_Employees.EmailAddress,'')
	and isnull(stg_Employees.Notes,'')=isnull(tgt_Employees.Notes,'')
	and isnull(reports.ODSEmployeeID,-1)=isnull(tgt_Employees.ReportsTo,-1)
)
end

