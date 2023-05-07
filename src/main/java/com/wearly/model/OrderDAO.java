package com.wearly.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    private Connection conn;

    public OrderDAO() {
        try {
            this.conn = DatabaseConnection.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean saveOrder(Orders order) {
        boolean success = false;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Insert the order into the Orders table
            String sqlOrders = "INSERT INTO orders (user_id, total_price, billing_address) VALUES (?, ?, ?)";
            ps = this.conn.prepareStatement(sqlOrders, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, order.getUserId());
            ps.setInt(2, order.getTotalPrice());
            ps.setString(3, order.getBillingAddress());
            ps.executeUpdate();

            // Get the generated order ID
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int orderId = rs.getInt(1);
                order.setOrderId(orderId);

                // Set the order items for this order
                List<OrderItem> orderItems = order.getOrderItems();
                String sqlItems = "INSERT INTO order_item (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
                ps = this.conn.prepareStatement(sqlItems);
                for (OrderItem orderItem : orderItems) {
                    ps.setInt(1, orderId);
                    ps.setInt(2, orderItem.getProductId());
                    ps.setInt(3, orderItem.getQuantity());
                    ps.setInt(4, orderItem.getPrice());
                    ps.addBatch();
                }
                ps.executeBatch();
                success = true;
            } else {
                // Roll back the transaction
                this.conn.rollback();
            }
        } catch (SQLException e) {
            // Handle the SQL exception
            e.printStackTrace();
        } finally {
            // Close the database resources
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (this.conn != null) {
                    this.conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return success;
    }

    public List<Orders> getOrdersByUserId(int userId) {
        List<Orders> ordersList = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ?";
        try (PreparedStatement ps = this.conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Orders order = new Orders();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setTotalPrice(rs.getInt("total_price"));
                    order.setBillingAddress(rs.getString("billing_address"));
                    order.setOrderDate(rs.getDate("order_date"));
                    ordersList.add(order);
                }
            }
        } catch (SQLException e) {
            // Handle the SQL exception
            e.printStackTrace();
        }
        return ordersList;
    }

    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> orderItemsList = new ArrayList<>();
        String sql = "SELECT * FROM order_item WHERE order_id = ?";
        try (PreparedStatement ps = this.conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItem orderItem = new OrderItem();
                    orderItem.setOrderItemId(rs.getInt("orderItem_id"));
                    orderItem.setOrderId(rs.getInt("order_id"));
                    orderItem.setProductId(rs.getInt("product_id"));
                    orderItem.setQuantity(rs.getInt("quantity"));
                    orderItem.setPrice(rs.getInt("price"));
                    orderItemsList.add(orderItem);
                }
            }
        } catch (SQLException e) {
            // Handle the SQL exception
            e.printStackTrace();
        }
        return orderItemsList;
    }

}
