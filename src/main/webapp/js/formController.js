


"use strict";


const showError = function (inputField, message = "You must fill this field.") {
    inputField.classList.add("error");
    inputField
        .closest(".input-field-container")
        .querySelector(".error-message")
        .classList.add("show");
    inputField
        .closest(".input-field-container")
        .querySelector(".error-message").innerHTML = message;
};

const removeError = function (inputField) {
    inputField.classList.remove("error");
    inputField
        .closest(".input-field-container")
        .querySelector(".error-message")
        .classList.remove("show");

};

const projectPath = "http://localhost:8080/wearly-ecommerce";

const validateLoginForm = function () {

    const loginForm = document.querySelector(".login-form");
    const inputFields = loginForm.querySelectorAll(
        "input[type=email][required], input[type=password][required]"
    );


    const btnLogin = loginForm.querySelector(".btn-login");
    btnLogin.disabled = true;
    btnLogin.classList.add("disabled");

    const checkBoxInput = loginForm.querySelector('input[type="checkbox"]');

    let isValid = true;

    inputFields.forEach((inputField) => {
        inputField.addEventListener("input", () => {
            removeError(inputField);
        });

        if (!inputField.value) {
            isValid = false;
            showError(inputField, `${inputField.placeholder} is required.`);
        }
    });

    if (!isValid) {
        btnLogin.disabled = false;
        btnLogin.classList.remove("disabled");
        return false;
    }
    btnLogin.innerHTML = 'Logging In <i class="fa-duotone fa-spinner-third fa-spin"></i>';


    const formData = new FormData(loginForm);
    // Extract form input values using object destructuring
    const loginDataObject =  Object.fromEntries(formData.entries());
    loginDataObject["rememberPassword"] = checkBoxInput.checked;

    // convert the object to JSON using JSON.stringify()
    const loginDataJSON = JSON.stringify(loginDataObject);

    // send POST request to servlet
    fetch(`${projectPath}/LoginServlet`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        credentials: 'include',
        body: loginDataJSON
    }).then(response => {
        if (response.status === 200) {
            console.log(response.ok,response.status);
            window.location.href = `${projectPath}/view/index.jsp`;
        } else {
            // If login fails, display an error message to the user
            btnLogin.disabled = false;
            btnLogin.innerHTML = 'Login';
            btnLogin.classList.remove("disabled");
            showError(inputFields[0], "Invalid email or password!")
        }
    })
        .catch(error => {
            console.error('Error:', error);
            window.location.href = `${projectPath}/view/error.jsp`;
        });

    // submit form if validation is successful
    return true;
};


const validateSignupForm = function () {
    const signupForm = document.querySelector(".signup-form");

    const inputFields = signupForm.querySelectorAll(
        "input[type=text][required], input[type=email][required], input[type=password][required], input[type=number][required]"
    );
    const imageInput = signupForm.querySelector("input[type=file][required]");

    const checkBoxInput = signupForm.querySelector('input[type="checkbox"]');
    const checkBoxText = signupForm
        .querySelector(".label-checkmark")
        .querySelector("p");

    const btnSignup = signupForm.querySelector(".btn-signup");
    btnSignup.disabled = true;
    btnSignup.classList.add("disabled");

    let isValid = true;

    const validateCheckBox = function () {
        if (checkBoxInput.checked) {
            isValid = true;
            checkBoxText.classList.remove("error-checkbox", isValid);
        } else {
            isValid = false;
            checkBoxText.classList.add("error-checkbox", isValid);
        }
    };
    validateCheckBox();

    checkBoxInput.addEventListener("change", validateCheckBox);

    inputFields.forEach((inputField) => {
        if (!inputField.value) {
            isValid = false;
            showError(inputField, `${inputField.placeholder} is required.`);
        } else {
            if (inputField.type === "email") {
                const emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
                if (!emailRegex.test(inputField.value)) {
                    isValid = false;
                    showError(inputField, "Enter a valid email address!");
                }
            }

            if (inputField.type === "password") {
                if (inputField.value.length < 8) {
                    isValid = false;
                    showError(inputField, "Must be at least 8 characters long!");
                }
            }

            if (inputField.type === "number") {
                if (inputField.value.length !== 10) {
                    isValid = false;
                    showError(inputField, "Must be 10 digits long!");
                }
            }
        }

        inputField.addEventListener("input", () => {
            removeError(inputField);
        });
    });

    if (imageInput.files.length !== 1) {
        isValid = false;
        document.querySelector(".avatar-preview").classList.add("error-image");
    }


    if (!isValid) {
        btnSignup.disabled = false;
        return false;
    }

    btnSignup.innerHTML = 'Signing Up.. <i class="fa-duotone fa-spinner-third fa-spin"></i>';


    const formData = new FormData(signupForm);

// Extract form input values using object destructuring
    const {
        email,
        phone,
        password
    } = Object.fromEntries(formData.entries());
    const firstName = formData.get("first-name");
    const lastName = formData.get("last-name");

    const reader = new FileReader();
    reader.readAsDataURL(imageInput.files[0]);
    reader.onload = () => {
        const imageDataUrl = reader.result;
        // create an object to store the form data
        const formObject = {
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
            password: password,
            profileImage: imageDataUrl
        };
        // convert the object to JSON using JSON.stringify()
        const registrationDataJSON = JSON.stringify(formObject);

    // send POST request to servlet
    fetch(`${projectPath}/UserRegistrationServlet`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        credentials: 'include',
        body: registrationDataJSON
    }).then(response => {
            if (response.status === 200) {
                console.log(response.ok,response.status);
                window.location.href = `${projectPath}/view/index.jsp`;
            } else {
                // If login fails, display an error message to the user
                showError(document.querySelector(".email-field"), "Email already exists!")
                btnSignup.disabled = false;
                btnSignup.innerHTML = 'Sign Up';
                btnSignup.classList.remove("disabled");
            }
        })
            .catch(error => {
                console.error('Error:', error);
                window.location.href = `${projectPath}/view/error.jsp`;
            });
    return true;
    };
};

