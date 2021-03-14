let arrowDown = document.querySelector(
  ".advanced_search .arrowButton.arrow-down"
);
let arrowUp = document.querySelector(".advanced_search .arrowButton.arrow-up");

arrowDown.addEventListener("click", function () {
  let arrowUp = document.querySelector(
    ".advanced_search .arrowButton.arrow-up"
  );
  let filter = document.querySelectorAll(".advanced_search .filter");
  if (this.classList.contains("d-flex")) {
    this.classList.remove("d-flex");
    this.classList.add("d-none");
  }
  if (arrowUp.classList.contains("d-none")) {
    arrowUp.classList.remove("d-none");
    arrowUp.classList.add("d-flex");
  }

  filter.forEach((item) => {
    if (item.classList.contains("d-none")) {
      item.classList.remove("d-none");
      item.classList.add("d-block");
    }
  });
});

arrowUp.addEventListener("click", function () {
  let arrowDown = document.querySelector(
    ".advanced_search .arrowButton.arrow-down"
  );
  let filter = document.querySelectorAll(".advanced_search .filter");

  if (this.classList.contains("d-flex")) {
    this.classList.remove("d-flex");
    this.classList.add("d-none");
  }
  if (arrowDown.classList.contains("d-none")) {
    arrowDown.classList.remove("d-none");
    arrowDown.classList.add("d-flex");
  }

  filter.forEach((item) => {
    if (item.classList.contains("d-block")) {
      item.classList.remove("d-block");
      item.classList.add("d-none");
    }
  });
});
