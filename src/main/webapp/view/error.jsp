<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: sugam
  Date: 5/7/2023
  Time: 7:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<HTML lang="en">
<head>
    <c:import url="pageResources.jsp" />
    <link href='https://fonts.googleapis.com/css?family=Baloo' rel='stylesheet'>

    <title>Error</title>

    <link rel="stylesheet" href="../css/global.css" />
    <link rel="stylesheet" href="../css/styles.css" />
    <link rel="stylesheet" href="../css/effects.css" />
    <link rel="stylesheet" href="../css/loginSignup.css" />
    <link rel="stylesheet" href="../css/searchPage.css" />
    <link rel="stylesheet" href="../css/adminPanel.css"/>
    <link rel="stylesheet" href="../css/errorPage.css" />
    <link rel="stylesheet" href="../css/cartPage.css" />

    <script defer src="../js/effects.js"></script>
    <script defer src="../js/formController.js"></script>
    <script defer src="../js/loader.js"></script>
    <script defer src="../js/addToCart.js"></script>
    <script defer src="../js/viewProductDetails.js"></script>
    <script defer src="../js/popupHandler.js"></script>
    <script defer src="../js/searchForm.js"></script>
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

<main class="container__error container">
    <section class="error_contents">
        <div class="error_image">
            <img
                    class="error_image--img"
                    src="../images/error-image.svg"
                    alt="Error"
            />
        </div>
        <div class="error_text">
            <img
                    class="error_text--img"
                    src="../images/disconnected-cropped.svg"
                    alt="Error"
            />
            <h1 class="error_text--heading">Oops!</h1>
            <p class="error_text--para">
                It seems like the page you are looking for doesn't exist or is
                currently experiencing some technical difficulties <br>🫤 <br>
                <span class="gradient-text">Please try again later!</span>
            </p>
            <a href="../view/products.jsp" class="empty-cart-navigation">
                <button class="btn btn--primary back-to-shopping">
                    <i class="fa-solid fa-cart-shopping-fast"></i>Continue Shopping
                </button>
            </a>
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