let productInfoObj;
const saveOldProductData = function (productInfo){
    productInfoObj = productInfo;
}
const validateAddProductForm = function (formFor="AddProductServlet") {
    let inputChanged = false;
    let imageChanged = false;
    let productForm;


    formFor === "AddProductServlet" ? productForm = document.querySelector(".add-product-form") : productForm = document.querySelector(".edit-product-form");

    const inputFields = productForm.querySelectorAll(
        "input[type=text][required], input[type=number][required], textarea[type=text][required]"
    );
    const imageInput = productForm.querySelector("input[type=file][required]");

    const descriptionField = productForm.querySelector(".product-description");
    let descriptionText;

    const btnSubmit = productForm.querySelector(".btn-primary"); //btn primaru
    btnSubmit.disabled = true;
    btnSubmit.classList.add("disabled");

    let selectedGender = "";
    let selectedCategory = "";

    productForm.querySelectorAll(".category-list").forEach((category) => {
        category.querySelectorAll("input[type=checkbox]").forEach((checkbox) => {
            if (checkbox.checked && category.classList.contains("category-gender")) {
                selectedGender = checkbox.value.toLowerCase();
            }
            if (
                checkbox.checked &&
                category.classList.contains("category-category")
            ) {
                selectedCategory = checkbox.value.toLowerCase();
            }
        });
    });

    let isValid = true;

    inputFields.forEach((inputField) => {

        if (!inputField.value) {
            isValid = false;
            showError(inputField, `${inputField.placeholder} is required.`);
        } else {
            if (inputField.name === "product-name" && formFor === "EditProductServlet" && inputField.value !== productInfoObj.product_name) {
                inputChanged = true;
            }
            if (inputField.name === "product-brand" && formFor === "EditProductServlet" && inputField.value !== productInfoObj.brand) {
                inputChanged = true;
            }

            if (
                inputField.type === "number" &&
                inputField.name === "product-quantity"
            ) {
                if (formFor === "EditProductServlet" && +inputField.value !== productInfoObj.stock_quantity) {
                    inputChanged = true;
                }

            }
            if (inputField.value < 1) {
                isValid = false;
                showError(inputField, "Quantity must be atleast 1");
            }


            if (inputField.type === "number" && inputField.name === "product-price") {

                if (formFor === "EditProductServlet" && +inputField.value !== productInfoObj.price) {
                    inputChanged = true;
                }
                if (inputField.value < 100) {
                    isValid = false;
                    showError(inputField, "Price must be atleast Rs. 100");
                }
            }

            if (inputField.name === "product-description") {
                if (formFor === "EditProductServlet" && inputField.value !== productInfoObj.description) {
                    inputChanged = true;
                }
                if (inputField.value.length < 50) {
                    isValid = false;
                    showError(
                        inputField,
                        "Description must be atleast 50 characters long"
                    );
                }
            }
        }


        descriptionText = descriptionField.value.split("\n").map((line) => {
            return line;
        });

        inputField.addEventListener("input", () => {
            removeError(inputField);
            productForm.querySelector(".no-change-error").classList.remove("show");
        });
    });

    const descriptionString = descriptionText.join("||");

    if (imageInput.files.length !== 1 && formFor === "AddProductServlet") {
        isValid = false;
        document.querySelector(".product-preview").classList.add("error-image");
    }

    imageInput.addEventListener("change", () => {
        inputChanged = true;
        imageChanged = true;
    })

    if(formFor === "EditProductServlet"){
        console.log(inputChanged, imageChanged,isValid);
        if(inputChanged===false) {
            console.log(inputChanged, imageChanged,isValid);

            isValid = false;
            productForm.querySelector(".no-change-error").classList.add("show");

        }
    }

    if (!isValid) {
        console.log(inputChanged, imageChanged,isValid);

        btnSubmit.disabled = false;
        btnSubmit.classList.remove("disabled");
        return false;
    }
    console.log(inputChanged, imageChanged,isValid);


    btnSubmit.innerHTML =
        'Saving Product <i class="fa-duotone fa-spinner-third fa-spin"></i>';

    const formData = new FormData(productForm);
    console.log(formData);

    const {
        "product-name": productName,
        "product-price": productPrice,
        "product-quantity": productQuantity,
        "product-brand": productBrand,
    } = Object.fromEntries(formData.entries());

    let productObject = {
        productName: productName,
        productPrice: productPrice,
        productBrand: productBrand,
        productQuantity: productQuantity,
        productGender: selectedGender,
        productCategory: selectedCategory,
        productDescriptionText: descriptionString,
        newImage: imageChanged,
        productImage: null,
    };
    // create a Promise that resolves when the image is finished rendering
    const imagePromise = new Promise((resolve) => {
        if (formFor === "AddProductServlet" || imageChanged) {
            const reader = new FileReader();
            reader.readAsDataURL(imageInput.files[0]);
            reader.onload = () => {
                productObject.productImage = reader.result;
                resolve();
            };
        } else if (formFor === "EditProductServlet") {
            productObject.productId = +btnSubmit.dataset.id;

            if (!imageChanged) {
                productObject.productImage = productInfoObj.image_name;
            }
            resolve();
        } else {
            // if no image is being added, resolve immediately
            resolve();
        }
    });

    imagePromise.then(() => {
        const productDataJSON = JSON.stringify(productObject);

        // send POST request to servlet
        fetch(`${projectPath}/${formFor}`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            credentials: "include",
            body: productDataJSON,
        })
            .then((response) => {
                if (response.status === 200) {

                    if(formFor === "EditProductServlet"){
                        openPopup(document.getElementById("edit-product__success"));
                        btnSubmit.innerHTML = "Save Changes";
                    }

                    if(formFor === "AddProductServlet"){
                        openPopup(document.getElementById("add-product__success"));
                        btnSubmit.innerHTML = "Save Product";

                    }
                    productForm.reset();
                    btnSubmit.disabled = false;
                    btnSubmit.classList.remove("disabled");
                } else {
                    // If login fails, display an error message to the user
                    btnSubmit.innerHTML = "Save Product";
                    btnSubmit.disabled = false;
                    btnSubmit.classList.remove("disabled");
                    productForm.querySelector(".no-change-error").textContent = "Something went wrong!";
                    productForm.querySelector(".no-change-error").classList.add("show");

                }
            })
            .catch((error) => {
                window.location.href = `${projectPath}/error.jsp`;
            });
        return true;
    });



};

