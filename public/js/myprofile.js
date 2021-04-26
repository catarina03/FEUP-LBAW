/* My profile*/

let pencil = document.querySelector(".my-profile .pencil-icon");
let save = document.querySelector(".my-profile .save-form");

if (pencil != null) {
  pencil.addEventListener("click", function () {
    let bio = document.querySelector(".my-profile .bio");
    let bio_form = document.querySelector(".my-profile .bio-form");
    if (bio.classList.contains("d-flex")) {
      bio.classList.remove("d-flex");
      bio.classList.add("d-none");
    }

    if (bio_form.classList.contains("d-none")) {
      bio_form.classList.remove("d-none");
      bio_form.classList.add("d-flex");
    }
  });
}
if (save != null) {
  save.addEventListener("submit", function () {
    let bio = document.querySelector(".my-profile .bio");
    let bio_form = document.querySelector(".my-profile .bio-form");
    if (bio_form.classList.contains("d-flex")) {
      bio_form.classList.remove("d-flex");
      bio_form.classList.add("d-none");
    }

    if (bio.classList.contains("d-none")) {
      bio.classList.remove("d-none");
      bio.classList.add("d-flex");
    }
  });
}
