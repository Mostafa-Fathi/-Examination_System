
use Online_Examination_System





create proc examanswers
(@examid int ,@ans1 varchar(20),@ans2 varchar(20),@ans3 varchar(20),@ans4 varchar(20),
@ans5 varchar(20),@ans6 varchar(20),@ans7 varchar(20),@ans8 varchar(20),@ans9 varchar(20),@ans10 varchar(20))
as
DECLARE @tt TABLE (answer varchar(20),id int Identity(1,1))
DECLARE @str varchar(200)
SET @str = @ans1+';'+@ans2+';'+@ans3+';'+@ans4+';'+@ans5+';'+@ans6+';'+@ans7+';'+@ans8+';'+@ans9+';'+@ans10
INSERT INTO @tt
SELECT value FROM STRING_SPLIT(@str, ';')
DECLARE @i int
SET @i = 1
WHILE @i <= 10
BEGIN
WITH eQuestions AS (
select Ques_id , ROW_NUMBER() OVER (ORDER BY eq.Ques_id ) as row_num 
from ExamQuestions eq where eq.Exam_id=@examid
)

UPDATE ExamQuestions SET St_Answer = (select answer from @tt where id=@i) where ExamQuestions.Ques_id in ( select Ques_id from eQuestions where row_num=@i)
SET @i = @i + 1;
end


exec examanswers 8 , 'answer1', 'answer2', 'answer3', 'answer4', 'answer1', 'answer2', 'answer3', 'answer4','answer1', 'answer2';



alter proc correctexam @examId int 
as
DECLARE @i int ,@mark int ,@fMark int,@stAnswer varchar(20),@modelAnswer varchar(20)
SET @i = 1 
set @fMark=0


WHILE @i <= 10
BEGIN
WITH eQuestions AS (
select q.Model_answer ,eq.St_Answer ,q.Mark, ROW_NUMBER() OVER (ORDER BY eq.Ques_id ) as row_num 
from Question q , ExamQuestions eq where eq.Exam_id=@examId and eq.Ques_id=q.Ques_Id)
select @modelAnswer=model_answer, @stAnswer=St_Answer , @mark=Mark from eQuestions where row_num=@i
IF (@stAnswer=@modelAnswer)
begin
set @fMark=@fMark+@mark
End 
set @i=@i+1
end
select @fMark as Full_Mark
return @fmark
 

exec correctexam 6;

