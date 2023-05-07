<%@ page import="com.wearly.model.Product" %>
<%@ page import="com.wearly.model.ProductDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.wearly.model.SearchDAO" %>
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
    String searchQuery = request.getParameter("searchQuery");
    if(searchQuery == null){
        searchQuery = "";
    }
    request.setAttribute("searchQuery", searchQuery);

    List<Product> matchingProducts = new SearchDAO().searchProducts(searchQuery);
    if(matchingProducts != null){
        request.setAttribute("matchingProducts", matchingProducts);
        request.setAttribute("totalResults", matchingProducts.size());

    }
%>
<html>
<head>
    <title>Products</title>
    <c:import url="pageResources.jsp" />

    <link rel="stylesheet" href="../css/global.css" />
    <link rel="stylesheet" href="../css/styles.css" />
    <link rel="stylesheet" href="../css/effects.css" />
    <link rel="stylesheet" href="../css/cartPage.css" />
    <link rel="stylesheet" href="../css/searchPage.css" />
    <link rel="stylesheet" href="../css/loginSignup.css" />

    <script defer src="../js/effects.js"></script>
    <script defer src="../js/formController.js"></script>
    <script defer src="../js/loader.js"></script>
    <script defer src="../js/addToCart.js"></script>
    <script defer src="../js/popupHandler.js"></script>
    <script defer src="../js/searchSortBy.js"></script>
    <script defer src="../js/searchFilters.js"></script>
    <script defer src="../js/searchForm.js"></script>
    <script defer src="../js/searchCategoryValidator.js"></script>
    <c:if test="${!userBean.isAdmin}">
        <script defer src="../js/product-card-view.js"></script>
    </c:if>
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

