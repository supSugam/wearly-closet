document.addEventListener('DOMContentLoaded', function() {

    const passwordViewTogglerAll = function () {
        const btnToggle = document.querySelectorAll(".toggle-password-view");

        btnToggle.forEach((btn) => {
            btn.addEventListener("click", function () {
                const passwordInput = btn.closest(".password-field").querySelector("input[type='password']");
                const passwordInputType = passwordInput.getAttribute("type");

                if (passwordInputType === "password") {
                    passwordInput.setAttribute("type", "text");
                } else {
                    passwordInput.setAttribute("type", "password");
                }

                btnToggle.querySelector(".ph-eye").classList.toggle("hidden");
                btnToggle.querySelector(".ph-eye-slash").classList.toggle("hidden");
            });
        })
    };

    passwordViewTogglerAll();
});