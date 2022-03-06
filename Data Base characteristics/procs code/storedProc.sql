/*list all the data of students that take a certain course*/
create proc courseStudentsById @cid int
as
select u.*
from [User] u inner join St_Crs c
on u.User_Id = c.St_id
where c.Crs_id=@cid
/*=========================================================================================*/
/*get all the data of the courses that an instructor teaches*/
create proc InstructorCoursesById @iid int
as
select c.*
from Course c inner join Ins_Crs i
on c.Crs_Id=i.Crs_id
where i.Ins_id=@iid

create proc InstructorCrsStById @iid int
as
select c.Crs_Name,COUNT(s.St_id) as st_Count
from Course c , Ins_Crs i ,St_Crs s
where c.Crs_id=i.Crs_id and s.Crs_id=i.Crs_id
and i.Ins_id=@iid group by c.Crs_Name
/*=========================================================================================*/
/*get all the data of the courses that a student takes*/
create proc studentCourses @sid int
as
select c.*
from Course c inner join St_Crs s
on c.Crs_id=s.Crs_id
where s.St_id=@sid
/*=========================================================================================*/
/*get all the data of the topics in a course*/
create proc courseTopics @cid int
as
select t.*
from Topic t ,Crs_Topics c
where t.Topic_Id=c.Top_id and c.Crs_id=@cid
/******************************************************************************************************/
/*====================users===================users=======================users======================*/
/*Users table select*/
create proc selectFromUsers @uid int
as
select *
from [User] u
where u.User_Id=@uid
/*Users table delete*/
create proc deleteFromUsers @uid int
as
delete 
from [User] 
where User_Id=@uid
/*Users table insert*/
create proc insertIntoUsers 
@fname varchar(20),
@lname varchar(20),
@Email varchar(50),
@password varchar(20),
@phone varchar(11),
@city varchar(20),
@street varchar(20),
@Zip int,
@Did int,
@Type varchar(20)="student"
as
insert 
into [User] (Fname,Lname,Email,Password,Phone,City,Street,Zip_Code,Dept_id,Type)
values(@fname,@lname,@Email,@password,@phone,@city,@street,@Zip,@Did,@Type)
/**********************Users table update*********************/
create proc UpdateUserPassword @uid int , @password varchar(20)
as
update [User]
set Password=@password
where User_Id=@uid
 
create proc UpdateUserEmail @uid int , @Email varchar(20)
as
update [User]
set Email=@Email
where User_Id=@uid

create proc UpdateUserType @uid int , @Type varchar(20)="student"
as
update [User]
set Type=@Type
where User_Id=@uid
 
create proc UpdateUserDeptId @uid int , @Did int
as
update [User]
set Dept_id=@Did
where User_Id=@uid

create proc UpdateUserZip @uid int , @Zip int
as
update [User]
set Zip_Code=@Zip
where User_Id=@uid
 
create proc UpdateUserStreet @uid int , @street varchar(20)
as
update [User]
set Street=@street
where User_Id=@uid

create proc UpdateUserCity @uid int , @city varchar(20)
as
update [User]
set City=@city
where User_Id=@uid
 
create proc UpdateUserPhone @uid int , @phone varchar(11)
as
update [User]
set Phone=@phone
where User_Id=@uid

create proc UpdateUserFname @uid int , @fname varchar(20)
as
update [User]
set Fname=@fname
where User_Id=@uid
 
create proc UpdateUserLname	@uid int , @lname varchar(20)
as
update [User]
set Lname=@lname
where User_Id=@uid

/******************************************************************************************************/
/*=======================================instructor==================================================*/
/*instructor table select*/
create proc selectFromInstructors @iid int
as
select *
from Instructor i
where i.Ins_id=@iid
/*instructor table delete*/
create proc deleteFromInstructors @iid int
as
delete 
from Instructor
where Ins_id=@iid
/******************************************************************************************************/
/*=======================================Courses=====================================================*/
create proc selectFromCourses @cid int
as
select *
from Course c
where c.Crs_id=@cid

/*course table delete*/
create proc deleteFromCourses @cid int
as
delete 
from Course
where Crs_id=@cid

/*course table insert*/
create proc insertIntoCourses
@name varchar(20),
@hours int
as
insert 
into Course (Crs_Name,Crs_hour)
values(@name,@hours)

/**********************course table update*********************/
create proc UpdateCourseName @cid int , @name varchar(20)
as
update Course
set Crs_Name=@name
where Crs_id=@cid
 
create proc UpdateCourseHours @cid int , @hours int
as
update Course
set Crs_hour=@hours
where Crs_id=@cid
/******************************************************************************************************/
/*=======================================topics=====================================================*/
create proc selectFromTopics @tid int
as
select *
from Topic 
where Topic_Id=@tid

/*topics table delete*/
create proc deleteFromTopics @tid int
as
delete 
from Topic
where Topic_Id=@tid

/*course table insert*/
create proc insertIntoTopics 
@name varchar(20)
as
insert 
into Topic (Top_Name)
values(@name)

/**********************topic table update*********************/
create proc UpdateTopicName @tid int , @name varchar(20)
as
update Topic
set Top_Name=@name
where Topic_Id=@tid
 
ALTER TABLE [User]
ADD UNIQUE (Email);