<main class="container section-search">
    <section class="section-related">
        <span class="small-heading">Related Categories</span>
        <div class="search-related-category">
            <div class="btn category-button">
                <span class="description-text">Men</span>
            </div>
            <div class="btn category-button">
                <span class="description-text">Women</span>
            </div>
            <div class="btn category-button">
                <span class="description-text">Kids</span>
            </div>
            <div class="btn category-button">
                <span class="description-text">Cosplay</span>
            </div>
            <div class="btn category-button">
                <span class="description-text">Formals</span>
            </div>
            <div class="btn category-button">
                <span class="description-text">Traditional</span>
            </div>
            <div class="btn category-button">
                <span class="description-text">Streetwear</span>
            </div>
            <div class="btn category-button">
                <span class="description-text">Sportswear</span>
            </div>
        </div>
    </section>

    <div class="search-container">
        <div class="search-section">
            <div class="search-filters grey-gradient">
                <div class="search-filter-header">
                    <i class="ph-fill ph-faders search-page-icons"></i>
                    <h1 class="search-heading-text">Filters</h1>
                    <button class="btn btn-search-reset">
                        <i class="fa-solid fa-rotate-left search-page-icons"></i>
                    </button>
                </div>
            </div>

            <div class="search-results grey-gradient">
                <div class="search-results-header">
                    <i
                            class="fa-regular fa-square-poll-horizontal search-page-icons"
                    ></i>
                    <h1 class="search-heading-text">
                        <c:if test="${empty searchQuery}">
                            All Products
                        </c:if>
                        <c:if test="${not empty searchQuery}">
                            <span>${matchingProducts.size()}</span> Search Results for "${searchQuery}"
                        </c:if>
                    </h1>
                </div>
                <div class="dropdown-wrapper">
                    <div class="sort-by">
                        <p class="search-heading-text">Sort By</p>
                    </div>
                    <button class="dropdown-btn">
                        <span class="selected-option">Relevance</span>
                        <i class="fa-solid fa-caret-down"></i>
                    </button>
                    <ul class="dropdown-menu-sortby">
                        <li class="dropdown-option selected" data-value="relevance">
                            <i class="fa-solid fa-bullseye-arrow"></i>Relevance
                        </li>

                        <li class="dropdown-option" data-value="priceHigh">
                            <i class="fa-solid fa-circle-dollar"></i>Price <i class="fa-solid fa-arrow-up"></i>
                        </li>
                        <li class="dropdown-option" data-value="priceLow">
                            <i class="fa-solid fa-circle-dollar"></i>Price <i class="fa-solid fa-arrow-down"></i>
                        </li>
                        <li class="dropdown-option" data-value="ratings">
                            <i class="fa-sharp fa-solid fa-face-smile"></i>Ratings
                        </li>
                    </ul>
                </div>
            </div>
            <div class="filter-options">
                <div class="price-field-wrapper">
                    <div class="filter-heading">
                        <h2>Price Range</h2>
                    </div>
                    <div class="price-input">
                        <div class="price-input-field">
                            <input
                                    readonly
                                    type="number"
                                    class="input-min quantity-input-price"
                                    value=""
                                    placeholder="Min"
                            />
                        </div>
                        <div class="separator">
                            <i class="fa-regular fa-hyphen"></i>
                        </div>
                        <div class="price-input-field">
                            <input
                                    readonly
                                    type="number"
                                    class="input-max quantity-input-price"
                                    value=""
                                    placeholder="Max"
                            />
                        </div>
                    </div>
                    <div class="price-slider">
                        <div class="progress"></div>
                    </div>
                    <div class="range-input">
                        <input
                                type="range"
                                class="range-min"
                                min="0"
                                max="10000"
                                value="0"
                                step="100"
                        />
                        <input
                                type="range"
                                class="range-max"
                                min="0"
                                max="10000"
                                value="10000"
                                step="100"
                        />
                    </div>
                    <p class="slider-info-text">Use Slider to Control the Price.</p>
                </div>

                <div class="category-wrapper">

    <ul class="category-list category-gender">
        <li class="open">
            <div class="category-title">
                <div>
                    <i class="fa-sharp fa-solid fa-person-half-dress"></i>
                    Gender
                </div>
            </div>
            <ul class="category-options show">
                <li class="category-option">
                    <input
                            type="checkbox"
                            id="checkBox-men"
                            name="checkBox-men"
                            class="terms-checkbox"
                            value="Men"
                    />
                    <label class="label-checkmark" for="checkBox-men">
                        <span class="checkmark"></span>
                        <p>Men</p>
                    </label>
                </li>
                <li class="category-option">
                    <input
                            type="checkbox"
                            id="checkBox-women"
                            name="checkBox-women"
                            class="terms-checkbox"
                            value="Women"
                    />
                    <label class="label-checkmark" for="checkBox-women">
                        <span class="checkmark"></span>
                        <p>Women</p>
                    </label>
                </li>
                <li class="category-option">
                    <input
                            type="checkbox"
                            id="checkBox-unisex"
                            name="checkBox-unisex"
                            class="terms-checkbox"
                            value="Unisex"
                    />
                    <label class="label-checkmark" for="checkBox-unisex">
                        <span class="checkmark"></span>
                        <p>Unisex</p>
                    </label>
                </li>
            </ul>
        </li>
    </ul>
                    <ul class="category-list category-brand">
                        <li class="open">
                            <div class="category-title">
                                <div>
                                    <i class="fa-solid fa-badge-check"></i>
                                    Brands
                                </div>
                            </div>
                            <ul class="category-options show">
                                <li class="category-option">
                                    <input
                                            type="checkbox"
                                            id="checkBox-nike"
                                            name="checkBox-nike"
                                            class="terms-checkbox"
                                            value="nike"
                                    />
                                    <label class="label-checkmark" for="checkBox-nike">
                                        <span class="checkmark"></span>
                                        <p>Nike</p>
                                    </label>
                                </li>
                                <li class="category-option">
                                    <input
                                            type="checkbox"
                                            id="checkBox-adidas"
                                            name="checkBox-adidas"
                                            class="terms-checkbox"
                                            value="adidas"
                                    />
                                    <label class="label-checkmark" for="checkBox-adidas">
                                        <span class="checkmark"></span>
                                        <p>Women</p>
                                    </label>
                                </li>
                                <li class="category-option">
                                    <input
                                            type="checkbox"
                                            id="checkBox-domestic"
                                            name="checkBox-domestic"
                                            class="terms-checkbox"
                                            value="Domestic"
                                    />
                                    <label class="label-checkmark" for="checkBox-domestic">
                                        <span class="checkmark"></span>
                                        <p>Domestic</p>
                                    </label>
                                </li>
                            </ul>
                        </li>
                    </ul>
    <ul class="category-list category-category">
        <li class="open">
            <div class="category-title">
                <div>
                    <i class="fa-solid fa-tags"></i>
                    Category
                </div>
            </div>
            <ul class="category-options show">
                <li class="category-option">
                    <input
                            type="checkbox"
                            id="checkBox-tops"
                            name="checkBox-tops"
                            class="terms-checkbox"
                            value="tops"
                    />
                    <label class="label-checkmark" for="checkBox-tops">
                        <span class="checkmark"></span>
                        <p>Tops</p>
                    </label>
                </li>
                <li class="category-option">
                    <input
                            type="checkbox"
                            id="checkBox-pants"
                            name="checkBox-pants"
                            class="terms-checkbox"
                            value="pants"
                    />
                    <label class="label-checkmark" for="checkBox-pants">
                        <span class="checkmark"></span>
                        <p>Pants</p>
                    </label>
                </li>
                <li class="category-option">
                    <input
                            type="checkbox"
                            id="checkBox-formalwear"
                            name="checkBox-formalwear"
                            class="terms-checkbox"
                            value="formalwear"
                    />
                    <label
                            class="label-checkmark"
                            for="checkBox-formalwear"
                    >
                        <span class="checkmark"></span>
                        <p>Formalwear</p>
                    </label>
                </li>
                <li class="category-option">
                    <input
                            type="checkbox"
                            id="checkBox-sportswear"
                            name="check"
                            class="terms-checkbox"
                            value="Sportswear"
                            required
                    />
                    <label
                            class="label-checkmark"
                            for="checkBox-sportswear"
                    >
                        <span class="checkmark"></span>
                        <p>Sportswear</p>
                    </label>
                </li>
                <li class="category-option">
                    <input
                            type="checkbox"
                            id="checkBox-accessories"
                            name="checkBox-accessories"
                            class="terms-checkbox"
                            value="accessories"
                    />
                    <label
                            class="label-checkmark"
                            for="checkBox-accessories"
                    >
                        <span class="checkmark"></span>
                        <p>Accessories</p>
                    </label>
                </li>
                <li class="category-option">
                    <input
                            type="checkbox"
                            id="checkBox-traditional"
                            name="checkBox-traditional"
                            class="terms-checkbox"
                            value="traditional"
                    />
                    <label
                            class="label-checkmark"
                            for="checkBox-traditional"
                    >
                        <span class="checkmark"></span>
                        <p>Traditional</p>
                    </label>
                </li>
                <li class="category-option">
                    <input
                            type="checkbox"
                            id="checkBox-streetwear"
                            name="checkBox-streetwear"
                            class="terms-checkbox"
                            value="streetwear"
                    />
                    <label
                            class="label-checkmark"
                            for="checkBox-streetwear"
                    >
                        <span class="checkmark"></span>
                        <p>Streetwear</p>
                    </label>
                </li>
                <li class="category-option">
                    <input
                            type="checkbox"
                            id="checkBox-footwear"
                            name="checkBox-footwear"
                            class="terms-checkbox"
                            value="footwear"
                    />
                    <label class="label-checkmark" for="checkBox-footwear">
                        <span class="checkmark"></span>
                        <p>Footwear</p>
                    </label>
                </li>
                <li class="category-option">
                    <input
                            type="checkbox"
                            id="checkBox-sleepwear"
                            name="checkBox-sleepwear"
                            class="terms-checkbox"
                            value="sleepwear"
                    />
                    <label
                            class="label-checkmark"
                            for="checkBox-sleepwear"
                    >
                        <span class="checkmark"></span>
                        <p>Sleepwear</p>
                    </label>
                </li>
                <li class="category-option">
                    <input
                            type="checkbox"
                            id="checkBox-winter"
                            name="checkBox-winter"
                            class="terms-checkbox"
                            value="Coats and Jackets"
                    />
                    <label class="label-checkmark" for="checkBox-winter">
                        <span class="checkmark"></span>
                        <p>Coats and Jackets</p>
                    </label>
                </li>
                <li class="category-option">
                    <input
                            type="checkbox"
                            id="checkBox-casual"
                            name="checkBox-casual"
                            class="terms-checkbox"
                            value="casual"
                    />
                    <label class="label-checkmark" for="checkBox-casual">
                        <span class="checkmark"></span>
                        <p>Casual Wear</p>
                    </label>
                </li>
            </ul>
        </li>
    </ul>
                </div>
            </div>

            <div class="search-results-content scroll--simple">
                <c:if test="${totalResults==0}">
                    <div class="no-results-image">
                        <img src="../images/no-search-results.svg" alt="empty search" class="empty-search" />
                        <a href="../view/products.jsp" class="empty-cart-navigation">
                            <button class="btn btn--primary back-to-shopping">
                                <i class="fa-solid fa-cart-shopping-fast"></i>Continue Shopping
                            </button>
                        </a>
                    </div>
                </c:if>
                <c:if test="${totalResults>0}">
                    <div class="no-results-image hidden">
                        <img src="../images/no-search-results.svg" alt="empty search" class="empty-search" />
                        <a href="../view/products.jsp" class="empty-cart-navigation">
                            <button class="btn btn--primary back-to-shopping">
                                <i class="fa-solid fa-cart-shopping-fast"></i>Continue Shopping
                            </button>
                        </a>
                    </div>
                </c:if>



                <div class="loader-animated hidden">
                </div>
                <c:forEach var="product" items="${matchingProducts}">
                    <div data-id="${product.product_id}" class="product_card" >
                        <div class="product_card--image">
                            <img
                                    src="../images/product-images/${product.image_name}"
                                    class="product-img"
                                    alt="${product.product_name}"
                            />
                        </div>

                        <div class="product_card--content">
                            <div class="portrait-container">
                                <div class="portrait"></div>
                                <p class="price-currency">
                                    Rs.
                                    <span class="product-price">${product.price}</span>
                                </p>
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
                        </div>
                    </div>
                </c:forEach>

            </div>
        </div>
    </div>
</main>




<c:import url="footer.html" />
</body>
</html>
