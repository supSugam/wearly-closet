package com.wearly.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;
import com.wearly.model.Cart;
import com.wearly.model.CartDAO;
import com.wearly.model.CartItem;
import com.wearly.model.ProductDAO;

@WebServlet(name = "AddToCartServlet", value = "/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        if(!SessionManager.isLoggedIn(request.getSession())){
            response.setStatus(401);
            return;
        }

        // Parsing the JSON request body after FORM SUBMISSION
        JsonObject requestBody = new JsonParser().parse(request.getReader()).getAsJsonObject();

        // Extract data from the request body
        int productId = requestBody.get("productId").getAsInt();
        int quantity = requestBody.get("quantity").getAsInt();

        int userId = SessionManager.getUserId(request.getSession());
        CartDAO cartDao = new CartDAO();

        Cart cart = cartDao.getCartByUserId(userId);

        // Check if the product is already in the cart
        CartItem cartItem = new CartDAO().findCartItemByCartAndProduct(cart.getCart_id(), productId);
        boolean addedToCart = false;
        if (cartItem == null) {
            // Create a new cart item if the product isn't in the cart yet
            cartItem = new CartItem(-1, cart.getCart_id(), productId, quantity);
            addedToCart = cartDao.saveCartItem(cartItem);
        } else {
            // Update the quantity of the existing cart item
            cartItem.setQuantity(cartItem.getQuantity() + quantity);
            addedToCart = cartDao.updateCartItem(cartItem);
        }
        if (addedToCart) {
            response.setContentType("text/plain");
            int updatedQuantity = new ProductDAO().getProductQuantity(productId) - quantity;
            PrintWriter out = response.getWriter();
            out.print(updatedQuantity);
            out.flush();
            response.setStatus(200);
        } else {
            response.setStatus(500);
        }

    }
}
