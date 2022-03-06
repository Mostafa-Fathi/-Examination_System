-------------------------------------report 1-------------------------------------------
alter proc SelectStudentinformation @dep_id int
AS
		begin try
			select u.* from [User] u,Student s
			where u.User_Id=s.St_id and u.Dept_id=@dep_id
			and u.Type='student'
		end try
		begin catch
			Select 'Query error occured .........'
		end catch
Go

EXEC SelectStudentinformation 1;
EXEC SelectStudentinformation 2;
EXEC SelectStudentinformation 3;
-------------------------------------report 2-------------------------------------------
create proc SelectgradeallCrs @st_id int     --notcomplete all course
AS
		begin
		select  c.Crs_Id,CAST(sum( iif (eq.St_Answer=q.Model_answer,q.Mark,0))as float)/ cast(sum(q.Mark) as float)*100 from Exam e,Course c , Question q , ExamQuestions eq
		where c.Crs_id=e.Crs_id and e.Stu_id=@st_id and q.Ques_Id=eq.Ques_id and e.Crs_id=q.Crs_id
		group by c.Crs_id
		end
Go

EXEC SelectgradeallCrs 3;
-------------------------------------report 3-------------------------------------------
create proc select#studentpercourse  @ins_id int
AS
		begin 
			select c.Crs_Name,count(sc.St_id) from Course c,Ins_Crs ic,St_Crs sc
			where c.Crs_id=ic.Crs_id and ic.Ins_id=@ins_id and sc.Crs_id=c.Crs_Id and sc.ins_id=@ins_id
			group by c.Crs_Name 
		end 
Go

EXEC select#studentpercourse 1;
EXEC select#studentpercourse 2;
EXEC select#studentpercourse 5;
-------------------------------------report 4-------------------------------------------
create proc selectTopics @crs_id int
AS
		begin 
			select t.Top_Name from Topic t,Crs_Topics ct
			where t.Topic_Id=ct.Top_id and Crs_id=@crs_id;
		end 
Go

EXEC selectTopics 1;
------------------------------------report 5-------------------------------------------
create proc SelectExamQuestion @e_id int
AS
		begin 
			select q.body,q.answer1,q.answer2,q.answer3,q.answer4 
			from Exam e,ExamQuestions eq,Question q,Course c
			where e.Crs_id=c.Crs_id and c.Crs_id=q.Crs_id 
					and eq.Ques_id=q.Ques_id and e.Exam_id= @e_id ;

			--select q.body,q.answer1,q.answer2,q.answer3,q.answer4 
			--from ExamQuestions eq,Question q
			--where eq.Ques_id=q.Ques_id and eq.Exam_id= 3@e_id;
		end
Go

EXEC SelectExamQuestion 6;
------------------------------------report 6-------------------------------------------------
create proc SelectStu_answer (@e_id int,@st_id int)
AS
		begin 
			select q.body,eq.St_Answer,q.answer1,q.answer2,q.answer3,q.answer4
			from ExamQuestions eq,Question q,Exam e
			where eq.Ques_id=q.Ques_id and eq.Exam_id= @e_id and e.Stu_id= @st_id;
		end 
Go

EXEC SelectStu_answer 6,3;
----------------------------------------------------------------------------------------------