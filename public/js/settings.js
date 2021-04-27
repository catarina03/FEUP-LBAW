let tags = document.querySelectorAll(".settings .tags a");

tags.forEach((item) =>
  item.addEventListener("click", function () {
    item.remove();
    let tags = document.querySelectorAll(".settings .tags a");
    if (tags.length == 0) {
      let tag = document.querySelector(".settings .tags");
      let text = document.createElement("p");
      text.innerText = "You don't follow any tags";
      tag.append(text);
    }
  })
);
