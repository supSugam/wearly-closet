package com.wearly.model;

import java.sql.Date;
import java.util.List;

public class Orders {

    private int orderId;
    private int userId;
    private Date orderDate;
    private int totalPrice;
    private String billingAddress;

    private List<OrderItem> orderItems;

    public Orders() {}

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getBillingAddress() {
        return billingAddress;
    }

    public void setBillingAddress(String billingAddress) {
        this.billingAddress = billingAddress;
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    public Orders(int userId, String billingAddress, List<CartItem> cartItems) {
        this.userId = userId;
        this.billingAddress = billingAddress;

        ProductDAO productDAO = new ProductDAO();
        int totalPrice = 0;
        for (CartItem cartItem : cartItems) {
            int price = productDAO.getProductPrice(cartItem.getProductId());
            totalPrice += price * cartItem.getQuantity();
        }
        this.totalPrice = totalPrice;
    }

    // Getters and setters...
}

