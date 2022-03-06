const { validationResult } = require("express-validator");
const sql = require("mssql");

//===========================================================================================
exports.usernamePasswordAuth = function (request, response, next) {
  let errors = validationResult(request);
  if (!errors.isEmpty()) {
    let error = new Error();
    error.status = 422;
    error.message = errors
      .array()
      .reduce((current, object) => current + object.msg + " , ", "");
    next(error);
  } else {
    new sql.Request()
      .input("email", sql.VarChar(50), request.body.email)
      .execute("selectUserByEmail")
      .then((result) => {
        if (result.recordset.length == 0) {
          let error = new Error();
          error.message = "wrong email or password";
          next(error);
        } else if (request.body.password == result.recordset[0].Password) {
          response.status(210).json({
            Fname: result.recordset[0].Fname,
            Lname: result.recordset[0].Lname,
            Dept_id: result.recordset[0].Dept_id,
            Type: result.recordset[0].Type,
            User_Id: result.recordset[0].User_Id,
          });
        } else {
          let error = new Error();
          error.message = "wrong email or password";
          next(error);
        }
      })
      .catch((err) => {
        console.log(err);
        let error = new Error();
        error.status = 500;
        error.message = "requist error";
        next(error);
      });
  }
};
//===========================================================================================
