<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.wearly.controller.SessionManager" %>
<%--
  Created by IntelliJ IDEA.
  User: sugam
  Date: 4/16/2023
  Time: 10:52 AM
  To change this template use File | Settings | File Templates.
--%>
<%
    try {
    if(SessionManager.isAlreadyLoggedIn(request)) {
        response.sendRedirect(request.getContextPath()+ "/view/index.jsp");
        return;
    }
        } catch (Exception e) {
        response.sendRedirect(request.getContextPath() + "/view/error.jsp");
    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>wearly - Login</title>
    <c:import url="pageResources.jsp" />

    <!-- Importing CSS -->
    <link rel="stylesheet" href="../css/styles.css" />
    <link rel="stylesheet" href="../css/global.css" />
    <link rel="stylesheet" href="../css/effects.css" />
    <link rel="stylesheet" href="../css/loginSignup.css" />

    <!-- Importing JS -->
    <script defer src="../js/passwordToggler.js"></script>
    <script defer src="../js/formController.js"></script>
    <script defer src="../js/loader.js"></script>
</head>
<body>
<div class="goIn-container container-login">
    <div class="go-back-main">
        <a href="index.jsp">
            <i class="fas fa-arrow-left"></i>
            Explore Products Without Logging In
        </a>
    </div>
    <section class="form-section login-section">
        <div class="svg-half">
            <div class="svg-aside">
                <img class="blue-blob" src="../images/blue-blob.svg" alt="Blue Blob" />
                <img src="../images/form-aside.svg" alt="Login" class="login-aside" />
            </div>
        </div>

        <div class="form-container">
            <div class="header__logo-box">
                <img
                        src="../images/animated-logo.gif"
                        alt="wearly-logo"
                        class="header__logo"
                />
                <h1 class="header__heading">wearly</h1>
            </div>
            <form
                    class="login-form"
                    action=""
                    method="post"
                    onsubmit="return validateLoginForm()"
                    novalidate
            >
                <div class="email-field input-field-container">
                    <span class="error-message">This field cannot be empty</span>
                    <i class="fa-solid fa-envelope input-field-icon login-email"></i>
                    <input
                            type="email"
                            name="email"
                            placeholder="Email"
                            required
                            class="input-field"
                    />
                </div>

                <div class="password-field input-field-container">
                    <span class="error-message">This field cannot be empty</span>
                    <i class="fa-solid fa-key input-field-icon fa-key-login"></i>
                    <div class="toggle-password-view">
                        <i class="ph-fill ph-eye"></i>
                        <i class="ph-fill ph-eye-slash hidden"></i>
                    </div>
                    <input
                            type="password"
                            name="password"
                            placeholder="Password"
                            required
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
    </section>
</div>
</body>
</html>
