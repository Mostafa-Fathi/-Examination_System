const express = require("express");
const router = express.Router();

const controller = require("../Controllers/examController");

router.get("/:stdId?/:crsId?", controller.getExam);
router.post("/", controller.setExam);

module.exports = router;
