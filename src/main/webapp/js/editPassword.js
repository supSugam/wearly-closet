
const showError = function (inputField, message = "You must fill this field.") {
    inputField.classList.add("error");
    inputField
        .closest(".input-field__edit-container")
        .querySelector(".error-message__edit")
        .classList.add("show");
    inputField
        .closest(".input-field__edit-container")
        .querySelector(".error-message__edit").innerHTML = message;
};

const removeError = function (inputField) {
    inputField.classList.remove("error");
    inputField
        .closest(".input-field__edit-container")
        .querySelector(".error-message__edit")
        .classList.remove("show");

};

const editPasswordForm = document.querySelector(".editPassword-form");
editPasswordForm.addEventListener("submit", (e) => {
    e.preventDefault();
    validateEditPassword();
});

const validateEditPassword = () => {
    let isValid = true;
    const inputFields = document.querySelectorAll("input[type='password']");

    const btnSubmit = document.querySelector(".btn-saveChanges");
    btnSubmit.disabled = true;
    btnSubmit.classList.add("disabled");

    const currentPassword = document.getElementById("current-password").value;
    const newPassword = document.getElementById("new-password").value;
    const confirmPassword = document.getElementById("confirm-password").value;

    inputFields.forEach((inputField) => {
        if(!inputField.value){
            showError(inputField,`${inputField.placeholder} is required!`);
            isValid = false;
        } else {
            if(inputField.value.length < 8){
                showError(inputField, "Must be at least 8 characters long.");
                isValid = false;
            }
        }

        inputField.addEventListener("input", () => {
            removeError(inputField);
        });
    });

    if(newPassword !== confirmPassword){
        showError(document.getElementById("confirm-password"), "Passwords do not match!");
        isValid = false;
    }
    if(newPassword === confirmPassword && newPassword === currentPassword){
        showError(document.getElementById("confirm-password"), "New password must be different from current password!");
        isValid = false;
    }

    if (!isValid) {
        btnSubmit.disabled = false;
        btnSubmit.classList.remove("disabled");
        return;
    }
    btnSubmit.innerHTML = "Saving Changes <i class='fas fa-spinner fa-spin'></i>";

        // send POST request to servlet
        fetch(`http://localhost:8080/wearly-ecommerce/EditPasswordServlet`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                currentPassword: currentPassword,
                newPassword: newPassword
            }),
        })
            .then((response) => {
                if (response.status === 200) {
                    // If login is successful, redirect the user to the home page
                    console.log("Password edited successfully");
                    btnSubmit.innerHTML = "Updated <i class='fas fa-check'></i>";
                    editPasswordForm.reset();
                } else {
                    // If login fails, display an error message to the user
                    console.log("Error editing password");
                    btnSubmit.innerHTML = "Save Changes";
                    btnSubmit.disabled = false;
                    btnSubmit.classList.remove("disabled");
                    showError(document.getElementById("current-password"), "Incorrect Password!");
                }
            })
            .catch((error) => {
                console.error("Error:", error);
            });


};