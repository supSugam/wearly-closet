
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
    adminPanelContents.forEach((panel) => {

            if(panel.classList.contains("add-product-form")){
                panel.classList.remove("hidden");
                loader.classList.add("hidden");
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
                    .querySelector(".table__customer-list")
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

// Customer Section

const customerListContainer = document.querySelector(".table__customer-list");

const customerSearchForm = customerListContainer.querySelector(".search__form-customer");
const searchFeedbackUser = document.querySelector(".search-feedback__text");

const userResultsContainer = customerListContainer.querySelector(".user-results-container");


customerSearchForm.addEventListener("submit", (e) => {
    e.preventDefault();
    let searchQuery = customerSearchInput.value;
    if(searchQuery==="") searchQuery="all";
    searchCustomer(searchQuery);
});

const customerSearchInput = customerSearchForm.querySelector("input");
customerSearchInput.addEventListener("keydown", (e) => {
    if(e.key==="Enter"){
        let searchQuery = customerSearchInput.value;
        if(searchQuery==="") searchQuery="all";
        searchCustomer(searchQuery);
    }
})

const searchCustomer = (searchQuery) => {
    customerListContainer.querySelector(".table-wrapper").style.opacity = "0.6";
    async function getCustomers() {
        const response = await fetch(`http://localhost:8080/wearly-ecommerce/SearchCustomersServlet?searchQuery=${searchQuery}`, {
            method: 'get'
        });
        const data = await response.json();
        return data;
    }

    const generateUserMarkup = (user) => {
        const markup = `
                                  <tr>
                                    <td class="image-column">
                                        <img src="../images/user-images/${user.image_name}" alt="Product Image" />
                                    </td>
                                    <td>${user.user_id}</td>
                                    <td>${user.first_name}</td>
                                    <td>${user.last_name}</td>
                                    <td>${user.phone_number}</td>
                                    <td>${user.registered_date}</td>
                                    <td>
                                        <button onclick="viewCustomerOrders(${user.user_id})" class="btn btn-action__customer btn--viewOrders">View Orders</button>
                                    </td>
                                </tr>
        `
        userResultsContainer.insertAdjacentHTML("beforeend", markup);
    };

    function displayCustomers() {

        return getCustomers().then(responseData => {

            const searchResultsCount = responseData.length;

            console.log(responseData, searchResultsCount);

            if (searchResultsCount === 0) {
                searchFeedbackUser.classList.add("showMessage");
                customerListContainer.querySelector(".table-wrapper").style.opacity = "1";
                userResultsContainer.innerHTML = "";
            }

            if(searchResultsCount>0){
                userResultsContainer.innerHTML = "";
                responseData.forEach(user => {
                    generateUserMarkup(user);
                });
                customerListContainer.querySelector(".table-wrapper").style.opacity = "1";
            }
        });
    }

    setTimeout(function () {displayCustomers()}, 1000);
};


const viewCustomerOrders = (userId) => {
    userId = userId.toString();
    window.location.href = `http://localhost:8080/wearly-ecommerce/view/orders.jsp?userId=${userId}`;
};


//------------------------------------------------//


document.querySelectorAll(".btn--deleteProduct").forEach((btn) => {

    btn.addEventListener("click", (e) => {
        e.preventDefault();
        const productId = e.target.dataset.id;
        const productRow = e.target.closest("tr");
        fetch(`http://localhost:8080/wearly-ecommerce/DeleteProductServlet?productId=${productId}`, {
            method: "get",
        }).then((response) => {
            if(response.status===200){
                productRow.remove();
            } else{
                console.log("Response not OK");
            }
        });
    })
});
//------------------------------------------------//

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
