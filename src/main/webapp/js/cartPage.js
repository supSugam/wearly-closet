const cartItemsContainer = document.querySelector(".cart-items");
let totalItemsSpan;


const cartQuantityHandler = function () {
    cartItemsContainer.addEventListener("click", (event) => {
        const target = event.target;
        const cartItem = target.closest(".cart-item");
        if (cartItem) {
            quantityHandler(cartItem, target);
        }
    });
};
const quantityHandler = function (cartItem, target){
    const quantityInput = cartItem.querySelector(".quantity-value");
    if (target.classList.contains("minus")) {
        if (quantityInput.value > parseInt(quantityInput.min)) {
            quantityInput.value = parseInt(quantityInput.value) - 1;
            totalItemsSpan.textContent = +totalItemsSpan.textContent - 1;
        }
    } else if (target.classList.contains("plus")) {
        if (quantityInput.value < parseInt(quantityInput.max)) {
            quantityInput.value = parseInt(quantityInput.value) + 1;
            totalItemsSpan.textContent = +totalItemsSpan.textContent + 1;
        }
    }
    refreshCartPage(cartItem);
}
const emptyCartPage = function () {
    const cartItemsQuantity = document.querySelectorAll(".cart-item").length;
    if (cartItemsQuantity === 0) {
        totalItemsSpan.textContent = cartItemsQuantity;
        const cartContent = document.querySelector(".cart-content");
        document.querySelector(".cart-items__container").style.overflowY = "hidden";
        cartContent.classList.add("empty-cart");

        cartContent.querySelectorAll("div").forEach((div) => {
            div.style.display = "none";
        })
        document.querySelector(".order-summary").classList.add("empty-cart-summary")

    }
}
const refreshCartPage = function (cartItem) {
    const quantityInput = cartItem.querySelector(".quantity-value");
    const totalPrice = cartItem.querySelector(
        ".cart-item__total-price--value"
    );
    const price = +cartItem.querySelector(".cart-item__price--value")
        .textContent;
    cartPriceHandler(quantityInput, totalPrice, price);
    emptyCartPage();
};



const cartPriceHandler = function (quantityInput, totalPrice, price) {
    const quantity = +quantityInput.value;
    totalPrice.textContent = quantity * price;
    const allItemsTotalPrice = Array.from(
        document.querySelectorAll(".cart-item .cart-item__total-price--value")
    );

    const grandTotalPrice = +allItemsTotalPrice.reduce(
        (acc, cur) => acc + +cur.textContent,
        0
    );
    document.querySelector(".cart-item__totalPrice--value").textContent =
        grandTotalPrice+"";

    document.querySelector(".grand-total__price-value").textContent =
        (grandTotalPrice + 123)+"";
};


const deleteCartItem = function (cartItem, deleteAll = false) {
    const cartItemId = +cartItem.dataset.id;
    fetch('http://localhost:8080/wearly-ecommerce/DeleteCartItem', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            cartItemId: cartItemId
        })
    }).then(response => {
            if (response.status === 204) {
                // Handle successful response
                console.log('Item removed successfully');
                cartItem.remove();
                refreshCartPage(cartItem);
            } else {
                // Handle error response
                console.error('Error removing item');
                console.log(response.status)
            }
        })
        .catch(error => {
            // Handle network error
            console.error('Network error:', error);
        });


}
const removeAllCartItems = function (btnConfirm) {
    btnConfirm.innerHTML = `<i class="fa-solid fa-spinner-third fa-spin"></i>`;
    document.querySelectorAll(".cart-item").forEach((cartItem) => {
        deleteCartItem(cartItem);
    });
    btnConfirm.innerHTML = `<i class="fa-solid fa-check"></i>`;
    setTimeout(() => {
        closePopup(document.getElementById("removeAll-modal"));
    }, 1000);

};

const initCartPage = function () {
    totalItemsSpan = document.querySelector(".cart-items__subtitle span");

    cartQuantityHandler();
    emptyCartPage();

    const quantityInputs = document.querySelectorAll(
        ".cart-item__quantity .quantity-input"
    );
    let totalItems=0;
    quantityInputs.forEach((inputBtn) => {
        const quantityValue = inputBtn.querySelector(".quantity-value");
        const totalPrice = inputBtn
            .closest(".cart-item")
            .querySelector(".cart-item__total-price--value");
        const price = +inputBtn
            .closest(".cart-item")
            .querySelector(".cart-item__price--value").textContent;


        cartPriceHandler(quantityValue, totalPrice, price);
        totalItems+= parseInt(quantityValue.value);
    });
    totalItemsSpan.textContent += totalItems;


    document.querySelectorAll(".cart-item").forEach((cartItem) => {
        cartItem.querySelector(".cart-item__remove").addEventListener("click", () => {
            deleteCartItem(cartItem);
        });
    })

    document.querySelector(".modal__buttons").addEventListener("click", (e) => {
        const target = e.target;
        if(target.classList.contains("btn--cancel")) closePopup();
        if (target.classList.contains("btn--confirm")) removeAllCartItems(target);
    });

    document.querySelector(".remove-all__cart").addEventListener("click", () => {
        openPopup(document.getElementById("removeAll-modal"));
    });


};



document.addEventListener("DOMContentLoaded", () => {
   initCartPage()
});
