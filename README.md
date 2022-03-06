# Examination_System

## Prerequisites: <br />

1- Make sure the TCP/IP protocol in enabled for sqlserver service: <br />
  windows+R > compmgmt.msc > sql server configuration manager > sql server network configuration > protocols for MSSQLSERVER > TCP/IP: enabled <br /><br />
2- Make sure the sql server browser is running: <br />
  in the sql server configuration manager > sql server services > sql server browser: running <br /><br />
3- Restart your sqlserver services: <br />
  windows+R > services.msc > search for sql server > restart <br />

## To run the project: <br />
1- Download the sqlserver DB backup from here : https://drive.google.com/file/d/12maXzHKWU_9Q7Q1QQBjN76c37M8PK8Mf/view?usp=sharing <br />
2- Make a new login for the sqlserver with credentials (username: test, password: test) and add it as a user for the "Examination_System" DB with role "db_owner" <br />
3- Download the source code and open the project folder<br />
4- Run "npm install"<br />
5- Run "npm start"<br />
6- Run "npm run open"<br />
7- To test the project, you can login with student credentials (email: mostafafathy@gmail.com, password:123456) <br/>
