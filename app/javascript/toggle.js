const toggle_p = document.querySelector(".toggle_p");
const toggle = document.getElementById("toggle").addEventListener("change", function (event) {
  if (toggle_p.textContent == "Public") {
    toggle_p.textContent = "Private";
  } else {
    toggle_p.textContent = "Public";
  }
});
