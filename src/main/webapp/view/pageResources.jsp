<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.wearly.controller.SessionManager" %>
<%@ page import="com.wearly.model.UserBean" %>


    <jsp:useBean id="userBean" class="com.wearly.model.UserBean" scope="session" />


<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />


<!-- Importing Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
        href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&family=Righteous&display=swap"
        rel="stylesheet"
/>
<%--Importing Icons--%>
<link
        href="http://kit-pro.fontawesome.com/releases/v6.4.0/css/pro.min.css"
        rel="stylesheet"
/>
<script src="https://unpkg.com/@phosphor-icons/web"></script>
<%
    boolean isLoggedIn = SessionManager.isLoggedIn(session);
    String userType = "";
    int userId = 0;
    String userName = "";
    boolean isAdmin = false;
    boolean isCustomer = false;
    if (isLoggedIn) {
        userType = SessionManager.getUserType(session);
        userId = SessionManager.getUserId(session);
        userName = SessionManager.getUserName(session);
        isAdmin = SessionManager.isAdmin(session);
        isCustomer = SessionManager.isCustomer(session);
    } else {
        return;
    }
    // Set values in UserBean
    userBean.setIsLoggedIn(isLoggedIn);
    userBean.setUserType(userType);
    userBean.setUserId(userId);
    userBean.setUserName(userName);
    userBean.setIsAdmin(isAdmin);
    userBean.setIsCustomer(isCustomer);

%>

