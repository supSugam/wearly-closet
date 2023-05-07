<%@ page import="com.wearly.controller.SessionManager" %>
<%@ page import="com.wearly.model.UserDAO" %>
<%@ page import="com.wearly.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: sugam
  Date: 5/6/2023
  Time: 10:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if(!SessionManager.isLoggedIn(request.getSession())) {
        response.sendRedirect(request.getContextPath()+ "/view/index.jsp");
    }
%>
<html>
<head>
    <c:import url="pageResources.jsp" />
    <title>Change Password</title>

    <!-- Importing CSS -->
    <link rel="stylesheet" href="../css/styles.css" />
    <link rel="stylesheet" href="../css/global.css" />
    <link rel="stylesheet" href="../css/effects.css" />
    <link rel="stylesheet" href="../css/loginSignup.css" />
    <link rel="stylesheet" href="../css/editProfile.css" />
    <link rel="stylesheet" href="../css/searchPage.css" />

    <script defer src="../js/effects.js"></script>
    <script defer src="../js/popupHandler.js"></script>
    <script defer src="../js/searchForm.js"></script>
    <script defer src="../js/editPassword.js"></script>
    <script defer src="../js/passwordTogglerAll.js"></script>
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
<div class="container-editProfile">
    <section class="form-section editPassword-section">
        <div class="svg-half">
            <img
                    src="../images/forgot-password.svg"
                    alt="edit-profile"
                    class="login-aside"
            />
        </div>

        <div class="edit-password-container">
            <div class="header__logo-box">
                <img
                        src="../images/animated-logo.gif"
                        alt="wearly-logo"
                        class="header__logo"
                />
                <h1 class="header__heading">wearly</h1>
            </div>
            <form
                    action=""
                    method="post"
                    class="editPassword-form"
                    name="editPassword-form"
                    novalidate
            >
                <div class="password-field input-field__edit-container">
                    <span class="error-message__edit"></span>

                    <i class="fa-solid fa-key input-field__edit-icon edit-pass currentPass-icon"></i>
                    <div class="toggle-password-view currentPass-eye">
                        <i class="ph-fill ph-eye"></i>
                        <i class="ph-fill ph-eye-slash hidden"></i>
                    </div>
                    <input
                            type="password"
                            name="current-password"
                            placeholder="Current Password"
                            id="current-password"
                            class="input-field__edit"
                            autocomplete="new-password"
                    />
                    <a href="#" class="forgot-password gradient-text"
                    >Forgot Password?</a
                    >
                </div>

                <div class="password-field input-field__edit-container">
                    <span class="error-message__edit"></span>

                    <i class="fa-solid fa-key input-field__edit-icon edit-pass"></i>
                    <div class="toggle-password-view">
                        <i class="ph-fill ph-eye"></i>
                        <i class="ph-fill ph-eye-slash hidden"></i>
                    </div>
                    <input
                            type="password"
                            name="new-password"
                            placeholder="New Password"
                            id="new-password"
                            class="input-field__edit"
                            autocomplete="new-password"
                    />
                </div>
                <div class="password-field input-field__edit-container">
                    <span class="error-message__edit"></span>

                    <i class="fa-solid fa-key input-field__edit-icon edit-pass"></i>
                    <div class="toggle-password-view">
                        <i class="ph-fill ph-eye"></i>
                        <i class="ph-fill ph-eye-slash hidden"></i>
                    </div>
                    <input
                            type="password"
                            name="confirm-password"
                            placeholder="Confirm Password"
                            id="confirm-password"
                            class="input-field__edit"
                            autocomplete="new-password"
                    />
                </div>
                <button type="submit" class="btn btn-primary btn-saveChanges">
                    Update Password
                </button>
            </form>
        </div>
    </section>
</div>

</body>
</html>
