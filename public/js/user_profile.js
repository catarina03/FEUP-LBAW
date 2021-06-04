let block = document.querySelector(".userprofile .block");

block.addEventListener("click", function (e) {
  console.log();
  if (e.target.innerText == "Block") e.target.innerText = "Unblock";
  else if (e.target.innerText == "Unblock") e.target.innerText = "Block";
});

