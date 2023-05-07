<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.wearly.controller.SessionManager" %>
<%@ page import="java.util.List" %>
<%@ page import="com.wearly.model.*" %>
<%@ page import="java.util.ArrayList" %><%--
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
        int userId = SessionManager.getUserId(request.getSession());
        OrderDAO orderDAO = new OrderDAO();
        List<Orders> ordersList = orderDAO.getOrdersByUserId(userId);
        boolean isOrderEmpty = ordersList.isEmpty();
        request.setAttribute("isOrderEmpty", isOrderEmpty);
        if(!isOrderEmpty) {
            request.setAttribute("ordersList", ordersList);
        }
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
    <link rel="stylesheet" href="../css/ordersPage.css" />
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
<%--    <script defer src="../js/cartPage.js"></script>--%>
<%--    <script defer src="../js/orderProducts.js"></script>--%>

    <c:if test="${userBean.isLoggedIn}">
        <script defer src="../js/profileDropdown.js"></script>
        <c:if test="${userBean.isAdmin}">
            <script defer src="../js/adminPanel.js"></script>
        </c:if>
    </c:if>
</head>
<body>

<c:import url="header.jsp" />
<main class="container">
    <section class="orders-container">
        <div class="cart-items">
            <div class="cart-heading">
                <h1 class="cart-heading__title">
                    Your <span class="gradient-text">Orders</span>
                </h1>
                <p class="cart-items__subtitle"><span><c:out value="${ordersList.size()}"></c:out> </span> Items</p>
            </div>

            <div class="orders-content">
                <c:when test="${isOrderEmpty}">
                    <section class="empty-order-section">
                        <img src="../images/empty-cart.svg" alt="empty cart" class="empty-order-img">
                        <c:if test="${userBean.isAdmin}">
                            <a href="../view/adminPanel.jsp" class="empty-cart-navigation">
                                <button class="btn btn--primary back-to-shopping">
                                    <i class="ph-arrow-left-bold"></i>
                                    <span>Back to Admin Panel</span>
                                </button>
                            </a>
                        </c:if>
                        <c:if test="${userBean.isCustomer}">
                        <a href="../view/products.jsp" class="empty-cart-navigation">
                            <button class="btn btn--primary back-to-shopping">
                                <i class="fa-solid fa-cart-shopping-fast"></i>Continue Shopping
                            </button>
                        </a>
                        </c:if>
                    </section>
                </c:when>
                <div class="order-heading__container">
                    <h2 class="order-attribute__heading">Order ID</h2>
                    <h2 class="order-attribute__heading">Product Detail</h2>
                    <h2 class="order-attribute__heading">Quantity</h2>
                    <h2 class="order-attribute__heading">Total Order Price</h2>
                    <h2 class="order-attribute__heading">Billing Address</h2>
                    <h2 class="order-attribute__heading">Ordered Date</h2>
                </div>
                <div class="order-items__container scroll--simple">
                    <c:forEach items="${ordersList}" var="order">
                        <%
                        request.setAttribute("orderDAO", new OrderDAO());
                        %>
                        <c:set var="orderedItems" value="${orderDAO.getOrderItemsByOrderId(order.orderId)}" />
                        <c:forEach var="orderedItem" items="${orderedItems}">
                            <div class="order-item">
                                <div class="order-id__container">
                                    <h3>${orderedItem.orderItemId}</h3>
                                </div>
                                <%
                                request.setAttribute("productDAO", new ProductDAO());
                                %>
                                <c:set var="productDAO" value="${productDAO}" />
                                <c:set var="product" value="${productDAO.getProductInfoById(orderedItem.productId)}" />
                                <div class="order-item__details">
                                    <img
                                            src="../images/product-images/${product.image_name}"
                                            alt="product image"
                                            class="order-item__img"
                                    />
                                    <div class="order-item__details--text">
                                        <h3 class="order-item__title">${product.product_name}</h3>
                                        <div class="product-attribute">
                                            <i class="ph-fill ph-seal-check"></i>
                                            <span class="product-brand">${product.brand}</span>
                                        </div>
                                        <div class="product_price">
                                            <p class="product_price--text">Rs. <span>${product.price}</span></p>
                                        </div>
                                    </div>
                                </div>
                                <div class="order-item__quantity">
                                    <h2>${order.totalPrice}</h2>
                                    <span class="stock-quantity">(${product.stock_quantity} Left in Stock.)</span>
                                </div>

                                <div class="order-item__price">
                                    <p class="order-item__price--text">Rs.</p>
                                    <span class="order-item__price--value">15</span>
                                </div>
                                <div class="order-item__billing-address">
                                    <p class="order-item__billing-address">${order.billingAddress}</p>
                                </div>
                                <div class="order__date">
                                    <p>${order.orderDate}</p>
                                </div>
                            </div>
                        </c:forEach>
                    </c:forEach>
                </div>
            </div>
        </div>
    </section>
</main>
<jsp:include page="footer.html"/>
</body>
</html>
