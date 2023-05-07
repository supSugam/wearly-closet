
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

const userInitials = {
    firstName: document.getElementById("first-name").value,
    lastName: document.getElementById("last-name").value,
    email: document.getElementById("email").value,
    phone: document.getElementById("phone").value,
    profileImage: document.getElementById("imagePreview").style.backgroundImage,
}
console.log(userInitials)

const editProfileForm = document.querySelector(".editProfile-form");
editProfileForm.addEventListener("submit", (e) => {
    e.preventDefault();
    validateEditProfile();
});

const validateEditProfile = () => {
    let isValid = true;
    let inputChanged = false;
    let imageChanged = false;
    const inputFields = document.querySelectorAll(".input-field__edit");
    const profilePreview = document.getElementById("imagePreview").style.backgroundImage;
    const btnSubmit = document.querySelector(".btn-editProfile");
    btnSubmit.disabled = true;

    inputFields.forEach((inputField) => {
        if(!inputField.value){
            showError(inputField,`${inputField.placeholder} is required!`);
            isValid = false;
        } else {
            if(inputField.type === "text"){
                if (inputField.value.length < 2) {
                    showError(inputField, "Must be at least 2 characters long.");
                    isValid = false;
                }
                if(inputField.value !== userInitials.firstName && inputField.value !== userInitials.lastName){
                    inputChanged = true;
                }
            }
            if (inputField.type === "number") {
                if (inputField.value.length !== 10) {
                    isValid = false;
                    showError(inputField, "Must be 10 digits long!");
                }
                if(inputField.value !== userInitials.phone){
                    inputChanged = true;
                }
            }
            if (inputField.type === "email") {
                const emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
                if (!emailRegex.test(inputField.value)) {
                    isValid = false;
                    showError(inputField, "Enter a valid email address!");
                }
                if(inputField.value !== userInitials.email){
                    inputChanged = true;
                }
            }
        }
    });

    if(profilePreview !== userInitials.profileImage){
        imageChanged = true;
        inputChanged = true;
    }
    if(!inputChanged){
        isValid = false;
    }

    if (!isValid) {
        btnSubmit.disabled = false;
        return false;
    }

    const editProfile = (userObject) => {

        // send POST request to servlet
        fetch(`http://localhost:8080/wearly-ecommerce/EditProfileServlet`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(userObject),
        })
            .then((response) => {
                if (response.status === 200) {
                    // If login is successful, redirect the user to the home page
                    console.log("Profile edited successfully");
                    btnSubmit.disabled = false;
                } else {
                    // If login fails, display an error message to the user
                    console.log("Error editing profile");
                }
            })
            .catch((error) => {
                console.error("Error:", error);
            });
    };

    let userObject = {
        firstName: document.getElementById("first-name").value,
        lastName: document.getElementById("last-name").value,
        email: document.getElementById("email").value,
        phoneNumber: document.getElementById("phone").value,
        imageChanged: imageChanged,
    }

    const imageInput = document.getElementById("profileUpload");

    if(imageChanged){
        const imagePromise = new Promise((resolve) => {
            const reader = new FileReader();
            reader.readAsDataURL(imageInput.files[0]);
            reader.onload = () => {
                userObject.profileImage = reader.result;
                resolve();
            };
        });

        imagePromise.then(() => {
            editProfile(userObject);
        });
    }
    if(!imageChanged){
        editProfile(userObject);
    }



};