<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="header">
    <div class="header__logo-box">
        <img
                src="../images/animated-logo.gif"
                alt="wearly-logo"
                class="header__logo"
        />
        <a href="index.jsp"><h1 class="header__heading">wearly</h1></a>
    </div>

    <nav class="header__nav">
        <ul class="header__nav-list">
            <li class="header__nav-item underline-effect">
                <a href="index.jsp" class="header__nav-link">Home</a>
            </li>
            <li class="header__nav-item underline-effect">
                <a href="products.jsp" class="header__nav-link"
                >Shop <i class="fa-solid fa-caret-down"></i
                ></a>

                <ul class="dropdown-menu-navbar">
                    <li class="dropdown-item dropdown_item-1">Latest</li>
                    <li class="dropdown-item dropdown_item-2">Trending</li>
                    <li class="dropdown-item dropdown_item-3">Mega Sale</li>
                </ul>
            </li>
            <li class="header__nav-item underline-effect">
                <a href="products.jsp" class="header__nav-link"
                >Category<i class="fa-solid fa-caret-down"></i
                ></a>
                <ul class="dropdown-menu-navbar">
                    <li class="dropdown-item dropdown_item-1">Mens</li>
                    <li class="dropdown-item dropdown_item-2">Womens</li>
                    <li class="dropdown-item dropdown_item-3">Unisex</li>
                    <li class="dropdown-item dropdown_item-3">Formals</li>
                    <li class="dropdown-item dropdown_item-3">Casuals</li>
                </ul>
            </li>
            <li class="header__nav-item underline-effect">
                <a href="products.jsp" class="header__nav-link"
                >Popular<i class="fa-solid fa-caret-down"></i
                ></a>
            </li>
        </ul>
    </nav>

    <div class="user__controls">
        <div class="header__search-box">
            <form action="" class="search__form" id="productSearch__form">
                <i
                        class="fa-solid fa-magnifying-glass form-icon gradient-text active"
                ></i>
                <i
                        class="fa-solid fa-spinner-third form-icon gradient-text fa-spin"
                ></i>
                <i class="fa-solid fa-x form-icon gradient-text"></i>

                <input
                        class="search__form--input"
                        name="search_term"
                        type="search"
                        placeholder="Search here.."
                        required=""
                        autocomplete="off"
                        id="productSearch__input"
                />
            </form>
            <ul class="dropdown-menu-searchsuggestions">
                <p><i class="fa-solid fa-fire"></i> Popular Right Now</p>
                <a href="products.jsp?searchQuery=hoodie">
                    <li class="dropdown-option">
                        <i class="fa-light fa-magnifying-glass"></i>Hoodie
                    </li>
                </a>
<%--                <li class="dropdown-option" data-value="hoodie">--%>
<%--                    <i class="fa-light fa-magnifying-glass"></i>Hoodie--%>
<%--                </li>--%>
                <li class="dropdown-option" data-value="tshirt">
                    <i class="fa-light fa-magnifying-glass"></i>Tshirt
                </li>
                <li class="dropdown-option" data-value="formalwear">
                    <i class="fa-light fa-magnifying-glass"></i>Formals
                </li>
            </ul>
        </div>

        <div class="header__icons">
            <c:choose>
                <c:when test="${userBean.isLoggedIn}">
                    <c:if test="${userBean.isCustomer}">
                        <a href="#" class="header__nav-link">
                            <i class="fa-solid fa-heart"></i>
                        </a>
                        <a href="cart.jsp" class="header__nav-link">
                            <i class="fa-solid fa-shopping-cart"></i>
                        </a>
                        <a href="#" class="header__nav-link">
                            <i class="fa-solid fa-user"></i>
                        </a>
                    </c:if>
                    <c:if test="${userBean.isAdmin}">
                        <a href="#" class="header__nav-link">
                            <i class="fa-solid fa-user"></i>
                        </a>
                    </c:if>
                    <ul class="dropdown-menu-profile">
                        <a href="profile.jsp">
                            <li class="dropdown-option">
                                <i class="fa-solid fa-user"></i> Profile
                            </li>
                        </a>

                        <c:if test="${userBean.isAdmin}">
                            <a href="adminPanel.jsp">
                                <li class="dropdown-option">
                                    <i class="fa-solid fa-screwdriver-wrench"></i> Dashboard
                                </li>
                            </a>

                        </c:if>

                        <c:if test="${userBean.isCustomer}">
                            <a href="orders.jsp">
                                <li class="dropdown-option">
                                    <i class="fa-solid fa-bags-shopping"></i> Your Orders
                                </li>
                            </a>
                        </c:if>


                        <a href="password.jsp">
                            <li class="dropdown-option">
                                <i class="fa-solid fa-key"></i> Reset Password
                            </li>
                        </a>

                        <a href="/wearly-ecommerce/LogOutServlet">
                            <li class="dropdown-option">
                                <i class="fa-solid fa-right-from-bracket"></i> Log Out
                            </li>
                        </a>
                    </ul>

                    <%--                    <ul class="dropdown-menu-profile">--%>
<%--                        <li class="dropdown-option">--%>
<%--                            <a href="#"><i class="fa-solid fa-user"></i> Profile</a>--%>
<%--                        </li>--%>

<%--                        <li class="dropdown-option">--%>
<%--                            <a href="cartPage.html"--%>
<%--                            ><i class="fa-solid fa-bags-shopping"></i> Your Orders</a--%>
<%--                            >--%>
<%--                        </li>--%>
<%--                        <li class="dropdown-option">--%>
<%--                            <a><i class="fa-solid fa-key"></i> Reset Password</a>--%>
<%--                        </li>--%>
<%--                        <li class="dropdown-option">--%>
<%--                            <a><i class="fa-solid fa-right-from-bracket"></i> Log Out</a>--%>
<%--                        </li>--%>
<%--                    </ul>--%>
                </c:when>
                <c:otherwise>
                    <a href="login.jsp" class="btn btn-primary margin-left btn--login">Login</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>