

const btnOrder = document.querySelector(".btn--order");
const orderForm = document.querySelector(".order-info__form");

const placeOrder = function(billingAddress,phoneNumber,paymentMethod,totalPrice,btnOrder){

    const orderData = {
        billingAddress: billingAddress,
        phoneNumber: phoneNumber,
        totalPrice: totalPrice,
        paymentMethod: paymentMethod
    };

// Send the order data to the server
    fetch("http://localhost:8080/wearly-ecommerce/OrderServlet", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(orderData)
    }).then(response => {
        // Handle the response from the server
        if (response.status === 200) {
            console.log("Order placed successfully!");
            btnOrder.innerHTML = "Order Placed <i class='fas fa-check'></i>";
            btnOrder.disabled = true;
            openPopup(document.getElementById("order-placement__success"));
            orderForm.reset();
            document.querySelectorAll(".cart-item").forEach((cartItem) => {
                cartItem.remove();
            });
            initCartPage();

        } else {
            console.error("Failed to place order:", response.statusText);
            btnOrder.innerHTML = "Place Order";
        }
    }).catch(error => {
        console.error("Failed to place order:", error);
    });

};
const validateOrder = () => {
    const orderFormInputs = orderForm.querySelectorAll("input[type='text'], input[type='number']");
    let isValid = true;
    let selectedPaymentMethod = document.querySelector(".payment-method__form").querySelector("input[type='radio']:checked").value;

    btnOrder.disabled = true;
    const totalPrice = +document.querySelector(".grand-total__price-value").textContent
    let billingAddress;
    let phoneNumber;

    orderFormInputs.forEach((inputField) => {

        if(!inputField.value){
            isValid = false;
            showError(inputField, `${inputField.placeholder} is required.`);
        } else{
            if (inputField.type === "number") {
                if (inputField.value.length !== 10) {
                    isValid = false;
                    showError(inputField, "Must be 10 digits long!");

                }
                phoneNumber = inputField.value;
            }
            if(inputField.type === "text"){
                if(inputField.value.length < 15){
                    isValid = false;
                    showError(inputField, "Must be at least 15 characters long!");
                }
                billingAddress = inputField.value;
            }
        }
    });

    orderFormInputs.forEach((inputField) => {
        inputField.addEventListener("input", () => {
            removeError(inputField);
        });

        if (!inputField.value) {
            isValid = false;
            showError(inputField, `${inputField.placeholder} is required.`);
        }
    });

    if (!isValid) {
        btnOrder.disabled = false;
        return false;
    }


    btnOrder.innerHTML = "Placing Order <i class='fas fa-spinner fa-spin'></i>";

    placeOrder(billingAddress,phoneNumber,selectedPaymentMethod,totalPrice, btnOrder);

};

document.addEventListener("DOMContentLoaded", () => {
    btnOrder.addEventListener("click", validateOrder);
});
