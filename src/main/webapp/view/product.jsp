<%@ page import="com.wearly.model.Product" %>
<%@ page import="com.wearly.model.ProductDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: sugam
  Date: 5/5/2023
  Time: 3:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    try {
    int productId = Integer.parseInt(request.getParameter("id"));
    Product product = new ProductDAO().getProductInfoById(productId);


    if(product != null){
        request.setAttribute("product", product);
    } else{
        response.sendRedirect(request.getContextPath() + "/view/error.jsp");
    }
        } catch (Exception e) {
        response.sendRedirect(request.getContextPath() + "/view/error.jsp");
    }
//    // Get the product object from the request
//    Product product = (Product) request.getAttribute("product");
//    request.setAttribute("product", product);
%>
<html>
<head>
    <title>${product.product_name}</title>
    <c:import url="pageResources.jsp" />

    <link rel="stylesheet" href="../css/global.css" />
    <link rel="stylesheet" href="../css/styles.css" />
    <link rel="stylesheet" href="../css/effects.css" />
    <link rel="stylesheet" href="../css/cartPage.css" />
    <link rel="stylesheet" href="../css/searchPage.css" />
    <link rel="stylesheet" href="../css/singleProduct.css" />
    <link rel="stylesheet" href="../css/loginSignup.css" />

    <script defer src="../js/effects.js"></script>
    <script defer src="../js/product-card-view.js"></script>
    <script defer src="../js/formController.js"></script>
    <script defer src="../js/loader.js"></script>
    <script defer src="../js/addToCart.js"></script>
    <script defer src="../js/popupHandler.js"></script>
    <c:if test="${userBean.isLoggedIn}">
        <script defer src="../js/profileDropdown.js"></script>
        <c:if test="${userBean.isAdmin}">
            <script defer src="../js/adminPanel.js"></script>
        </c:if>
    </c:if>
</head>
<body>
<c:import url="header.jsp" />
<div id="overlay"></div>
<dialog class="modal-popup" id="login-modal">
    <button class="btn btn--close" type="button">
        <i class="fa-solid fa-times"></i>
    </button>
    <div class="popup-box">
        <div class="popup-content">
            <h2 class="popup-heading">Login to Continue<br />🙂</h2>
            <div class="form-container">
                <form
                        class="login-form"
                        action=""
                        method="post"
                        onsubmit="return validateLoginForm()"
                        novalidate=""
                >
                    <div class="email-field input-field-container">
                        <span class="error-message">This field cannot be empty</span>
                        <i
                                class="fa-solid fa-envelope input-field-icon login-email"
                        ></i>
                        <input
                                type="email"
                                name="email"
                                placeholder="Email"
                                required=""
                                class="input-field"
                        />
                    </div>

                    <div class="password-field input-field-container">
                        <span class="error-message">This field cannot be empty</span>
                        <i class="fa-solid fa-key input-field-icon login-pass"></i>
                        <input
                                type="password"
                                name="password"
                                placeholder="Password"
                                required=""
                                class="input-field"
                        />
                    </div>

                    <div class="exp">
                        <div class="checkbox">
                            <div>
                                <input
                                        type="checkbox"
                                        id="check"
                                        name="check"
                                        class="terms-checkbox"
                                        value=""
                                />
                                <label class="label-checkmark" for="check">
                                    <span class="checkmark"></span>
                                    <p>Remember Me</p>
                                </label>
                            </div>
                        </div>
                    </div>

                    <button
                            type="submit"
                            class="btn btn-primary btn-login submit-button"
                    >
                        Login
                    </button>
                </form>
                <div class="redirect-text to-signup">
                    <p>Don't have an account?</p>
                    <a class="redirect-sign-up" href="register.jsp">Sign Up</a>
                </div>
            </div>
        </div>
    </div>
</dialog>

<main class="container">
    <section class="product-container" data-id="${product.product_id}">
        <div class="product-image-half">
            <img
                    src="../images/product-images/${product.image_name}"
                    alt="Product Image"
                    class="single-product-image"
            />
        </div>
        <div class="product-content-half grey-gradient">
            <div class="fish-aquarium">
                <img
                        src="../images/fishy-blob.svg"
                        alt="just a shape"
                        class="fishy-blob"
                />
                <div class="side-icons">
                    <i class="ph-fill ph-heart-straight"></i>
                    <i class="ph-fill ph-share-network"></i>
                </div>
            </div>
            <div class="product__infoUpper">
                <li class="product-tags">
                    <span class="tag-content product-type">${product.category_name}</span>
                    <span class="tag-content product-type">${product.gender}</span>
                </li>
                <div class="product-attribute">
                    <i class="ph-fill ph-seal-check"></i>
                    <span class="product-brand">${product.brand}</span>
                </div>
                <h1 class="product-title__single">${product.product_name}</h1>
                <li class="product-attribute">
                    <p>Ratings</p>
                    <div data-rating="${product.rating}" class="attribute-boxes product-rating"></div>
                    (${product.rating})
                </li>
                <p class="product-price__single">Rs. <span>${product.price}</span></p>

                <div class="product-size__single">
                    <p>Available Sizes</p>
                    <div class="product-size__inputs">
                        <label class="size-option">
                            <input
                                    type="radio"
                                    name="radio"
                                    value="medium"
                                    class="product-size-radio"
                                    checked="checked"
                            />
                            <span class="size-label">Medium</span>
                        </label>

                        <label class="size-option">
                            <input
                                    type="radio"
                                    name="radio"
                                    value="large"
                                    class="product-size-radio"
                            />
                            <span class="size-label">Large</span>
                        </label>

                        <label class="size-option">
                            <input
                                    type="radio"
                                    name="radio"
                                    value="xl"
                                    class="product-size-radio"
                            />
                            <span class="size-label">Extra Large</span>
                        </label>
                    </div>
                </div>
            </div>

            <p class="stock-quantity">
                <span class="stock-quantity-value">${product.stock_quantity}</span> Left in Stock.
            </p>
            <div class="add-to-cart__single">
                <c:choose>
                    <c:when test="${userBean.isLoggedIn && userBean.isAdmin}">
                        <button data-id="${product.product_id}" class="btn btn-action btn--editProduct">Edit</button>
                        <button data-id="${product.product_id}" class="btn btn-action btn--deleteProduct">Delete</button>
                    </c:when>
                    <c:otherwise>
                        <div class="quantity-input">
                            <button class="quantity-btn minus">-</button>
                            <input
                                    class="quantity-value"
                                    type="number"
                                    value="1"
                                    min="1"
                                    max="${product.stock_quantity}"
                                    readonly
                            />
                            <button class="quantity-btn plus">+</button>
                        </div>

                        <button type="button" class="btn btn--cart">
                            Add to Cart <i class="ph-fill ph-shopping-cart"></i>
                        </button>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="product-description__single">
                <p class="desc-title">Product Description</p>
                <ul class="description__points">
                        <c:forEach var="description" items="${fn:split(product.description, '||')}">
                            <li><i class="fa-regular fa-clothes-hanger"></i>${description}</li>
                        </c:forEach>
                </ul>
            </div>
        </div>
    </section>
</main>


<c:import url="footer.html" />
</body>
</html>
