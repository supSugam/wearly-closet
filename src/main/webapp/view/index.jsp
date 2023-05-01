<%@ page import="com.wearly.controller.SessionManager" %>
<%@ page import="com.wearly.model.Product" %>
<%@ page import="com.wearly.model.ProductDAO" %>
<%@ page import="java.util.List" %>

<%--
  Created by IntelliJ IDEA.
  User: sugam
  Date: 4/16/2023
  Time: 5:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%
    List<Product> productList = new ProductDAO().getRandomProducts(8);
    request.setAttribute("productList", productList);
%>


<HTML lang="en">
<head>
    <c:import url="pageResources.jsp" />


    <title>wearly - Wear Your Vibe</title>

    <link rel="stylesheet" href="../css/global.css" />
    <link rel="stylesheet" href="../css/styles.css" />
    <link rel="stylesheet" href="../css/effects.css" />
    <link rel="stylesheet" href="../css/loginSignup.css" />
    <link rel="stylesheet" href="../css/searchPage.css" />
    <link rel="stylesheet" href="../css/adminPanel.css"/>

    <script defer src="../js/effects.js"></script>
    <script defer src="../js/product-card-view.js"></script>
    <script defer src="../js/formController.js"></script>
    <script defer src="../js/loader.js"></script>
    <script defer src="../js/addToCart.js"></script>
    <c:if test="${userBean.isLoggedIn}">
        <script defer src="../js/profileDropdown.js"></script>
        <c:if test="${userBean.isAdmin}">
        <script defer src="../js/adminPanel.js"></script>
        </c:if>
    </c:if>
</head>
<body>

<c:import url="header.jsp" />

<main>
    <section class="section__hero">
        <div class="hero">
            <div class="hero-text-box">
                <h1 class="heading-primary">
                    <span class="extra-bold">Quality </span>
                    <span class="gradient-text">is</span><br />
                    Priority
                </h1>
                <p class="description-text-hero">
                    Get ready to elevate your wardrobe with Wearly. Our premium
                    clothing selection is handpicked to help you dress for success and
                    showcase your personality.
                </p>
                <div class="hero-btn">
                    <button class="btn btn-primary">Shop Now</button>
                    <div class="social-links flex--social">
                        <a href="http://www.pinterest.com" target="_blank"
                        ><i class="fa-brands fa-pinterest social-icon"></i
                        ></a>
                        <a href="http://www.facebook.com/" target="_blank"
                        ><i class="fa-brands fa-facebook social-icon"></i
                        ></a>
                        <a href="http://www.instagram.com" target="_blank"
                        ><i class="fa-brands fa-instagram social-icon"></i
                        ></a>
                    </div>
                </div>
            </div>
            <div class="hero-img-box">
                <div class="hero__img--guy">
                    <img src="../images/hero-guy.png" alt="hero-img" class="img--guy" />
                </div>
                <div class="hero__img--girl">
                    <img
                            src="../images/hero-img-girl.png"
                            alt="hero-img"
                            class="img--girl"
                    />
                </div>
            </div>
        </div>
    </section>

    <section class="section-category container">
        <div class="product-category">
            <div class="category category-1">
                <i class="ph ph-dress"></i>
                <span>Dress</span>
            </div>
            <div class="category category-2">
                <i class="ph ph-t-shirt"></i>
                <span>Shirt</span>
            </div>
            <div class="category category-3">
                <i class="ph ph-hoodie"></i>
                <span>Hoodie</span>
            </div>
            <div class="category category-4">
                <i class="ph ph-sneaker"></i>
                <span>Sneaker</span>
            </div>
            <div class="category category-5">
                <i class="ph ph-pants"></i>
                <span>Pants</span>
            </div>
            <div class="category category-6">
                <i class="ph ph-shirt-folded"></i>
                <span>Formalwear</span>
            </div>
        </div>
    </section>

    <section class="section__featured">
        <div class="featured-heading">
            <h1 class="heading-secondary">
                <span class="extra-bold">Popular </span>
                <span class="gradient-text">Right Now</span>
            </h1>
            <p class="description-text">
                We have the best offers for you. Check out our latest offers and get
                the best deals. Don't miss out on the chance to get your hands on
                these sought-after products at unbeatable prices!
            </p>
        </div>

        <div class="section__featured-boxes">
            <div class="featured-box featured_guy">
                <div class="featured-box__text">
                    <h1 class="heading-secondary">
                        <span class="gradient-text">25%</span> Off
                    </h1>
                    <h3 class="heading-tertiary">Premium Jeans</h3>
                    <button class="btn btn-featured">
                        Buy Now <i class="ph ph-arrow-elbow-right"></i>
                    </button>
                </div>
            </div>

            <div class="featured-box featured_girl">
                <div class="featured-box__text">
                    <h1 class="heading-secondary">
                        <span class="gradient-text">32%</span> Off
                    </h1>
                    <h3 class="heading-tertiary">Full White sportwear</h3>
                    <button class="btn btn-featured">
                        Buy Now <i class="ph ph-arrow-elbow-right"></i>
                    </button>
                </div>
            </div>
        </div>
    </section>
    <div id="overlay"></div>
    <dialog class="modal-popup open-popup" id="login-modal">
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

    <section class="section-product_cards">
        <div class="featured-heading container">
            <p class="small-heading">Our Products</p>
            <h1 class="heading-secondary">
                <span class="extra-bold">Find what you're</span>
                <span class="gradient-text">looking for.</span>
            </h1>
        </div>

        <div class="container product_cards--container">
        <c:forEach var="product" items="${productList}">
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

                                <button data-isloggedin="${userBean.isLoggedIn}" type="button" class="btn btn--cart">
                                    Add to Cart <i class="ph-fill ph-shopping-cart"></i>
                                </button>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>
            </div>
        </c:forEach>
        </div>
    </section>
