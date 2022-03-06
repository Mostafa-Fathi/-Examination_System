alter proc InsertQuestion
(@q_crs_id int,@q_type varchar(100),@q_body varchar(200),@q_answer1  varchar(100),@q_answer2 varchar(100),@q_answer3  varchar(100),@q_answer4  varchar(100),@q_model varchar(20),@q_mark int  )
AS
		begin 
			insert into Question (Type,Crs_id,answer1,answer2,answer3,answer4,Mark,Model_answer,body)
			VALUES      (@q_type,@q_crs_id,@q_answer1,@q_answer2,@q_answer3,@q_answer4,@q_mark,@q_model,@q_body);
			
		end 
Go

alter proc UpdateQuestion
(@q_id int,@q_crs_id int,@q_type varchar(100),@q_body varchar(200),@q_answer1  varchar(100),@q_answer2 varchar(100),@q_answer3  varchar(100),@q_answer4  varchar(100),@q_model varchar(20),@q_mark int)
AS
		begin 
			update  Question
			set Type= @q_type,Crs_id=@q_crs_id,answer1=@q_answer1,answer2=@q_answer2,
			answer3=@q_answer3,answer4=@q_answer4,Mark=@q_mark,Model_answer=@q_model,body=@q_body
			where Ques_Id=@q_id
			
		end 
Go

alter proc DeleteQuestion
(@q_id int)
AS
		begin 
			delete from  Question

			where Ques_Id=@q_id
			
		end 
Go

alter proc SelectQuestion
(@q_id int)
AS
		begin 
			Select * from Question

			where Ques_Id=@q_id
			
		end 
Go
