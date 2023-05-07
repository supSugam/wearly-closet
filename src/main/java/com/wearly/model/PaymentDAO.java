package com.wearly.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class PaymentDAO {
    private Connection conn;

    public PaymentDAO() {
        try {
            this.conn = DatabaseConnection.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean savePayment(Payment payment) {
        boolean success = false;
        PreparedStatement ps = null;

        try {
            String sql = "INSERT INTO payment (order_id, payment_method, amount) VALUES (?, ?, ?)";
            ps = this.conn.prepareStatement(sql);
            ps.setInt(1, payment.getOrderId());
            ps.setString(2, payment.getPaymentMethod());
            ps.setInt(3, payment.getAmount());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                success = true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        return success;
    }
}
