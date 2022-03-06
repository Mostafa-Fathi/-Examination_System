-------------generate Exam -------------------------------------------------------------------------------
alter proc GenerateExam (@st_id int,@time int ,@crs_id int)
AS
begin 
BEGIN TRANSACTION
begin try
   DECLARE @DataID int;
   insert into Exam  (Date,Time,Stu_id,Crs_id) VALUES (GETDATE(),@time,@st_id,@crs_id);
   SELECT @DataID = scope_identity();
   INSERT INTO ExamQuestions (Ques_id,Exam_id) 
   select top 10 Ques_Id,@DataID from Question where Question.Crs_id=@crs_id order by newid() 
    select @DataID as [examID]
COMMIT
end try 
begin catch 
			Select 'Query error occured .........'
end catch 
end

EXEC GenerateExam 3,90,3


----------------------------------------------------------------------------------------------------------
select * ,ROW_NUMBER() OVER(ORDER BY Exam_id desc) RowNumber from ExamQuestions  where Exam_id=7
select * from ExamQuestions  where Exam_id=7

create proc selectUserByEmail @email varchar(20)
as
select * 
from [User] u
where u.Email=@email

exec RetrunExamQuesById 9