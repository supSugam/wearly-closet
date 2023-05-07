package com.wearly.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.wearly.model.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "OrderServlet", value = "/OrderServlet")
public class OrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Parsing the JSON request body after FORM SUBMISSION
        JsonObject requestBody = new JsonParser().parse(request.getReader()).getAsJsonObject();

        // Extract data from the request body
//        int phoneNumber = requestBody.get("phoneNumber").getAsInt();
        String paymentMethod = requestBody.get("paymentMethod").getAsString();
        String billingAddress = requestBody.get("billingAddress").getAsString();

        int userId = SessionManager.getUserId(request.getSession());

        // Retrieve the cart items from the database
        CartDAO cartDao = new CartDAO();
        int cartId = cartDao.getCartByUserId(userId).getCart_id();
        List<CartItem> cartItems = cartDao.getCartItemsByCartId(cartId);

        List<OrderItem> orderItems = new ArrayList<OrderItem>();

        // Calculate the total price of the order based on the cart items
        ProductDAO productDAO = new ProductDAO();
        int totalPrice = 0;
        for (CartItem cartItem : cartItems) {
            int price = productDAO.getProductPrice(cartItem.getProductId());
            totalPrice += price * cartItem.getQuantity();
            System.out.println(totalPrice);

            OrderItem orderItem = new OrderItem();
            orderItem.setProductId(cartItem.getProductId());
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setPrice(price);
            orderItems.add(orderItem);

        }

        // Create an instance of the Orders class and set its fields
        Orders order = new Orders();
        // add items to the orderItems list
        order.setOrderItems(orderItems);
        order.setUserId(userId);
        order.setBillingAddress(billingAddress);
        order.setTotalPrice(totalPrice);


        // Save the order into the orders table using the OrderDAO class
        OrderDAO orderDAO = new OrderDAO();
        orderDAO.saveOrder(order);

        // Retrieve the generated order ID from the database
        int orderId = order.getOrderId();

        // Create an instance of the Payment class and set its fields
        Payment payment = new Payment(orderId, paymentMethod, totalPrice);

        // Save the payment into the payment table using the PaymentDAO class
        PaymentDAO paymentDAO = new PaymentDAO();
        paymentDAO.savePayment(payment);

        // Delete the cart items from the database
        boolean cartItemsDeleted = false;

        try {
            cartItemsDeleted = cartDao.deleteCartItemsByCartId(cartId);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (cartItemsDeleted) {
            response.setStatus(200);
            for (CartItem cartItem : cartItems) {
                try {
                    productDAO.decreaseProductStock(cartItem.getProductId(), cartItem.getQuantity());
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
        } else {
            response.setStatus(500);
        }
    }
}