</main>

<footer class="footer">
    <div class="foot-container grid--footer">
        <div class="contact-col">
            <img
                    class="footer-img"
                    src="../images/footer-img.svg"
                    alt="Farewell, Reach Me Later!"
            />

            <div class="contact-contents">
                <div class="email-info info">
                    <i class="fa-solid fa-envelope footer-icon"></i>
                    <a class="contact-text" href="mailto:hello@sugamsubedi.com.np"
                    >hello@wearlycloset.com.np</a
                    >
                </div>

                <div class="phone-info info">
                    <i class="fa-duotone fa-phone footer-icon"></i>
                    <a class="contact-text" href="#">Request a Call!</a>
                </div>

                <p class="copyright">
                    Copyright © <span class="year">2023</span> by Team Wearly, All
                    rights reserved.
                </p>
            </div>
        </div>

        <div class="other-col">
            <nav class="pages-col">
                <p class="footer-heading">Pages</p>
                <ul class="footer-nav">
                    <li><a class="footer-link" href="#">Home</a></li>
                    <li><a class="footer-link" href="#services">Products</a></li>
                    <li><a class="footer-link" href="#">Our Partners</a></li>
                    <li><a class="footer-link" href="#cta">Contact</a></li>
                    <li><a class="footer-link" href="#about-me">About Us</a></li>
                </ul>
            </nav>

            <nav class="socials-col">
                <p class="footer-heading">Socials</p>
                <ul class="footer-nav">
                    <li>
                        <a
                                class="footer-link footer-link-flex"
                                href="http://www.facebook.com/supSugam"
                                target="_blank"
                        ><i class="fa-brands fa-facebook footer-icon-social"></i
                        >Facebook</a
                        >
                    </li>
                    <li>
                        <a
                                class="footer-link footer-link-flex"
                                href="http://www.instagram.com"
                                target="_blank"
                        ><i class="fa-brands fa-instagram footer-icon-social"></i
                        >Instagram</a
                        >
                    </li>

                    <li>
                        <a
                                class="footer-link footer-link-flex"
                                href="http://vt.tiktok.com"
                                target="_blank"
                        ><i class="fa-brands fa-tiktok footer-icon-social"></i
                        >Tiktok</a
                        >
                    </li>

                    <li>
                        <a
                                class="footer-link footer-link-flex"
                                href="http://www.pinterest.com"
                                target="_blank"
                        ><i class="fa-brands fa-pinterest footer-icon-social"></i
                        >Pinterest</a
                        >
                    </li>
                </ul>
            </nav>

            <nav class="address-col">
                <p class="footer-heading">Our Store Venue</p>
                <div class="footer-nav">
                    <a
                            target="_blank"
                            href="http://goo.gl/maps/F4c6wenwhAkYpGEW8"
                            class="footer-link footer-link-flex line-height-max"
                    >Pokhara 7 - Kaski <br />Gandaki, Nepal
                    </a>
                    <a
                            target="_blank"
                            href="http://goo.gl/maps/F4c6wenwhAkYpGEW8"
                            class="footer-link footer-link-flex"
                    ><i class="fa-solid fa-location-dot footer-icon-social"></i>View
                        On Maps</a
                    >
                </div>
            </nav>
        </div>
    </div>
</footer>
</body>
</HTML>
