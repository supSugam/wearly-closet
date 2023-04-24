"use strict";

const cartQuantityHandler = function () {
	const quantityInputs = document.querySelectorAll(".quantity-input");

	quantityInputs.forEach((input) => {
		const minusBtn = input.querySelector(".minus");
		const plusBtn = input.querySelector(".plus");
		const quantityValue = input.querySelector(".quantity-value");

		minusBtn.addEventListener("click", () => {
			if (quantityValue.value > parseInt(quantityValue.min)) {
				quantityValue.value = parseInt(quantityValue.value) - 1;
			}
		});

		plusBtn.addEventListener("click", () => {
			if (quantityValue.value < parseInt(quantityValue.max)) {
				quantityValue.value = parseInt(quantityValue.value) + 1;
			}
		});
	});
};

// Ratings Calculator

const displayStarRating = function (value) {
	const fullStar = '<i class="fa-solid fa-star"></i>';
	const halfStar = '<i class="fa-solid fa-star-half-stroke"></i>';
	const emptyStar = '<i class="fa-regular fa-star"></i>';

	const roundedValue = Math.round(value * 2) / 2; // round to nearest 0.5

	let starsHtml = "";
	for (let i = 0; i < Math.floor(roundedValue); i++) {
		starsHtml += fullStar;
	}
	if (roundedValue % 1 >= 0.5) {
		starsHtml += halfStar;
	}
	for (let i = Math.ceil(roundedValue); i < 5; i++) {
		starsHtml += emptyStar;
	}
	return starsHtml;
};

document.addEventListener("DOMContentLoaded", function () {
	cartQuantityHandler();

});

document.querySelectorAll(".product_card").forEach((card) => {
	const ratingContainer = card.querySelector(".product-rating");
	const ratingValue = +ratingContainer.dataset.rating;
	ratingContainer.innerHTML = displayStarRating(ratingValue);
});

