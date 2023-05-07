package com.wearly.model;

import com.wearly.controller.SessionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    private Connection conn;

    public CartDAO() {
        try {
            this.conn = DatabaseConnection.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Cart getCartByUserId(int userId) {
        Cart cart = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = this.conn.prepareStatement("SELECT * FROM cart WHERE user_id = ?");
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                int cartId = rs.getInt("cart_id");
                Timestamp dateCreated = rs.getTimestamp("date_created");
                cart = new Cart(userId, cartId, dateCreated);
            } else {
                ps = this.conn.prepareStatement("INSERT into cart(user_id) values(?)", Statement.RETURN_GENERATED_KEYS);
                ps.setInt(1, userId);
                ps.executeUpdate();
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    int cartId = rs.getInt(1);
                    Timestamp dateCreated = rs.getTimestamp("date_created");
                    cart = new Cart(userId, cartId, dateCreated);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return cart;
    }

    public CartItem findCartItemByCartAndProduct(int cartId, int productId){
        CartItem cartItem = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = this.conn.prepareStatement("SELECT * FROM cart_item WHERE cart_id = ? AND product_id = ?");
            ps.setInt(1, cartId);
            ps.setInt(2, productId);
            rs = ps.executeQuery();
            if (rs.next()) {
                int cartItem_id = rs.getInt("cartItem_id");
                int cart_id = rs.getInt("cart_id");
                int product_id = rs.getInt("product_id");
                int quantity = rs.getInt("quantity");
                cartItem = new CartItem(cartItem_id, cart_id, product_id, quantity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return cartItem;
    }

    public boolean saveCartItem(CartItem cartItem) {
        boolean result = false;
        try {
            String query = "insert into cart_item(cart_id, product_id, quantity) values(?,?,?)";
            PreparedStatement ps = this.conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, cartItem.getCartId());
            ps.setInt(2, cartItem.getProductId());
            ps.setInt(3, cartItem.getQuantity());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int cartItem_id = rs.getInt(1);
                cartItem.setCartItemId(cartItem_id);
            }
            result = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public boolean updateCartItem(CartItem cartItem) {
        boolean result = false;
        try {
            String query = "update cart_item set quantity = ? where cartItem_id = ?";
            PreparedStatement ps = this.conn.prepareStatement(query);
            ps.setInt(1, cartItem.getQuantity());
            ps.setInt(2, cartItem.getCartItemId());
            ps.executeUpdate();
            result = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<CartItem> getCartItemsByCartId(int cartId) {
        List<CartItem> cartItems = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = this.conn.prepareStatement("SELECT * FROM cart_item WHERE cart_id = ?");
            ps.setInt(1, cartId);
            rs = ps.executeQuery();
            while (rs.next()) {
                int cartItem_id = rs.getInt("cartItem_id");
                int cart_id = rs.getInt("cart_id");
                int product_id = rs.getInt("product_id");
                int quantity = rs.getInt("quantity");
                CartItem cartItem = new CartItem(cartItem_id, cart_id, product_id, quantity);
                cartItems.add(cartItem);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return cartItems;
    }




    public boolean deleteCartItem(int cartItemId, int cartId) throws SQLException {
        boolean isDeleted = false;
        try (PreparedStatement ps = this.conn.prepareStatement("DELETE FROM cart_item WHERE cartItem_id = ? AND cart_id = ?")) {
            ps.setInt(1, cartItemId);
            ps.setInt(2, cartId);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 1) {
                isDeleted = true;
            }
        }
        return isDeleted;
    }

    public boolean deleteCartItemsByCartId(int cartId) throws SQLException {
        boolean isDeleted = false;
        try (PreparedStatement ps = this.conn.prepareStatement("DELETE FROM cart_item WHERE cart_id = ?")) {
            ps.setInt(1, cartId);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected >= 1) {
                isDeleted = true;
            }
        }
        return isDeleted;
    }





}
