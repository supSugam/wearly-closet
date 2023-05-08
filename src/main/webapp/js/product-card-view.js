

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
const viewProductDetails = function (productId,productName) {
	window.location.href = `http://localhost:8080/wearly-ecommerce/view/product.jsp?id=${productId}&name=${productName}`;
}
const productCardInit = function () {
	cartQuantityHandler();
	const productStarsGenerator = function (productContainer) {

		const ratingContainer = productContainer.querySelector(".product-rating");
		if(!ratingContainer) return;
		const ratingValue = +ratingContainer.dataset.rating;
		ratingContainer.innerHTML = displayStarRating(ratingValue);
	}

	const productDetailsHandler = function (productCard) {

		if (+productCard.querySelector(".stock-quantity-value").textContent === 0) {
			productCard.querySelector(".btn--cart").disabled = true;
			productCard.querySelector(".quantity-input").querySelectorAll("*").forEach((el)=>{
				el.disabled=true;
				if(el.classList.contains("quantity-value")){
					el.value=0;
				}
			});
			productCard.querySelector(".btn--cart").classList.add("disabled");
			productCard.querySelector(".stock-quantity").textContent = "Out of stock";
			productCard.querySelector(".stock-quantity").style.color = "#dc2626";
		}
		productCard.querySelector(".btn--cart").addEventListener("click", (e) => {
			let btnCart;
			e.target.classList.contains("btn--cart") ? btnCart = e.target : btnCart = e.target.closest(".btn--cart");
			if(btnCart.disabled) return;
			if(productCard.classList.contains("product-container")){
				addItemToCart(btnCart,false)
			}
			if(productCard.classList.contains("product_card")){
				addItemToCart(btnCart);
			}
		});
		productCard.addEventListener("click", (e) => {
			if(e.target.classList.contains("product-title")){
				viewProductDetails(productCard.dataset.id, e.target.textContent);
			}
		});
	}
	const productContainer = document.querySelector(".product-container");
	if(productContainer){
		productStarsGenerator(productContainer);
		productDetailsHandler(productContainer);
	} else {
		document.querySelectorAll(".product_card").forEach((card) => {
			console.log("Product Card Init");
			productStarsGenerator(card);
			productDetailsHandler(card);
		});
	}


}
document.addEventListener("DOMContentLoaded", function () {
	productCardInit();
});





