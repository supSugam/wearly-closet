document.addEventListener("DOMContentLoaded", function () {
    // Get the dropdown elements
    const dropdownWrapper = document.querySelector(".dropdown-wrapper");
    if (!dropdownWrapper) return;
    const dropdownBtn = dropdownWrapper.querySelector(".dropdown-btn");
    const dropdownMenu = dropdownWrapper.querySelector(".dropdown-menu-sortby");
    const dropdownOptions = dropdownMenu.querySelectorAll(".dropdown-option");

    // Set default selected option

    let selectedOption = dropdownMenu.querySelector(".selected");

    // Function to toggle dropdown
    function toggleDropdown() {
        dropdownMenu.classList.toggle("open");
        dropdownBtn.classList.toggle("open");
    }

    // Function to select an option
    const selectOption = function (option) {
        selectedOption.classList.remove("selected");
        selectedOption = option;
        selectedOption.classList.add("selected");
        dropdownBtn.querySelector(".selected-option").innerHTML =
            selectedOption.innerHTML;
        toggleDropdown();
        // console.log(selectedOption.dataset.value);
        getAllFilters();
    };

    // Add click event listener to dropdown button
    dropdownBtn.addEventListener("click", () => {
        toggleDropdown();
    });

    // Add click event listener to dropdown options
    dropdownOptions.forEach((option) => {
        option.addEventListener("click", () => {
            selectOption(option);
        });
    });

    // Add hover event listeners to dropdown options
    dropdownOptions.forEach((option) => {
        option.addEventListener("mouseover", () => {
            if (!option.classList.contains("selected")) {
                option.classList.add("hover");
            }
        });

        option.addEventListener("mouseout", () => {
            option.classList.remove("hover");
        });
    });

    // Add click event listener to document to close dropdown when clicked outside
    document.addEventListener("click", (event) => {
        const target = event.target;
        if (!dropdownWrapper.contains(target)) {
            dropdownMenu.classList.remove("open");
            dropdownBtn.classList.remove("open");
        }
    });

    // Set default selected option
});
