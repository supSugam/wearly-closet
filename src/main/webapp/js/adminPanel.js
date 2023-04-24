
window.addEventListener("load", () => {
    const optionsDropdown = (el, multiple) => {
        const options = Array.from(el.querySelectorAll(".option-title"));
        const dropdown = (e) => {
            const next = e.currentTarget.nextElementSibling;

            const linkParent = e.currentTarget.parentNode;

            next.classList.toggle("show");
            linkParent.classList.toggle("open");

            if (!multiple) {
                const options = Array.from(el.querySelectorAll(".option-breakdown"));

                options.forEach((option) => {
                    if (option !== next) {
                        option.classList.remove("show");
                        // option.parentNode.classList.remove("open");
                    }
                });
            }
        };

        options.forEach((option) => {
            option.addEventListener("click", dropdown);
        });
    };

    const optionsList = Array.from(document.querySelectorAll(".options-list"));
    optionsList.forEach((optionList) => {
        optionsDropdown(optionList, false);
    });
});

const adminPanel = document.querySelector(".admin-tools-container");
const adminPanelContents = adminPanel.querySelectorAll(
    ":scope > form,:scope > div"
);

const loader = document.querySelector(".loader-animated");

const adminMenuItems = document.querySelectorAll(".option-breakdown");

adminMenuItems.forEach((item) => {
    adminPanelContents.forEach((panel) => {
        if(!panel.classList.contains("product-form-body")){
            panel.classList.add("hidden");
        }

    });

    item.addEventListener("click", (e) => {
        adminPanelContents.forEach((panel) => {
            panel.classList.add("hidden");
            loader.classList.remove("hidden");
        });

        const requestFor = e.target.closest(".option-for").dataset.viewpage;

        if (requestFor === "add-product") {
            setTimeout(function () {
                loader.classList.add("hidden");
                document.querySelector(".add-product-form").classList.remove("hidden");
            }, 1000); // Remove class after 3 seconds
        }

        if (requestFor === "view-orders") {
            setTimeout(function () {
                loader.classList.add("hidden");
                document
                    .querySelector(".table-container.table__customer-orders")
                    .classList.remove("hidden");
            }, 1000); // Remove class after 3 seconds
        }
        console.log(requestFor);
        if (requestFor === "view-products") {
            setTimeout(function () {
                loader.classList.add("hidden");
                document
                    .querySelector(".table-container.table__product-list")
                    .classList.remove("hidden");
            }, 1000); // Remove class after 3 seconds
        }
    });
});

const productSearchInput = document.querySelector(
    ".search__form-products input"
);

productSearchInput.addEventListener("keypress", (e) => {
    if (e.key === "Enter") {
        const searchQuery = e.target.value;

        fetch("/my-servlet-url", {
            method: "get",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({ searchQuery }),
        })
            .then((response) => {
                if (response.status === 200) {
                    console.log("Response OK");
                } else {
                    console.log("Response not OK");
                }
            })
            .then((data) => {
                // Handle the response from the servlet
                console.log(data);
            })
            .catch((error) => {
                console.error("Error:", error);
            });
    }
});


let editProductForm = document.querySelector(".edit-product-form");
let editNameInput = document.getElementById("product-name__edit");
let editPriceInput = document.getElementById("product-price__edit");
let editDescriptionInput = document.getElementById("product-description__edit");
let editBrandInput = document.getElementById("product-brand__edit");
let editQuantityInput = document.getElementById("product-quantity__edit");
let editPicturePreview = document.getElementById("imagePreview-edit");
let editSubmitBtn = editProductForm.querySelector(".btn-primary");

document.querySelectorAll(".btn--editProduct").forEach((btn) => {
    btn.addEventListener("click", (e) => {
        e.preventDefault();
        const productId = e.target.dataset.id;
        adminPanelContents.forEach((panel) => {
            panel.classList.add("hidden");
            loader.classList.remove("hidden");
        });


        fetch(`http://localhost:8080/wearly-ecommerce/EditProductServlet?productId=${productId}`, {
            method: "get",
        }).then(response => response.json())
            .then(data => {
                const dataToSave = data;
                dataToSave.description = dataToSave.description.replace(/\|\|/g, "\n");
                saveOldProductData(dataToSave);
                editNameInput.value = data.product_name;
                editPriceInput.value = data.price;
                editBrandInput.value = data.brand;
                editQuantityInput.value = data.stock_quantity;
                editPicturePreview.style.backgroundImage = `url(../images/product-images/${data.image_name})`;
                editSubmitBtn.dataset.id = data.product_id;
                editDescriptionInput.value = data.description.replace(/\|\|/g, "\n");
                editProductForm.classList.remove("hidden");
            })
            .catch(error => {
                console.error('Error:', error);
            });

        setTimeout(function () {
            loader.classList.add("hidden");
            document
                .querySelector(".edit-product-form")
                .classList.remove("hidden");
        }, 1000);
    });
})
