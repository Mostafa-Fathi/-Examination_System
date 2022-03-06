const express = require("express");
const router = express.Router();

const controller = require("../Controllers/courseController");

router.get("/:stdId?", controller.getCourses);

module.exports = router;
