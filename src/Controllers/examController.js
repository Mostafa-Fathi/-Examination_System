const sql = require("mssql");

exports.getExam = (req, res, next) => {
  new sql.Request()
    .input("st_id", sql.Int, req.params.stdId)
    .input("time", sql.Int, 60)
    .input("crs_id", sql.Int, req.params.crsId)
    .execute("GenerateExam", (err, result) => {
      if (err) {
        res.status(500).json({ message: err });
        console.log(err);
      } else {
        new sql.Request().query(
          `execute RetrunExamQuesById ${result.recordset[0].examID}`,
          (err, res2) => {
            if (err) {
              res.status(500).json({ message: err });
              console.log(err);
            } else {
              res.status(200).json({
                examID: result.recordset[0].examID,
                questions: res2.recordset,
              });
            }
          }
        );
      }
    });
};

exports.setExam = (req, res, next) => {
  new sql.Request().query(
    `execute examanswers ${req.body.examID}, ${req.body.q1}, ${req.body.q2}, ${req.body.q3}, ${req.body.q4}, ${req.body.q5}, ${req.body.q6}, ${req.body.q7}, ${req.body.q8}, ${req.body.q9}, ${req.body.q10}`,
    (err, res2) => {
      if (err) {
        res.status(500).json({ message: err });
        console.log(err);
      } else {
        new sql.Request().query(
          `execute correctexam ${req.body.examID}`,
          (err, res3) => {
            if (err) {
              res.status(500).json({ message: err });
              console.log(err);
            } else {
              res.status(200).json(res3.recordset[0]);
            }
          }
        );
      }
    }
  );
};
