/*get elements*/
window.addEventListener("load", () => {
  let jsonData;
  let examId;
  let total = 0;
  let answers = {};
  let std = localStorage.getItem("userId");
  let crs = localStorage.getItem("crsId");
  fetch(`http://localhost:8080/course/exam/${std}/${crs}`)
    .then((response) => response.json())
    .then((json) => {
      examId = json.examID;
      answers.examID = examId;
      jsonData = json.questions;
      go();
    })
    .catch((err) => {
      console.log(err);
    });
  function go() {
    let question = document.getElementById("question");
    let ans1 = document.getElementById("ans1");
    let ans2 = document.getElementById("ans2");
    let ans3 = document.getElementById("ans3");
    let ans4 = document.getElementById("ans4");
    let rad3 = document.getElementById("rad3");
    let rad4 = document.getElementById("rad4");
    function examQuestions(index) {
      total += jsonData[index].Mark;
      question.innerHTML = jsonData[index].body;
      ans1.innerHTML = jsonData[index].answer1;
      ans2.innerHTML = jsonData[index].answer2;
      ans3.innerHTML = jsonData[index].answer3;
      ans4.innerHTML = jsonData[index].answer4;
      if (
        jsonData[index].Type == "True or False" ||
        jsonData[index].Type == "true or false"
      ) {
        rad3.setAttribute("style", "display:none;");
        rad4.setAttribute("style", "display:none;");
      } else {
        rad3.setAttribute("style", "display:inline;");
        rad4.setAttribute("style", "display:inline;");
      }
    }

    let myBtn = document.getElementsByClassName("btn")[0];
    function goToScore() {
      fetch("http://localhost:8080/course/exam", {
        method: "POST",
        body: JSON.stringify({
          ...answers,
        }),
        headers: {
          "Content-type": "application/json; charset=UTF-8",
        },
      })
        .then((response) => response.json())
        .then((json) => {
          score = json.Full_Mark;
          localStorage.setItem("stdScore", score);
          if (total / score < 0.5) {
            window.location.replace("../student/loose.html");
          } else {
            window.location.replace("../student/success.html");
          }
        })
        .catch((err) => {
          console.log(err);
        });
    }
    var i = 0;
    var score = 0;
    var checked;

    examQuestions(i);

    function checAnswers() {
      if (document.getElementById("rad1").checked) {
        answers[`q${i + 1}`] = "answer1";
        checked = 1;
      }
      if (document.getElementById("rad2").checked) {
        answers[`q${i + 1}`] = "answer2";
        checked = 2;
      }
      if (document.getElementById("rad3").checked) {
        answers[`q${i + 1}`] = "answer3";
        checked = 3;
      }
      if (document.getElementById("rad4").checked) {
        answers[`q${i + 1}`] = "answer4";
        checked = 4;
      }

      i++;

      if (i == jsonData.length - 1) {
        myBtn.innerHTML = "submit";
        examQuestions(i);
      } else if (i == jsonData.length) {
        goToScore();
      } else {
        examQuestions(i);
      }
      let r = document.getElementById(`rad${checked}`);
      r.checked = false;
    }
    document.getElementById("button").addEventListener("click", checAnswers);
  }
});
