<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.wearly.controller.SessionManager" %>
<%@ page import="com.wearly.model.Product" %>
<%@ page import="com.wearly.model.ProductDAO" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: sugam
  Date: 4/18/2023
  Time: 6:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if(SessionManager.isAlreadyLoggedIn(request)) {

        if (!SessionManager.isAdmin(request.getSession())) {
            response.sendRedirect(request.getContextPath()+ "/view/index.jsp");
            return;
        }
    } else {
        response.sendRedirect(request.getContextPath() + "/view/index.jsp");
        return;
    }
    List<Product> productList = new ProductDAO().getProductsList();
    request.setAttribute("productList", productList);
%>
<html>
<head>
    <title>wearly - Admin Panel</title>
    <c:import url="pageResources.jsp" />

    <link rel="stylesheet" href="../css/global.css" />
    <link rel="stylesheet" href="../css/styles.css" />
    <link rel="stylesheet" href="../css/effects.css" />
    <link rel="stylesheet" href="../css/searchPage.css" />
    <link rel="stylesheet" href="../css/loginSignup.css" />
    <link rel="stylesheet" href="../css/adminPanel.css" />

    <script defer src="../js/imageView.js"></script>
    <script defer src="../js/popupHandler.js"></script>
    <script defer src="../js/formController.js"></script>
    <script defer src="../js/adminPanel.js"></script>

    <script defer src="../js/productCheckBoxValidator.js"></script>
    <script defer src="../js/textArea.js"></script>
</head>
<body>
<c:import url="header.jsp" />

<dialog class="modal-popup" id="add-product__success">
    <div class="popup-box">
        <div class="popup-content">
            <img src="../images/addProduct-success.svg" class="popup-image" />

            <div class="modal__text">
                <h2>Success <i class="fa-sharp fa-solid fa-badge-check"></i></h2>
                <p>
                    Your products are now securely stored in wearly's cloud wardrobe
                    😶‍🌫️
                </p>
            </div>
            <button class="btn btn--modal" type="button">OK</button>
        </div>
    </div>
</dialog>

<dialog class="modal-popup" id="edit-product__success">
    <div class="popup-box">
        <div class="popup-content">
            <img src="../images/addProduct-success.svg" class="popup-image" />

            <div class="modal__text">
                <h2>Success <i class="fa-sharp fa-solid fa-badge-check"></i></h2>
                <p>
                    The changes in your product are now securely stored in wearly's cloud wardrobe
                    😶‍🌫️
                </p>
            </div>
            <button class="btn btn--modal" type="button">OK</button>
        </div>
    </div>
