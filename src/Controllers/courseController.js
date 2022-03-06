const sql = require("mssql");

exports.getCourses = (req, res, next) => {
  new sql.Request().query(
    `execute studentCourses ${req.params.stdId}`,
    (err, result) => {
      if (err) {
        res.status(500).json({ message: err });
        console.log(err);
      } else {
        res.status(200).json(result.recordset);
        console.log(result.recordset);
      }
    }
  );
};
