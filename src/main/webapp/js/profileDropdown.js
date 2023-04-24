"use strict";

const headerIcons = document.querySelector(".header__icons");
const profileDropdown = document.querySelector(".dropdown-menu-profile");

headerIcons.addEventListener("click", function (e) {
	const target = e.target;

	if (!target) return;
	if (target.classList.contains("fa-user")) {
		profileDropdown.classList.toggle("open");
		if (profileDropdown.classList.contains("open"))
			target.classList.add("gradient-text");
		else target.classList.remove("gradient-text");
	}
});

document.addEventListener("click", (event) => {
	if (!event.target.closest(".header__icons")) {
		profileDropdown.classList.remove("open");
		document.querySelector(".fa-user").classList.remove("gradient-text");
	}
});
