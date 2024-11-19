/**************************
* Procedure ETL_LoadCategory
* Author: zstepp
* Create Date: 9/19/2024
* 
* Loads stage table categories into ODS categories table.
* Insert Only
**************************/
create   procedure ETL_LoadCategory
as
begin
	Insert into Category(Category, Description)
	Select distinct src_cat.CategoryName, src_cat.Description
	from stg_Category src_cat 
	Left join category tgt_cat 
	on src_cat.CategoryName = tgt_cat.Category
	where tgt_cat.ODSCategoryId is null 
end

