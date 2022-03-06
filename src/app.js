const sql = require("mssql");
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");

const loginRouter = require("./Routers/loginRouter");
const courseRouter = require("./Routers/courseRouter");
const examRouter = require("./Routers/examRouter");

var config = {
  server: "localhost",
  authentication: {
    type: "default",
    options: {
      userName: "test",
      password: "test",
    },
  },
  options: {
    port: 1433,
    database: "Online_Examination_System",
    rowCollectionOnDone: true,
    useColumnNames: false,
    trustServerCertificate: true,
  },
};

sql
  .connect(config)
  .then(() => {
    console.log("DB connected");
    const server = express();
    server.listen(process.env.PORT || 8080, () => {
      console.log("listening...");
    });
    // server.use("/", (req, res) => {
    //   res.send("home page");
    // });

    server.use(cors());
    server.use(bodyParser.json());
    server.use(bodyParser.urlencoded({ extended: false }));

    server.use("/login", loginRouter);
    server.use("/course/exam", examRouter);
    server.use("/course", courseRouter);
  })
  .catch((err) => {
    console.log(err);
  });