document.addEventListener("DOMContentLoaded", () => {

    const forms = document.querySelectorAll("form");
    forms.forEach((form) => {
        form.addEventListener("submit", (e) => {
            e.preventDefault();
        });
    });



    // const checkBoxGender = document
    // 	.querySelector(".add-product-form")
    // 	.querySelector(".category-gender")
    // 	.querySelectorAll("input[type=checkbox]");

    // checkBoxGender.forEach((checkbox) => {
    // 	checkbox.addEventListener("click", (event) => {
    // 		// If the clicked checkbox is now checked
    // 		if (event.target.checked) {
    // 			// Uncheck the other checkboxes
    // 			checkBoxGender.forEach((otherCheckbox) => {
    // 				if (otherCheckbox !== event.target) {
    // 					otherCheckbox.checked = false;
    // 				}
    // 			});
    // 		}
    // 	});
    // });

    // const checkBoxCategory = document
    // 	.querySelector(".add-product-form")
    // 	.querySelector(".category-category")
    // 	.querySelectorAll("input[type=checkbox]");

    // let checkedCategory = [];

    // let lastCheckedCheckbox = null;

    // checkBoxCategory.forEach((checkbox) => {
    // 	checkbox.addEventListener("click", (e) => {
    // 		if (e.target.checked) {
    // 			if (lastCheckedCheckbox !== null && lastCheckedCheckbox !== e.target) {
    // 				lastCheckedCheckbox.checked = false;
    // 				checkedCategory = [e.target.value];
    // 			} else {
    // 				checkedCategory.push(e.target.value);
    // 			}
    // 			lastCheckedCheckbox = e.target;
    // 		} else {
    // 			checkedCategory = checkedCategory.filter(
    // 				(value) => value !== e.target.value
    // 			);
    // 			lastCheckedCheckbox = null;
    // 		}
    // 	});
    // });
});

// Method to validate the form
// const imageDataUrl = reader.result;
// // create an object to store the form data
// const productObject = {
//     productName: productName,
//     productPrice: productPrice,
//     productBrand: productBrand,
//     productQuantity: productQuantity,
//     productGender: selectedGender,
//     productCategory: selectedCategory,
//     productDescriptionText: descriptionString,
//     productImage: imageDataUrl,
//     newImage: imageChanged,
// };
// if(formFor === "EditProductServlet"){
//     productObject.productId = +btnSubmit.dataset.id;
//     if(!imageChanged){
//         productObject.productImage = productInfoObj.image_name;
//     }
// }
// convert the object to JSON using JSON.stringify()