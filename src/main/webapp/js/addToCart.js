
const addItemToCart = function (btnCart,fromCard=true){
    const btnContent = btnCart.innerHTML;
        btnCart.innerHTML = `<i class="fa-solid fa-spinner-third fa-spin"></i>`;
        let productCard;
        if(fromCard){
         productCard = btnCart.closest(".product_card")
        } else{
         productCard = btnCart.closest(".product-container")
        }
        const productId = +productCard.dataset.id;
        const quantity = +productCard.querySelector(".quantity-value").value;


        fetch('http://localhost:8080/wearly-ecommerce/AddToCartServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                productId: productId,
                quantity: quantity
            })
        }).then(response => {
                if (response.status === 200) {
                    btnCart.innerHTML = `Added <i class="fa-solid fa-check"></i>`;
                    btnCart.disabled = true;
                    btnCart.classList.add("disabled");
                    return response.text();
                }
                if(response.status === 401){
                    openPopup(document.getElementById("login-modal"));
                    btnCart.innerHTML = btnContent;
                }
            }).then(data => {
                productCard.querySelector(".stock-quantity-value").textContent = +data;
        })
            .catch(error => {
                console.error('There was a problem with the fetch operation:', error);
            });

}