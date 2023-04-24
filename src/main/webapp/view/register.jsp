<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: sugam
  Date: 4/15/2023
  Time: 6:37 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
    <title>wearly - Register</title>
    <c:import url="pageResources.jsp" />

    <!-- Importing CSS -->
    <link rel="stylesheet" href="../css/styles.css" />
    <link rel="stylesheet" href="../css/global.css" />
    <link rel="stylesheet" href="../css/effects.css" />
    <link rel="stylesheet" href="../css/loginSignup.css" />

    <!-- Importing JS -->
    <script defer src="../js/imageView.js"></script>
    <script defer src="../js/passwordToggler.js"></script>
    <script defer src="../js/formController.js"></script>
    <script defer src="../js/loader.js"></script>
<body>
<div class="goIn-container container-signup">
    <section class="form-section signup-section">
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
                    action=""
                    method="post"
                    class="signup-form"
                    name="signup-form"
                    onsubmit="return validateSignupForm()"
                    novalidate
                    enctype="multipart/form-data"
            >
                <div class="signup-tab">
                    <div class="name-fields input-field-container">
                        <div class="first-name-field input-field-container">
                            <span class="error-message">This field cannot be empty</span>
                            <i class="input-field-icon fas fa-user"></i>
                            <input
                                    type="text"
                                    id="first-name"
                                    name="first-name"
                                    placeholder="First Name"
                                    required
                                    class="input-field"
                            />
                        </div>
                        <div class="last-name-field input-field-container">
                            <span class="error-message">This field cannot be empty</span>

                            <i class="input-field-icon fas fa-user"></i>
                            <input
                                    type="text"
                                    id="last-name"
                                    name="last-name"
                                    placeholder="Last Name"
                                    required
                                    class="input-field"
                            />
                        </div>
                    </div>

                    <div class="email-field input-field-container">
                        <span class="error-message"></span>

                        <i class="input-field-icon fas fa-envelope"></i>
                        <input
                                type="email"
                                id="email"
                                name="email"
                                placeholder="Email"
                                required
                                class="input-field"
                        />
                    </div>

                    <div class="credentials-fields input-field-container">
                        <div class="phone-field input-field-container">
                            <span class="error-message">This field cannot be empty</span>

                            <i class="input-field-icon fas fa-phone"></i>
                            <input
                                    type="number"
                                    id="phone"
                                    name="phone"
                                    placeholder="Phone Number"
                                    required
                                    class="input-field"
                            />
                        </div>
                        <div class="password-field input-field-container">
                            <span class="error-message"></span>

                            <i class="fa-solid fa-key input-field-icon"></i>
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
                                    autocomplete="new-password"
                            />
                        </div>
                    </div>

                    <div class="profile-upload input-field-container">
                        <span class="error-message">This field cannot be empty</span>
                        <div class="avatar-upload">
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
                                        style="background-image: url(../images/upload-image.gif)"
                                ></div>
                            </div>
                        </div>
                    </div>

                    <div class="exp">
                        <div class="checkbox">
                            <form>
                                <div>
                                    <input
                                            type="checkbox"
                                            id="check"
                                            name="check"
                                            class="terms-checkbox"
                                            value=""
                                            required
                                    />
                                    <label class="label-checkmark" for="check">
                                        <span class="checkmark"></span>
                                        <p>
                                            I agree to the
                                            <u>terms and conditions</u> of Wearly Pvt. Ltd.
                                        </p>
                                    </label>
                                </div>
                            </form>
                        </div>
                    </div>

                    <button
                            type="submit"
                            class="btn btn-primary submit-button btn-signup"
                    >
                        Sign Up
                    </button>
                </div>
            </form>
            <div class="redirect-text to-login">
                <p>Have an account already?</p>
                <a class="redirect-sign-up" href="login.html">Log In</a>
            </div>
        </div>
    </section>
</div>
</body>
</html>
