"use strict";

document.addEventListener("DOMContentLoaded", function () {
	const featuredSectionEffects = function () {
		const featuredBox = document.querySelectorAll(".featured-box");

		if (!featuredBox) return;
		featuredBox.forEach(function (box) {
			box.addEventListener("mouseenter", function (e) {
				const textBox = e.target.querySelector(".featured-box__text");
				const textEl = textBox.querySelectorAll("h1,h3");

				const gradientEl = textBox.querySelector(".gradient-text");

				gradientEl.classList.remove("gradient-text");
				gradientEl.classList.add("text--blue");

				textEl.forEach((text) => {
					text.classList.add("text--active");
				});
			});

			box.addEventListener("mouseleave", function (e) {
				const textBox = e.target.querySelector(".featured-box__text");
				const textEl = textBox.querySelectorAll("h1,h3");

				const gradientEl = textBox.querySelector(".text--blue");
				gradientEl.classList.add("gradient-text");
				gradientEl.classList.remove("text--blue");

				textEl.forEach((text) => {
					text.classList.remove("text--active");
				});
			});
		});
	};
	featuredSectionEffects();
});
