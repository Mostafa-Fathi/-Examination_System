----------------------------------Table Exam-----------------------------------------
------------------select-------------------
create proc SelectExamById @examId int
AS
	begin
	select E.* from Exam as E 
	where  e.Exam_Id=@examId;
	end
create proc RetrunExamQuesById @examId int
AS
	begin
	select q.* from Question q ,ExamQuestions eq
	where  eq.Exam_id=@examId and q.Ques_Id=eq.Ques_id;
	end

create proc RetrunExamQuesAndAnsById @examId int
AS
	begin
	select q.* ,eq.St_Answer from Question q ,ExamQuestions eq
	where  eq.Exam_id=@examId and q.Ques_Id=eq.Ques_id;
	end

create proc SelectExam @crsName varchar(10)
AS
	begin
	select E.* from Exam as E ,Course C
	where E.Crs_id=C.Crs_id and C.Crs_Name=@crsName;
	end

EXEC SelectExam @crsName='Web';
--EXEC SelectExam 'Web';
------------------Insert----------------------------
ALTER Procedure InsertExam 
(
			@Eid int,
			@tim int,
			@d date,
			
			@Cid int,
			@Sid int
)
AS
	begin
	begin try
	insert into Exam(Exam_id,Time,Date,Crs_id,Stu_id)
			    values(@Eid,@tim,@d,@Cid,@Sid);
	end try 
	begin catch 
	select 'error'
	end catch 
	End

EXEC InsertExam 4,45,'2-6-2022',3,2;
--EXEC InsertExam 6,30,'2-4-2022',25,2,2;
--select * from Exam
-----------------------------update-------------------------------
create or alter Procedure updateExam ( @eid int , @date date , @time int)
AS
	begin
	begin try
	update Exam set Date=@date,Time=@time where Exam_id=@eid;
	end try 
	begin catch 
	select 'error while update '
	end catch 

	end

--select * from Exam
-------------------------------delete---------------------------

create Procedure deleteExam  @eid int
AS
	begin
	delete from Exam where Exam_id=@eid;
	end

EXEC deleteExam 4;
--select * from Exam
----------------------------------Table ExamQuestion-----------------------------------------
-----------------select---------------------------
create proc SelectQuestionFromExam @qid int
AS
	begin
	select q.* from ExamQuestions as q ,Exam e
	where q.Exam_id=e.Exam_id and Ques_id=@qid;
	end

EXEC SelectQuestion 4;

-----------------------------Insert-----------------------------------------------------------------
create or alter Procedure InsertQuestionToExam 
(
			@Eid int,
			@qid int,
			@st_answr varchar(20)
)
AS
	begin
	begin try 
	insert into ExamQuestions(Exam_id,Ques_id,St_Answer)
			values	(@Eid,@qid,@st_answr);
	End try 
	begin catch 
	select 'error'
	end catch 
	end 

EXEC InsertQuestion 2,4,'answer1';
--select * from ExamQuestions
--------------------------------update----------------------------------------------------------------
create or alter  Procedure updateQuestionAtExam (@ans varchar(20), @eid int)
AS
	begin
		begin try 

	update ExamQuestions set St_Answer=@ans where Exam_id=@eid;
	End try 
	begin catch 
	select 'error'
	end catch 
	end 

EXEC updateQuestion  'answer1',1;
--select * from ExamQuestions
----------------------------------delete--------------------------------------------
create Procedure deleteQuestionAtExam  @eid int,@qid int
AS
	begin
	delete from ExamQuestions where Exam_id=@eid and Ques_id=@qid;
	end

EXEC deleteQuestion 2,4;
--select * from ExamQuestions
---------------------------------------------------------------------------------
EXEC sp_bindrule 'ModelAnswerRule', 'ExamQuestions.St_Answer';
-------------------------------------------------------------------------------