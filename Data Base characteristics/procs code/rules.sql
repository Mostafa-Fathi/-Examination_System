create rule ModelAnswerRule as @x in ('answer1','answer2','answer3','answer4');
create rule UserTypeRule as @x in ('Student','Instructor');

EXEC sp_bindrule 'ModelAnswerRule', 'Question.Model_answer';  
EXEC sp_bindrule 'ModelAnswerRule', 'ExamQuestions.St_Answer';  

 /* to create back up */ 
BACKUP DATABASE [Online_Examination_System] 
TO DISK = N'E:\SQLTestDB.bak' 
WITH NOFORMAT, NOINIT,  
NAME = N'SQLTestDB-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO