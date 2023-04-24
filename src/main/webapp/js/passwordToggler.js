"use strict";
// To toggle password view

document.addEventListener("DOMContentLoaded", function () {
	const passwordViewToggler = function () {
		const btnToggle = document.querySelector(".toggle-password-view");
		if (!btnToggle) return;
		const signupForm = document.querySelector(".signup-form");
		let passwordInput = signupForm.querySelector("input[type=password]");

		btnToggle.addEventListener("click", function () {
			const passwordInputType = passwordInput.getAttribute("type");

			if (passwordInputType === "password") {
				passwordInput.setAttribute("type", "text");
			} else {
				passwordInput.setAttribute("type", "password");
			}

			btnToggle.querySelector(".ph-eye").classList.toggle("hidden");
			btnToggle.querySelector(".ph-eye-slash").classList.toggle("hidden");
		});
	};

	passwordViewToggler();
});
