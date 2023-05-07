<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.wearly.controller.SessionManager" %>
<%@ page import="com.wearly.model.CartItem" %>
<%@ page import="java.util.List" %>
<%@ page import="com.wearly.model.CartDAO" %>
<%@ page import="com.wearly.model.Product" %>
<%@ page import="com.wearly.model.ProductDAO" %><%--
  Created by IntelliJ IDEA.
  User: sugam
  Date: 5/2/2023
  Time: 3:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if(SessionManager.isAlreadyLoggedIn(request)) {

        if (!SessionManager.isCustomer(request.getSession())) {
            response.sendRedirect(request.getContextPath()+ "/view/index.jsp");
            return;
        }
        List<CartItem> cartItems = new CartDAO().getCartItemsByCartId(SessionManager.getCartId(request.getSession()));
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalItems", cartItems.size());
    } else {
        response.sendRedirect(request.getContextPath() + "/view/index.jsp");
        return;
    }

%>
<html>
<head>
    <title>Your Cart</title>
    <c:import url="pageResources.jsp" />

    <link rel="stylesheet" href="../css/global.css" />
    <link rel="stylesheet" href="../css/styles.css" />
    <link rel="stylesheet" href="../css/effects.css" />
    <link rel="stylesheet" href="../css/cartPage.css" />
    <link rel="stylesheet" href="../css/searchPage.css" />
    <link rel="stylesheet" href="../css/singleProduct.css" />
    <link rel="stylesheet" href="../css/loginSignup.css" />


    <script defer src="../js/effects.js"></script>
<%--    <script defer src="../js/product-card-view.js"></script>--%>
    <script defer src="../js/formController.js"></script>
    <script defer src="../js/loader.js"></script>
    <script defer src="../js/popupHandler.js"></script>
    <script defer src="../js/effects.js"></script>
    <script defer src="../js/viewProductDetails.js"></script>
    <script defer src="../js/cartPage.js"></script>
    <script defer src="../js/orderProducts.js"></script>



    <c:if test="${userBean.isLoggedIn}">
        <script defer src="../js/profileDropdown.js"></script>
        <c:if test="${userBean.isAdmin}">
            <script defer src="../js/adminPanel.js"></script>
        </c:if>
    </c:if>
</head>
<body>

<c:import url="header.jsp" />
<dialog class="modal-popup" id="order-placement__success">
    <div class="popup-box">
        <div class="popup-content">
            <img src="../images/addProduct-success.svg" class="popup-image" />

            <div class="modal__text">
                <h2>Success <i class="fa-sharp fa-solid fa-badge-check"></i></h2>
                <p>
                    Your order has been placed successfully. You can check your order details in orders section.
                    😶‍🌫️
                </p>
            </div>
            <button class="btn btn--modal" type="button">OK</button>
        </div>
    </div>
