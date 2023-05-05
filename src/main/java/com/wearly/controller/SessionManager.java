package com.wearly.controller;


import com.wearly.model.Cart;
import com.wearly.model.CartDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class SessionManager {


    private static final String USER_TYPE = "user_type";
    private static final String USER_ID = "user_id";
    private static final String LOGGED_IN = "logged_in";
    private static final String USER_NAME = "user_name";

    private static final String CART_ID = "cart_id";
    public static void createSession(HttpSession session, int userId, String userName, String userType) {
        session.setAttribute(USER_ID, userId);
        session.setAttribute(LOGGED_IN, true);
        session.setAttribute(USER_TYPE, userType);
        session.setAttribute(USER_NAME, userName);
        Cart cart = new CartDAO().getCartByUserId(userId);
        session.setAttribute(CART_ID, cart.getCart_id());

    }

    public static void createCartSession(HttpSession session, int cartId) {
        session.setAttribute(CART_ID, cartId);
    }

    public static boolean isLoggedIn(HttpSession session) {
        return (session.getAttribute(LOGGED_IN) != null && (Boolean) session.getAttribute(LOGGED_IN));
    }

    public static boolean isCustomer(HttpSession session) {
        return (session.getAttribute(USER_TYPE) != null && (session.getAttribute(USER_TYPE)).equals("customer"));
    }

    public static boolean isAdmin(HttpSession session) {
        return (session.getAttribute(USER_TYPE) != null && ( session.getAttribute(USER_TYPE)).equals("admin"));
    }

    public static int getUserId(HttpSession session) {
        return (int) session.getAttribute(USER_ID);
    }

    public static int getCartId(HttpSession session) {
        return (int) session.getAttribute(CART_ID);
    }

    public static String getUserName(HttpSession session) {
        return (String) session.getAttribute(USER_NAME);
    }

    public static String getUserType(HttpSession session) {
        return (String) session.getAttribute(USER_TYPE);
    }

    public static void destroySession(HttpSession session) {
        session.invalidate();
    }

    public static boolean isAlreadyLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return (session != null && session.getAttribute(LOGGED_IN) != null && (Boolean) session.getAttribute(LOGGED_IN));
    }
}
