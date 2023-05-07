"use strict";

// A debounce function that wraps around the input event handler
const debounce = (fn, delay) => {
    let timer;

    return function (...args) {
        clearTimeout(timer);
        timer = setTimeout(() => {
            fn(...args);
            timer = null;
        }, delay);
    };
};

// Select the necessary DOM elements
const searchInput = document.getElementById("productSearch__input");
const searchForm = document.getElementById("productSearch__form");
const icons = searchForm.querySelectorAll("i");
const [searchIcon, spinIcon, xIcon] = icons;
const dropdownMenuSearch = document.querySelector(
    ".dropdown-menu-searchsuggestions"
);

const dropdownListener = function () {
    document.querySelectorAll(".dropdown-menu-searchsuggestions .dropdown-option").forEach((option) => {
        option.addEventListener("click", () => {
            searchInput.value = option.dataset.value;
            searchProductSubmit(searchInput.value);
        });
    });
}
dropdownListener()

const searchProductSubmit = function (searchQuery) {
    window.location.href = `http://localhost:8080/wearly-ecommerce/view/products.jsp?searchQuery=${searchQuery}`;
}

// Add an input event listener with the debounced handler
searchInput.addEventListener(
    "input",
    debounce(async (e) => {
        // Get the trimmed input value and check if it's not empty
        const inputValue = e.target.value.trim();
        const hasValue = inputValue.length > 0;

        // Remove the 'active' class from all icons
        icons.forEach((icon) => icon.classList.remove("active"));
        const dropdownDefaults = `
                <p><i class="fa-solid fa-fire"></i> Popular Right Now</p>
                <li class="dropdown-option" data-value="hoodie">
                    <i class="fa-light fa-magnifying-glass"></i>Hoodie
                </li>
                <li class="dropdown-option" data-value="tshirt">
                    <i class="fa-light fa-magnifying-glass"></i>Tshirt
                </li>
                <li class="dropdown-option" data-value="formalwear">
                    <i class="fa-light fa-magnifying-glass"></i>Formals
                </li>
`;
        dropdownMenuSearch.innerHTML = "";

        // If the input value is not empty
        if (hasValue) {
            // Send a request to the server to retrieve matching product names
            const response = await fetch(`http://localhost:8080/wearly-ecommerce/Search?query=${inputValue}`, {
                method: 'get',
            });

            const matchingTerms = await response.json();
            console.log(matchingTerms);

            matchingTerms.forEach((term, i) => {
                dropdownMenuSearch.innerHTML += `						<li class="dropdown-option" data-value=${term}>
				<i class="fa-light fa-magnifying-glass"></i></i>${term}
			</li>`;
            });
            dropdownListener();

            // Add the 'active' class to the spin icon and set a timeout of 2 seconds
            spinIcon.classList.add("active");
            setTimeout(() => {
                // Check if the input value has not changed during the timeout
                if (inputValue === searchInput.value.trim()) {
                    // Add the 'active' class to the x icon and remove it from the spin icon
                    xIcon.classList.add("active");
                    spinIcon.classList.remove("active");
                }
            }, 200);
        } else {
            // Add the 'active' class to the x icon if the input is empty
            searchIcon.classList.add("active");
            dropdownMenuSearch.innerHTML = dropdownDefaults;
        }
    }, 500)
);

// Add a click event listener to the x icon to clear the input and reset the icons
searchForm.querySelector(".fa-x").addEventListener("click", () => {
    searchInput.value = "";
    icons.forEach((icon) => icon.classList.remove("active"));
    searchIcon.classList.add("active");
});

searchInput.addEventListener("focus", () => {
    dropdownMenuSearch.classList.add("open");
});
searchInput.addEventListener('keydown', function(event) {
    if (event.key === "Enter") {
        event.preventDefault();
        searchProductSubmit(searchInput.value);
    }
});

document.addEventListener("click", (event) => {
    if (!searchInput.contains(event.target)) {
        dropdownMenuSearch.classList.remove("open");
    }
});
