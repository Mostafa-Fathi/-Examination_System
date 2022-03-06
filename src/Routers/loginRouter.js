const express = require("express");
const router = express.Router();
const { body, param, query } = require("express-validator");
const loginControl = require("../Controllers/loginControl");

router.post(
  "",
  [body("email").isEmail().withMessage("please enter a valid Email")],
  loginControl.usernamePasswordAuth
);

module.exports = router;
