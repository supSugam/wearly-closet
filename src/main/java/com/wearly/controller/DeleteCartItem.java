package com.wearly.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.wearly.model.CartDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "DeleteCartItem", value = "/DeleteCartItem")
public class DeleteCartItem extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        if(!SessionManager.isLoggedIn(request.getSession())){
            System.out.println("Not logged in");
            return;
        }

        System.out.println("DeleteCartItem");
        // Parsing the JSON request body after FORM SUBMISSION
        JsonObject requestBody = new JsonParser().parse(request.getReader()).getAsJsonObject();


        // Extract item ID from the request body
        int cartItemId = requestBody.get("cartItemId").getAsInt();
        System.out.println(cartItemId);
        boolean isDeleted = false;
        try {
            CartDAO cartDAO = new CartDAO();
            isDeleted = cartDAO.deleteCartItem(cartItemId, SessionManager.getCartId(request.getSession()));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        // Set the response status code to 204 (No Content)
        if(isDeleted){
            // Set the response status code to 204
            response.setStatus(HttpServletResponse.SC_NO_CONTENT);
            return;
        } else{
            // Set the response status code to 403
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