</dialog>
<div id="overlay"></div>
<main class="container section-admin">
    <section class="admin-panel-container">
        <div class="section-admin-panel">
            <div class="tools-sidebar grey-gradient">
                <div class="admin-sidebar-header">
                    <i class="fa-solid fa-screwdriver-wrench admin-page-icons"></i>
                    <h1 class="admin-sidebar-header-text">Operations</h1>
                    <!-- <button class="btn btn-search-reset">
                        <i class="fa-solid fa-bars admin-page-icons"></i>
                    </button> -->
                </div>
            </div>

            <div class="admin-dashboard grey-gradient">
                <div class="admin-dashboard-header">
                    <i
                            class="fa-regular fa-square-poll-horizontal admin-page-icons"
                    ></i>
                    <h1 class="admin-dashboard-header-text">Admin Dashboard</h1>
                </div>
            </div>

            <div class="panel-wrapper">
                <ul class="options-list">
                    <li class="open">
                        <div class="option-title">
                            <div>
                                <i class="fa-solid fa-shirt"></i>
                                Products
                            </div>
                            <i class="fa fa-caret-down"></i>
                        </div>
                        <ul class="option-breakdown">
                            <li
                                    class="option-for product-data"
                                    data-viewpage="view-products"
                            >
                                <p class="navigate-option">View Products</p>
                            </li>
                            <li
                                    class="option-for edit-product"
                                    data-viewPage="add-product"
                            >
                                <p class="navigate-option">Add Products</p>
                            </li>
                            <li
                                    class="option-for top-products"
                                    data-viewPage="top-products"
                            >
                                <p class="navigate-option">Top Products</p>
                            </li>
                            <li
                                    class="option-for new-products"
                                    data-viewPage="new-products"
                            >
                                <p class="navigate-option">New Products</p>
                            </li>
                        </ul>
                    </li>
                    <li class="open">
                        <div class="option-title">
                            <div>
                                <i class="fa-solid fa-users"></i>
                                Customers
                            </div>
                            <i class="fa fa-caret-down"></i>
                        </div>
                        <ul class="option-breakdown">
                            <li
                                    class="option-for customer-data"
                                    data-viewPage="view-customers"
                            >
                                <p class="navigate-option">View Customers</p>
                            </li>
                            <li
                                    class="option-for customer-orders"
                                    data-viewPage="view-orders"
                            >
                                <p class="navigate-option">Customer's Orders</p>
                            </li>
                            <li
                                    class="option-for top-customers"
                                    data-viewPage="top-customers"
                            >
                                <p class="navigate-option">Top Customers</p>
                            </li>
                            <li
                                    class="option-for new-customers"
                                    data-viewPage="new-customers"
                            >
                                <p class="navigate-option">New Customers</p>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>

            <div class="admin-tools-container">
                <div class="loader-animated">
                </div>
                <form
                        action=""
                        method="POST"
                        class="add-product-form"
                        name="product-form"
                        onsubmit=" return validateAddProductForm()"
                        novalidate
                >
                    <div class="product-form-body">
                        <div class="product-name-field input-field-container">
                            <span class="error-message">This field cannot be empty</span>
                            <i class="fa-solid fa-bags-shopping input-field-icon"></i>
                            <input
                                    type="text"
                                    id="product-name"
                                    name="product-name"
                                    placeholder="Product Name"
                                    required
                                    class="input-field"
                            />
                        </div>
                        <div class="product-brand-field input-field-container">
                            <span class="error-message">This field cannot be empty</span>
                            <i class="fa-solid fa-badge-check input-field-icon"></i>
                            <input
                                    type="text"
                                    id="product-brand"
                                    name="product-brand"
                                    placeholder="Product Brand"
                                    required
                                    class="input-field"
                            />
                        </div>
                        <div class="product-price-field input-field-container">
                            <span class="error-message">This field cannot be empty</span>
                            <i class="fa-solid fa-dollar-sign input-field-icon"></i>
                            <input
                                    type="number"
                                    id="product-price"
                                    name="product-price"
                                    placeholder="Product Price (NPR)"
                                    required
                                    class="input-field"
                            />
                        </div>
                        <div class="product-quantity-field input-field-container">
                            <span class="error-message">This field cannot be empty</span>
                            <i class="fa-solid fa-boxes input-field-icon"></i>
                            <input
                                    type="number"
                                    id="product-quantity"
                                    name="product-quantity"
                                    placeholder="Product Quantity"
                                    required
                                    class="input-field"
                            />
                            <div class="input-spinner">
                                <button id="ispin-up">
                                    <i class="fa-solid fa-caret-up"></i>
                                </button>
                                <button id="ispin-down">
                                    <i class="fa-solid fa-caret-down"></i>
                                </button>
                            </div>
                        </div>

                        <div class="product-category-field input-field-container">
									<span class="error-message"
                                    >Select One Gender & One Category !</span
                                    >
                            <ul class="category-list category-gender">
                                <li class="open">
                                    <div class="category-title">
                                        <div>
                                            <i class="fa-solid fa-tags"></i>
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
                                                    checked="checked"
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
                                                    checked="checked"
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
                        <div class="product-info-container">
                            <div class="product-description-field input-field-container">
										<span class="error-message"
                                        >This field cannot be empty</span
                                        >
                                <i class="fa-solid fa-pen-to-square input-field-icon"></i>
                                <textarea
                                        type="text"
                                        id="product-description"
                                        name="product-description"
                                        placeholder="Product Description"
                                        required
                                        class="input-field product-description"
                                        rows="6"
                                        maxlength="200"
                                ></textarea>

                                <div class="bullet-points">
                                    <i class="fa-solid fa-hand-point-right"></i>
                                    <i class="fa-solid fa-hand-point-right"></i>
                                    <i class="fa-solid fa-hand-point-right"></i>
                                    <i class="fa-solid fa-hand-point-right"></i>
                                    <i class="fa-solid fa-hand-point-right"></i>
                                    <i class="fa-solid fa-hand-point-right"></i>
                                </div>
                            </div>
                            <div class="product-upload-container">
                                <div class="product-upload input-field-container">
                                    <div class="upload-title-container">
                                        <h1 class="upload-title">Upload Product Image</h1>
                                    </div>
                                    <div class="product-edit">
                                        <input
                                                type="file"
                                                id="productUpload"
                                                accept="image/*"
                                                required
                                        />
                                        <label for="productUpload"></label>
                                    </div>

                                    <div class="product-preview">
                                        <div
                                                id="imagePreview"
                                                class="default-avatar"
                                                style="background-image: url(../images/upload-image.gif)"
                                        ></div>
                                    </div>
                                    <p class="upload-instruction-text">
                                        Upload Instruction: Image File Less than 2 MB
                                    </p>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary btn-addProduct">
                                Save Product
                            </button>
                        </div>
                    </div>
                </form>


                <form
                        action=""
                        method="POST"
                        class="edit-product-form"
                        name="edit-product-form"
                        onsubmit=" return validateAddProductForm('EditProductServlet')"
                        novalidate
                >
                    <div class="product-form-body">
                        <div class="product-name-field input-field-container">
                            <span class="error-message">This field cannot be empty</span>
                            <i class="fa-solid fa-bags-shopping input-field-icon"></i>
                            <input
                                    type="text"
                                    id="product-name__edit"
                                    name="product-name"
                                    placeholder="Product Name"
                                    required
                                    class="input-field"
                            />
                        </div>
                        <div class="product-brand-field input-field-container">
                            <span class="error-message">This field cannot be empty</span>
                            <i class="fa-solid fa-badge-check input-field-icon"></i>
                            <input
                                    type="text"
                                    id="product-brand__edit"
                                    name="product-brand"
                                    placeholder="Product Brand"
                                    required
                                    class="input-field"
                            />
                        </div>
                        <div class="product-price-field input-field-container">
                            <span class="error-message">This field cannot be empty</span>
                            <i class="fa-solid fa-dollar-sign input-field-icon"></i>
                            <input
                                    type="number"
                                    id="product-price__edit"
                                    name="product-price"
                                    placeholder="Product Price (NPR)"
                                    required
                                    class="input-field"
                            />
                        </div>
                        <div class="product-quantity-field input-field-container">
                            <span class="error-message">This field cannot be empty</span>
                            <i class="fa-solid fa-boxes input-field-icon"></i>
                            <input
                                    type="number"
                                    id="product-quantity__edit"
                                    name="product-quantity"
                                    placeholder="Product Quantity"
                                    required
                                    class="input-field"
                            />
                            <div class="input-spinner">
                                <button id="ispin-up__edit">
                                    <i class="fa-solid fa-caret-up"></i>
                                </button>
                                <button id="ispin-down__edit">
                                    <i class="fa-solid fa-caret-down"></i>
                                </button>
                            </div>
                        </div>

                        <div class="product-category-field input-field-container">
									<span class="error-message"
                                    >Select One Gender & One Category !</span
                                    >
                            <ul class="category-list category-gender">
                                <li class="open">
                                    <div class="category-title">
                                        <div>
                                            <i class="fa-solid fa-tags"></i>
                                            Gender
                                        </div>
                                    </div>
                                    <ul class="category-options show">
                                        <li class="category-option">
                                            <input
                                                    type="checkbox"
                                                    id="checkBox-men__edit"
                                                    name="checkBox-men"
                                                    class="terms-checkbox"
                                                    value="Men"
                                            />
                                            <label class="label-checkmark" for="checkBox-men__edit">
                                                <span class="checkmark"></span>
                                                <p>Men</p>
                                            </label>
                                        </li>
                                        <li class="category-option">
                                            <input
                                                    type="checkbox"
                                                    id="checkBox-women__edit"
                                                    name="checkBox-women"
                                                    class="terms-checkbox"
                                                    value="Women"
                                            />
                                            <label class="label-checkmark" for="checkBox-women__edit">
                                                <span class="checkmark"></span>
                                                <p>Women</p>
                                            </label>
                                        </li>
                                        <li class="category-option">
                                            <input
                                                    type="checkbox"
                                                    id="checkBox-unisex__edit"
                                                    name="checkBox-unisex"
                                                    class="terms-checkbox"
                                                    checked="checked"
                                                    value="Unisex"
                                            />
                                            <label class="label-checkmark" for="checkBox-unisex__edit">
                                                <span class="checkmark"></span>
                                                <p>Unisex</p>
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
                                                    id="checkBox-tops__edit"
                                                    name="checkBox-tops"
                                                    class="terms-checkbox"
                                                    value="tops"
                                            />
                                            <label class="label-checkmark" for="checkBox-tops__edit">
                                                <span class="checkmark"></span>
                                                <p>Tops</p>
                                            </label>
                                        </li>
                                        <li class="category-option">
                                            <input
                                                    type="checkbox"
                                                    id="checkBox-pants__edit"
                                                    name="checkBox-pants"
                                                    class="terms-checkbox"
                                                    value="pants"
                                            />
                                            <label class="label-checkmark" for="checkBox-pants__edit">
                                                <span class="checkmark"></span>
                                                <p>Pants</p>
                                            </label>
                                        </li>
                                        <li class="category-option">
                                            <input
                                                    type="checkbox"
                                                    id="checkBox-formalwear__edit"
                                                    name="checkBox-formalwear"
                                                    class="terms-checkbox"
                                                    value="formalwear"
                                            />
                                            <label
                                                    class="label-checkmark"
                                                    for="checkBox-formalwear__edit"
                                            >
                                                <span class="checkmark"></span>
                                                <p>Formalwear</p>
                                            </label>
                                        </li>
                                        <li class="category-option">
                                            <input
                                                    type="checkbox"
                                                    id="checkBox-sportswear__edit"
                                                    name="check"
                                                    class="terms-checkbox"
                                                    value="Sportswear"
                                                    required
                                            />
                                            <label
                                                    class="label-checkmark"
                                                    for="checkBox-sportswear__edit"
                                            >
                                                <span class="checkmark"></span>
                                                <p>Sportswear</p>
                                            </label>
                                        </li>
                                        <li class="category-option">
                                            <input
                                                    type="checkbox"
                                                    id="checkBox-accessories__edit"
                                                    name="checkBox-accessories"
                                                    class="terms-checkbox"
                                                    value="accessories"
                                            />
                                            <label
                                                    class="label-checkmark"
                                                    for="checkBox-accessories__edit"
                                            >
                                                <span class="checkmark"></span>
                                                <p>Accessories</p>
                                            </label>
                                        </li>
                                        <li class="category-option">
                                            <input
                                                    type="checkbox"
                                                    id="checkBox-traditional__edit"
                                                    name="checkBox-traditional"
                                                    class="terms-checkbox"
                                                    value="traditional"
                                            />
                                            <label
                                                    class="label-checkmark"
                                                    for="checkBox-traditional__edit"
                                            >
                                                <span class="checkmark"></span>
                                                <p>Traditional</p>
                                            </label>
                                        </li>
                                        <li class="category-option">
                                            <input
                                                    type="checkbox"
                                                    id="checkBox-streetwear__edit"
                                                    name="checkBox-streetwear"
                                                    class="terms-checkbox"
                                                    value="streetwear"
                                            />
                                            <label
                                                    class="label-checkmark"
                                                    for="checkBox-streetwear__edit"
                                            >
                                                <span class="checkmark"></span>
                                                <p>Streetwear</p>
                                            </label>
                                        </li>
                                        <li class="category-option">
                                            <input
                                                    type="checkbox"
                                                    id="checkBox-footwear__edit"
                                                    name="checkBox-footwear"
                                                    class="terms-checkbox"
                                                    value="footwear"
                                            />
                                            <label class="label-checkmark" for="checkBox-footwear__edit">
                                                <span class="checkmark"></span>
                                                <p>Footwear</p>
                                            </label>
                                        </li>
                                        <li class="category-option">
                                            <input
                                                    type="checkbox"
                                                    id="checkBox-sleepwear__edit"
                                                    name="checkBox-sleepwear"
                                                    class="terms-checkbox"
                                                    value="sleepwear"
                                            />
                                            <label
                                                    class="label-checkmark"
                                                    for="checkBox-sleepwear__edit"
                                            >
                                                <span class="checkmark"></span>
                                                <p>Sleepwear</p>
                                            </label>
                                        </li>
                                        <li class="category-option">
                                            <input
                                                    type="checkbox"
                                                    id="checkBox-winter__edit"
                                                    name="checkBox-winter"
                                                    class="terms-checkbox"
                                                    value="Coats and Jackets"
                                            />
                                            <label class="label-checkmark" for="checkBox-winter__edit">
                                                <span class="checkmark"></span>
                                                <p>Coats and Jackets</p>
                                            </label>
                                        </li>
                                        <li class="category-option">
                                            <input
                                                    type="checkbox"
                                                    id="checkBox-casual__edit"
                                                    name="checkBox-casual"
                                                    class="terms-checkbox"
                                                    value="casual"
                                                    checked="checked"
                                            />
                                            <label class="label-checkmark" for="checkBox-casual__edit">
                                                <span class="checkmark"></span>
                                                <p>Casual Wear</p>
                                            </label>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <div class="product-info-container">
                            <div class="product-description-field input-field-container">
										<span class="error-message"
                                        >This field cannot be empty</span
                                        >
                                <i class="fa-solid fa-pen-to-square input-field-icon"></i>
                                <textarea
                                        type="text"
                                        id="product-description__edit"
                                        name="product-description"
                                        placeholder="Product Description"
                                        required
                                        class="input-field product-description"
                                        rows="6"
                                        maxlength="200"
                                ></textarea>

                                <div class="bullet-points">
                                    <i class="fa-solid fa-hand-point-right"></i>
                                    <i class="fa-solid fa-hand-point-right"></i>
                                    <i class="fa-solid fa-hand-point-right"></i>
                                    <i class="fa-solid fa-hand-point-right"></i>
                                    <i class="fa-solid fa-hand-point-right"></i>
                                    <i class="fa-solid fa-hand-point-right"></i>
                                </div>
                            </div>
                            <div class="product-upload-container">
                                <div class="product-upload input-field-container">
                                    <div class="upload-title-container">
                                        <h1 class="upload-title">Upload Product Image</h1>
                                    </div>
                                    <div class="product-edit">
                                        <input
                                                type="file"
                                                class="imageUpload-edit"
                                                id="productUpload-edit"
                                                accept="image/*"
                                                required
                                        />
                                        <label for="productUpload-edit"></label>
                                    </div>

                                    <div class="product-preview__edit">
                                        <div
                                                id="imagePreview-edit"
                                                class="imagePreview-edit"
                                                style="background-image: url(../images/upload-image.gif)"
                                        ></div>
                                    </div>
                                    <p class="upload-instruction-text">
                                        Upload Instruction: Image File Less than 2 MB
                                    </p>
                                </div>
                            </div>
                            <span class="no-change-error">No Changes Found In Product Details</span>
                            <button type="submit" class="btn btn-primary btn-editProduct">
                                Submit Changes
                            </button>
                        </div>
                    </div>

                </form>

                <div class="table-container table__product-list">
                    <form action="" class="search__form-products">
                        <i
                                class="fa-solid fa-magnifying-glass form-icon gradient-text active"
                        ></i>

                        <input
                                class="search__form--input"
                                name="search_term"
                                type="number"
                                placeholder="Search with Product ID"
                                required=""
                                autocomplete="off"
                        />
                    </form>


                    <table class="products-table">
                        <thead class="grey-gradient">
                        <tr>
                            <th scope="col">Photo</th>
                            <th scope="col">Product ID</th>
                            <th scope="col">Name</th>
                            <th scope="col">Brand</th>
                            <th scope="col">Price</th>
                            <th scope="col">Quantity</th>
                            <th scope="col">Actions</th>
                        </tr>
                        </thead>
                        <tbody class="table-body">

                        <c:forEach var="product" items="${productList}">
                            <tr>
                                <td class="image-column">
                                    <img src="../images/product-images/${product.image_name}" alt="Product Image" />
                                </td>
                                <td>${product.product_id}</td>
                                <td>${product.product_name}</td>
                                <td>${product.brand}</td>
                                <td>${product.price}</td>
                                <td>${product.stock_quantity}</td>
                                <td>
                                    <button data-id="${product.product_id}" class="btn btn-action btn--editProduct">Edit</button>
                                    <button data-id="${product.product_id}" class="btn btn-action btn--deleteProduct">Delete</button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Data in Tabular View -->

                <div class="table-container table__customer-orders">
                    <table class="customers-table">
                        <thead class="grey-gradient">
                        <tr>
                            <th scope="col">Date</th>
                            <th scope="col">Order ID</th>
                            <th scope="col">Name</th>
                            <th scope="col">Price</th>
                            <th scope="col">Quantity</th>
                            <th scope="col">Total</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>01/01/2023</td>
                            <td>123456789</td>
                            <td>Product A</td>
                            <td>$9.99</td>
                            <td>1</td>
                            <td>$9.99</td>
                        </tr>
                        <tr>
                            <td>01/02/2023</td>
                            <td>987654321</td>
                            <td>Product B</td>
                            <td>$19.99</td>
                            <td>2</td>
                            <td>$39.98</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>
</main>
</body>
</html>
