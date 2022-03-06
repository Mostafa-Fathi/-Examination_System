ALTER TABLE Exam ALTER COLUMN st_Mark varchar(20) NULL
/*
-------------------dept storeds --------------------------------------------------
*/

alter proc InsertDept (@deptID int ,@deptName varchar(10))
as
begin try 
insert into Department (Dept_Id,Dept_Name) values (@deptID,@deptName)
END TRY
BEGIN CATCH  
select  'error while inserting data'
END CATCH

create proc SelectDeptWithID (@deptID int)
as
select * from Department where Dept_Id=@deptID

create proc SelectAllDepts
as
select * from Department 

alter proc UpdateDeptWithID (@deptID int , @deptName varchar(10))
as
begin try 
update Department set Dept_Name=@deptName where Dept_Id=@deptID
END TRY
BEGIN CATCH  
select  'error while updating data'
END CATCH

create proc DeleteDeptWithID (@deptID int)
as
delete from Department where Dept_Id=@deptID


/*
-------------------student courses storeds --------------------------------------------------
*/
ALTER TABLE
  st_crs
ALTER COLUMN
  ins_id
    int NOT NULL;

alter proc AssginCrsToSt (@crsId int ,@stId int ,@insId int)
as
BEGIN TRY  
insert into St_Crs(Crs_id,St_id,ins_id) values (@crsId,@stId,@insId)
END TRY  
BEGIN CATCH  
select  'error while adding data'
END CATCH

alter proc UpdateInsAtCrsSt (@crsId int ,@stId int ,@insId int)
as
BEGIN TRY  
update St_Crs set @insId=@insId where @crsId=@crsId and St_id=@stId
END TRY
BEGIN CATCH  
select  'error while updating data'
END CATCH


create proc SelectStudentsWithCrsAndIns (@crsId int ,@insId int)
as
select St_id from St_Crs where @insId=@insId and @crsId=@crsId 

alter proc SelectAllStsAssginedTocrs 
as
select St_id from St_Crs 

create proc SelectAllStsAssginedToCrWithId @crsID int 
as
select St_id from St_Crs where St_Crs.Crs_id=@crsID

create proc deleteStCrsWithId @crsID int , @stId int
as
delete from St_Crs where St_Crs.Crs_id=@crsID and St_Crs.St_id=@stId

create proc deleteAllStCrs @stId int
as
delete from St_Crs where St_Crs.St_id=@stId
