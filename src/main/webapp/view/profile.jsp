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
        try {
    if(SessionManager.isLoggedIn(request.getSession())) {
        User user = new UserDAO().getUserDetailsByUserId(SessionManager.getUserId(request.getSession()));
        request.setAttribute("user", user);
    }
        } catch (Exception e) {
        response.sendRedirect(request.getContextPath() + "/view/error.jsp");
    }
%>
<html>
<head>
    <c:import url="pageResources.jsp" />
    <title>User Profile</title>

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
    <script defer src="../js/editUserProfile.js"></script>
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
<div class="container-editProfile">
    <section class="form-section editProfile-section">
        <div class="svg-half">
            <img src="../images/edit-profile.svg" alt="Login" class="login-aside" />
        </div>

        <div class="form-container">
            <form
                    action=""
                    method="post"
                    class="editProfile-form"
                    name="editProfile-form"
<%--                    onsubmit="return validateEditProfile()"--%>
                    novalidate
            >
                <div class="name-section">
                    <div class="profile-upload__edit input-field__edit-container">
								<span class="error-message__edit"
                                >This field cannot be empty</span
                                >
                        <div class="avatar-upload avatar-upload__edit">
                            <div class="avatar-edit">
                                <input
                                        type="file"
                                        id="profileUpload"
                                        accept="image/*"
                                        required
                                />
                                <label for="profileUpload"></label>
                            </div>
                            <div class="avatar-preview">
                                <div
                                        id="imagePreview"
                                        class="default-avatar"
                                        style="background-image: url(../images/user-images/${user.image_name});"
                                ></div>
                            </div>
                        </div>
                    </div>
                    <div class="name-fields__edit input-field__edit-container">
                        <div class="first-name-field input-field__edit-container">
									<span class="error-message__edit"
                                    >This field cannot be empty</span
                                    >
                            <i class="input-field__edit-icon fas fa-user"></i>
                            <input
                                    type="text"
                                    id="first-name"
                                    name="first-name"
                                    placeholder="First Name"
                                    required
                                    class="input-field__edit"
                                    value="${user.first_name}"
                            />
                        </div>
                        <div class="last-name-field input-field__edit-container">
									<span class="error-message__edit"
                                    >This field cannot be empty</span
                                    >

                            <i class="input-field__edit-icon fas fa-user"></i>
                            <input
                                    type="text"
                                    id="last-name"
                                    name="last-name"
                                    placeholder="Last Name"
                                    required
                                    class="input-field__edit"
                                    value="${user.last_name}"
                            />
                        </div>
                    </div>
                </div>

                <div class="email-field input-field__edit-container">
                    <span class="error-message__edit"></span>

                    <i class="input-field__edit-icon fas fa-envelope"></i>
                    <input
                            type="email"
                            id="email"
                            name="email"
                            placeholder="Email"
                            required
                            class="input-field__edit"
                            value="${user.email}"
                    />
                </div>
                <div class="phone-field input-field__edit-container">
							<span class="error-message__edit"
                            >This field cannot be empty</span
                            >

                    <i class="input-field__edit-icon fas fa-phone"></i>
                    <input
                            type="number"
                            id="phone"
                            name="phone"
                            placeholder="Phone Number"
                            required
                            class="input-field__edit"
                            value="${user.phone_number}"
                    />
                </div>

                <button type="submit" class="btn btn-primary btn-editProfile">
                    Save Changes
                </button>
            </form>
        </div>
    </section>
</div>

</body>
</html>
