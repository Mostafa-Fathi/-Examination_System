create proc SelectCrs
with encryption
as
select Crs_Name,Crs_hour,Top_Name from Course c,Crs_Topics crst,Topic t
where c.Crs_id=crst.Crs_id and crst.Top_id=t.Topic_Id

exec SelectCrs

alter proc updateTopData (@id int,@topName varchar(20))
as
begin try
   update Topic set Top_Name=@topName
   where Topic_Id=@id
end try
begin catch
   select 'Error'
end catch

exec updateTopData 5

/*select * from Topic*/

create proc insTopData @topName varchar(20)
as 
if exists (select * from Topic where Top_Name=@topName)
begin
 select 'sorry this Topic is already exists'
end
else
begin
insert into Topic values(@topName)
end

/*exec insTopData 5,'Css'*/
/*exec insTopData 7,'Css'*/
exec insTopData 8,'Node'

create proc delTopData @id int
as
begin try 
delete from Topic where Topic_Id=@id
end try
begin catch
select 'table has a relation'
end catch

exec delTopData 8

