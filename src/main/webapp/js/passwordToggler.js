"use strict";
// To toggle password view

document.addEventListener("DOMContentLoaded", function () {
	const passwordViewToggler = function () {
		const btnToggle = document.querySelector(".toggle-password-view");
		if (!btnToggle) return;
		let loginSignupForm = document.querySelector(".signup-form");
		if(!loginSignupForm) loginSignupForm = document.querySelector(".login-form");
		if (!loginSignupForm) return;
		let passwordInput = loginSignupForm.querySelector("input[type=password]");

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
