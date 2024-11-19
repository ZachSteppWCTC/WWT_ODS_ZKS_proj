/**************************
* Procedure ETL_Control
* Author: zstepp
* Create Date: 9/21/2024
* 
* Executes ETL Procedures in correct order
**************************/
create   procedure ETL_Control
as
begin
	set nocount on

	exec ETL_LoadCategory
	exec ETL_LoadShippers
	exec ETL_LoadAddresses
	exec ETL_LoadEmployees
	exec ETL_LoadSuppliers
	exec ETL_LoadProducts
	exec ETL_LoadCustomers
	exec ETL_LoadOrders
	exec ETL_LoadOrderDetails
end