</dialog>
<div id="overlay"></div>
<main class="container">
    <section class="cart-container">
        <div class="cart-items">
            <div class="cart-heading">
                <h1 class="cart-heading__title">Shopping Cart</h1>
                <p class="cart-items__subtitle"><span></span> Items</p>
            </div>

            <div class="cart-content">
                <section class="empty-cart-section">
                    <img src="../images/empty-cart.svg" alt="empty cart" class="empty-cart-img" />
                    <a href="../view/products.jsp" class="empty-cart-navigation">
                        <button class="btn btn--primary back-to-shopping">
                            <i class="fa-solid fa-cart-shopping-fast"></i>Continue Shopping
                        </button>
                    </a>
                </section>
                <div class="cart-heading__container">
                    <h2 class="cart-attribute__heading">Product Detail</h2>
                    <h2 class="cart-attribute__heading">Quantity</h2>
                    <h2 class="cart-attribute__heading">Price</h2>
                    <h2 class="cart-attribute__heading">Total</h2>
                </div>
                <div class="cart-items__container scroll--simple">
                    <c:forEach var="cartItem" items="${cartItems}">
                        <%
                        request.setAttribute("productDAO", new ProductDAO());
                        %>
                        <c:set var="product" value="${productDAO.getProductInfoById(cartItem.productId)}"/>
                        <div class="cart-item" data-id="${cartItem.cartItemId}">
                            <i class="fa-solid fa-times cart-item__remove single-item"></i>
                            <div class="cart-item__details">
                                <img
                                        src="../images/product-images/${product.image_name}"
                                        alt="product image"
                                        class="cart-item__img"
                                />
                                <div class="cart-item__details--text">
                                    <h3 class="cart-item__title underline-effect">${product.product_name}</h3>
                                    <div class="product-attribute">
                                        <i class="ph-fill ph-seal-check"></i>
                                        <span class="product-brand">${product.brand}</span>
                                    </div>
                                    <div class="product-size__inputs">
                                        <label class="size-option">
                                            <input
                                                    type="radio"
                                                    name="size-input-${cartItem.cartItemId}"
                                                    value="xl"
                                                    class="product-size-radio"
                                            />
                                            <span class="size-label">S</span>
                                        </label>
                                        <label class="size-option">
                                            <input
                                                    type="radio"
                                                    name="size-input-${cartItem.cartItemId}"
                                                    value="medium"
                                                    class="product-size-radio"
                                                    checked="checked"
                                            />
                                            <span class="size-label">M</span>
                                        </label>

                                        <label class="size-option">
                                            <input
                                                    type="radio"
                                                    name="size-input-${cartItem.cartItemId}"
                                                    value="large"
                                                    class="product-size-radio"
                                            />
                                            <span class="size-label">L</span>
                                        </label>

                                        <label class="size-option">
                                            <input
                                                    type="radio"
                                                    name="size-input-${cartItem.cartItemId}"
                                                    value="xl"
                                                    class="product-size-radio"
                                            />
                                            <span class="size-label">XL</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="cart-item__quantity">
                                <div class="quantity-input">
                                    <button class="quantity-btn minus">-</button>
                                    <input
                                            class="quantity-value"
                                            type="number"
                                            value="${cartItem.quantity}"
                                            min="1"
                                            max="${product.stock_quantity}"
                                            readonly
                                    />
                                    <button class="quantity-btn plus">+</button>
                                </div>
                                <span class="stock-quantity">(${product.stock_quantity} Left in Stock.)</span>
                            </div>

                            <div class="cart-item__price">
                                <p class="cart-item__price--text">Rs.</p>
                                <span class="cart-item__price--value">${product.price}</span>
                            </div>
                            <div class="cart-item__total-price">
                                <p class="cart-item__price--text">Rs.</p>
                                <span class="cart-item__total-price--value"></span>
                            </div>
                        </div>
                    </c:forEach>

                </div>

                <div class="cart-navigations">
                    <div class="remove-all__cart">
                        <i class="fa-solid fa-times cart-item__remove"></i>
                        <p class="remove-all__cart--text all-items underline-effect">
                            Remove All
                        </p>
                    </div>
                    <div class="cart-price__grandTotal">
                        <p class="underline-effect">Total Cost</p>
                        <p>
                            Rs. <span class="cart-item__totalPrice--value"></span>
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <div class="order-summary">
            <h1 class="order-summary__heading">Order Summary</h1>

            <div class="order-summary__content">
                <div class="summary-heading__container">
                    <h1 class="cart-attribute__heading">Delivery Information</h1>
                </div>
                <form action="" class="order-info__form">
                    <div class="product-name-field input-field-container">
                        <span class="error-message"></span>
                        <i class="fa-solid fa-location-dot input-field-icon"></i>

                        <input
                                type="text"
                                id="shipping-address"
                                name="shipping-address"
                                placeholder="Shipping Address"
                                class="input-field"
                        />
                    </div>
                    <div class="phone-field input-field-container">
                        <span class="error-message"></span>

                        <i class="input-field-icon fas fa-phone"></i>
                        <input
                                type="number"
                                id="phone"
                                name="phone"
                                placeholder="Phone Number"
                                class="input-field"
                        />
                    </div>
                    <div class="payment-method__form">
                        <label>
                            <input
                                    type="radio"
                                    name="radio-payment"
                                    value="cod"
                                    checked=""
                            />
                            <span>Cash On Delivery</span>
                        </label>
                        <label>
                            <input type="radio" name="radio-payment" value="fonepay" />
                            <span>fonePay</span>
                        </label>
                    </div>

                    <div class="order-placement">
                        <div class="price-details__final">
                            <div class="shipping-fee">
                                <p>Shipping Fee</p>
                                <p class="shipping-fee__value">Rs. 123</p>
                            </div>
                            <div class="grand-total__price">
                                <p>Grand Total</p>
                                <p>
                                    Rs. <span class="grand-total__price-value"></span>
                                </p>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary btn--order">
                            Place Order
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </section>
</main>
<dialog class="modal-popup" id="removeAll-modal">
    <div class="popup-box">
        <div class="popup-content">
            <img src="../images/removeAll-sure.svg" class="popup-image" />

            <div class="modal__text">
                <h2>Are you sure? 😕</h2>
                <p>
                    Deleted items from cannot be recovered. Are you sure you want to remove all items from your cart?
                </p>
            </div>
            <div class="modal__buttons">
                <button class="btn btn--modal btn--cancel" type="button">Cancel</button>
                <button class="btn btn--modal btn--confirm" type="button">Delete</button>
            </div>
        </div>
    </div>
</dialog>
<div id="overlay"></div>

<jsp:include page="footer.html"/>
</body>
</html>
