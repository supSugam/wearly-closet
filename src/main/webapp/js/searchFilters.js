const rangeInput = document.querySelectorAll(".range-input input"),
    priceInput = document.querySelectorAll(".price-input input"),
    range = document.querySelector(".price-slider .progress");
let priceGap = 1000;
const animatedLoader = document.querySelector(".loader-animated");

const searchResultsContainer = document.querySelector(".search-results-content");

const searchHeading = document.querySelector(".search-results-header .search-heading-text")

// Unused code since the html input field is readonly

// priceInput.forEach((input) => {
// 	input.addEventListener("change", (e) => {
// 		let minPrice = parseInt(priceInput[0].value),
// 			maxPrice = parseInt(priceInput[1].value);

// 		if (maxPrice - minPrice >= priceGap && maxPrice <= rangeInput[1].max) {
// 			if (e.target.className === "input-min") {
// 				rangeInput[0].value = minPrice;
// 				range.style.left = (minPrice / rangeInput[0].max) * 100 + "%";
// 			} else {
// 				rangeInput[1].value = maxPrice;
// 				range.style.right = 100 - (maxPrice / rangeInput[1].max) * 100 + "%";
// 			}
// 		}
// 	});
// });

rangeInput.forEach((input) => {
    input.addEventListener("change", (e) => {
        const minPrice = parseInt(rangeInput[0].value),
            maxPrice = parseInt(rangeInput[1].value);
        // console.log(`Min Value:${minPrice}, Max Value:${maxPrice}}`);
        getAllFilters();
    });

    input.addEventListener("input", (e) => {
        let minVal = parseInt(rangeInput[0].value),
            maxVal = parseInt(rangeInput[1].value);

        if (maxVal - minVal < priceGap) {
            if (e.target.className === "range-min") {
                rangeInput[0].value = maxVal - priceGap;
            } else {
                rangeInput[1].value = minVal + priceGap;
            }
        } else {
            priceInput[0].value = minVal;
            priceInput[1].value = maxVal;
            range.style.left = (minVal / rangeInput[0].max) * 100 + "%";
            range.style.right = 100 - (maxVal / rangeInput[1].max) * 100 + "%";
        }
    });
});


const getSelectedFilters = function(filterCategory) {
    let selectedValue;
    filterCategory.forEach((input) => {
        if (input.checked) {
            selectedValue = input.value;
        }
        if(!selectedValue) {
            selectedValue = "all";
        }
    });
    return selectedValue;
}

document.querySelector(".filter-options").querySelectorAll("input[type=checkbox]").forEach((input) => {

    input.addEventListener("change", (e) => {
        getAllFilters();
    });
});


const getAllFilters = function() {
    let selectedGender = getSelectedFilters(document.querySelectorAll(".category-gender input[type=checkbox]"));
    let selectedCategory = getSelectedFilters(document.querySelectorAll(".category-category input[type=checkbox]"));
    let selectedBrand = getSelectedFilters(document.querySelectorAll(".category-brand input[type=checkbox]"));
    let selectedSortBy;
    document.querySelectorAll(".dropdown-menu-sortby .dropdown-option").forEach((sortOption) => {
        if(sortOption.classList.contains("selected")) {
            selectedSortBy = sortOption.dataset.value;
        }
    });

    let minPrice = +rangeInput[0].value
    let maxPrice = +rangeInput[1].value

    const params = new URLSearchParams(window.location.search);
    let searchTerm = params.get('searchQuery');
    if (!searchTerm) searchTerm = "all";

    const searchFilters = {
        selectedGender,
        selectedCategory,
        selectedBrand,
        selectedSortBy,
        minPrice,
        maxPrice,
        searchTerm
    }

    fetchSearchResults(searchFilters);

};

const generateResultsMarkup = function(product,isAdmin) {

    const markup = `
    <div data-id="${product.product_id}" class="product_card">
        <div class="product_card--image">
            <img src="../images/product-images/${product.image_name}" class="product-img" alt="${product.product_name}">
        </div>

        <div class="product_card--content">
            <div class="portrait-container">
                <div class="portrait"></div>
                <p class="price-currency">Rs. <span class="product-price">${product.price}</span></p>
            </div>
            <div class="product-attribute">
                <i class="ph-fill ph-seal-check"></i>
                <span class="product-brand">${product.brand}</span>
            </div>

            <p class="product-title">${product.product_name}</p>

            <ul class="product-attributes">
                <li class="product-tags">
                    <span class="tag-content product-type">${product.category_name}</span>
                    <span class="tag-content product-type">${product.gender}</span>
                </li>

                <li class="product-attribute">
                    <p>Ratings</p>
                    <div data-rating="${product.rating}" class="attribute-boxes product-rating"></div>
                </li>
            </ul>

            <p class="stock-quantity"><span class="stock-quantity-value">${product.stock_quantity}</span> Left in Stock.</p>

            <div class="add-to-cart">
                ${isAdmin ? `
                    <button data-id="${product.product_id}" class="btn btn-action btn--editProduct">Edit</button>
                    <button data-id="${product.product_id}" class="btn btn-action btn--deleteProduct">Delete</button>
                ` : `
                    <div class="quantity-input">
                        <button class="quantity-btn minus">-</button>
                        <input class="quantity-value" type="number" value="1" min="1" max="${product.stock_quantity}" readonly>
                        <button class="quantity-btn plus">+</button>
                    </div>

                    <button type="button" class="btn btn--cart">Add to Cart <i class="ph-fill ph-shopping-cart"></i></button>
                `}
            </div>
        </div>
    </div>
`;
    searchResultsContainer.insertAdjacentHTML('beforeend', markup);

};

const fetchSearchResults = function(searchFilters) {
    document.querySelectorAll(".product_card").forEach((element) => {
        element.remove();
    });
    animatedLoader.classList.remove("hidden");
    document.querySelector(".search-section").querySelectorAll("*").forEach((element) => {
        if(!element.classList.contains("loader-animated")) element.style.opacity = "0.7";
    });


    async function getProducts() {
        const response = await fetch('http://localhost:8080/wearly-ecommerce/Search', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(searchFilters)
        });
        const data = await response.json();
        return data;
    }

    function displayProducts() {
        document.querySelector(".search-section").querySelectorAll("*").forEach((element) => {
            if(element.classList.contains("loader-animated")){
                element.classList.add("hidden");
            }
            element.style.opacity = "1";

        });

        return getProducts().then(responseData => {
            const products = responseData.products;
            const isAdmin = responseData.isAdmin;

            const searchResultsCount = products.length;
            if(searchFilters.searchTerm==="all") {
                searchHeading.textContent = 'All Products';
            }
            if(searchFilters.searchTerm!=="all") {
                searchHeading.textContent = `${searchResultsCount} Search Results for "${searchFilters.searchTerm}"`;
            }

            if(searchResultsCount===0) {
                searchHeading.textContent = `No Search Results for "${searchFilters.searchTerm}"`;
                document.querySelector(".no-results-image").classList.remove("hidden");
            }

            if(searchResultsCount!==0){
                if(!document.querySelector(".no-results-image").classList.contains("hidden")){
                    document.querySelector(".no-results-image").classList.add("hidden");
                }
                products.forEach((product) => {
                    generateResultsMarkup(product,isAdmin);
                });
            }
        });
    }

    setTimeout(() => {
        displayProducts()
            .then(() => {
                productCardInit();
            });
    }, 1000);


}



