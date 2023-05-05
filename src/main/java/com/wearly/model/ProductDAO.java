package com.wearly.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    private Connection conn;

    public ProductDAO() {
        try {
            this.conn = DatabaseConnection.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public boolean saveProduct(Product product) {
        boolean result = false;
        try {
            String query = "insert into product(product_name,brand,stock_quantity, price, description,image_name,category_id,rating) values(?,?,?,?,?,?,?,?)";
            PreparedStatement ps = this.conn.prepareStatement(query);
            ps.setString(1, product.getProduct_name());
            ps.setString(2, product.getBrand());
            ps.setInt(3, product.getStock_quantity());
            ps.setInt(4, product.getPrice());
            ps.setString(5, product.getDescription());
            ps.setString(6, product.getImage_name());
            ps.setInt(7, product.getCategory_id());
            ps.setDouble(8, product.getRating());
            ps.executeUpdate();
            result = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }


    public List<Product> getAllProductsDetails(int limit) {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT p.product_id, p.product_name, p.description, p.price, p.image_name, p.rating, p.brand,p.stock_quantity, p.category_id, c.gender, c.category_name FROM product p JOIN category c ON p.category_id = c.category_id ORDER BY RAND()";

        // Check if a limit is provided and set the limit parameter in the SQL query
        if (limit > 0) {
            sql += " LIMIT ?";
        }

        try (PreparedStatement ps = this.conn.prepareStatement(sql)) {
            // Set the limit parameter if it's provided
            if (limit > 0) {
                ps.setInt(1, limit);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setProduct_id(rs.getInt("product_id"));
                    product.setProduct_name(rs.getString("product_name"));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getInt("price"));
                    product.setImage_name(rs.getString("image_name"));
                    product.setRating(rs.getDouble("rating"));
                    product.setBrand(rs.getString("brand"));
                    product.setStock_quantity(rs.getInt("stock_quantity"));
                    product.setGender(rs.getString("gender"));
                    product.setCategory_name(rs.getString("category_name"));
                    productList.add(product);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }


    public List<Product> getProductsList() {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT * FROM product ORDER BY product_id ASC";
        try (PreparedStatement ps = this.conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setProduct_id(rs.getInt("product_id"));
                    product.setProduct_name(rs.getString("product_name"));
                    product.setPrice(rs.getInt("price"));
                    product.setImage_name(rs.getString("image_name"));
                    product.setBrand(rs.getString("brand"));
                    product.setStock_quantity(rs.getInt("stock_quantity"));
                    productList.add(product);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return productList;
    }




    public Product getProductInfoById(int productId) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        Product product = new Product();

        try {

            // Prepare the SQL statement with a placeholder for the product id
            String sql = "SELECT p.product_id, p.product_name, p.description, p.price, p.image_name, p.rating, p.brand,p.stock_quantity, p.category_id, c.gender, c.category_name FROM product p JOIN category c ON p.category_id = c.category_id WHERE p.product_id = ?";
            ps = this.conn.prepareStatement(sql);

            // Set the value of the placeholder to the product id passed in as a parameter
            ps.setInt(1, productId);

            // Execute the query and get the result set
            rs = ps.executeQuery();

            // If there is a row in the result set, extract the product data and create a Product object
            if (rs.next()) {
                product.setProduct_id(rs.getInt("product_id"));
                product.setProduct_name(rs.getString("product_name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getInt("price"));
                product.setImage_name(rs.getString("image_name"));
                product.setRating(rs.getDouble("rating"));
                product.setBrand(rs.getString("brand"));
                product.setStock_quantity(rs.getInt("stock_quantity"));
                product.setCategory_id(rs.getInt("category_id"));
                product.setGender(rs.getString("gender"));
                product.setCategory_name(rs.getString("category_name"));

            }


        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            // Close the database resources
            try { if (rs != null) rs.close(); } catch (SQLException e) { }
            try { if (ps != null) ps.close(); } catch (SQLException e) { }
            try { if (conn != null) conn.close(); } catch (SQLException e) { }
        }

        return product;
    }

    public boolean updateProductInfo(int productId, String productName, String productBrand, int productPrice,int productQuantity, int categoryId,String descriptionString,String imageName) throws SQLException {
        String sql = "UPDATE product SET product_name=?, brand=?, price=?,stock_quantity=?, category_id=?, description=?, image_name=? WHERE product_id=?";
        try (PreparedStatement ps = this.conn.prepareStatement(sql)) {
            ps.setString(1, productName);
            ps.setString(2, productBrand);
            ps.setInt(3, productPrice);
            ps.setInt(4, productQuantity);
            ps.setInt(5, categoryId);
            ps.setString(6, descriptionString);
            ps.setString(7, imageName);
            ps.setInt(8, productId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public int getProductQuantity(int productId) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        int quantity = 0;
        try {

            // Prepare the SQL statement with a placeholder for the product id
            String sql = "SELECT stock_quantity FROM product WHERE product_id = ?";
            ps = this.conn.prepareStatement(sql);

            // Set the value of the placeholder to the product id passed in as a parameter
            ps.setInt(1, productId);

            // Execute the query and get the result set
            rs = ps.executeQuery();

            // If there is a row in the result set, extract the product data and create a Product object
            if (rs.next()) {
                quantity = rs.getInt("stock_quantity");
            }

        } catch(SQLException ex) {
            ex.printStackTrace();
        } finally {
            // Close the database resources
            try { if (rs != null) rs.close(); } catch (SQLException e) { }
            try { if (ps != null) ps.close(); } catch (SQLException e) { }
            try { if (conn != null) conn.close(); } catch (SQLException e) { }
        }
        return quantity;
    }

//    public int updateProductQuantity(int productId, int quantity) throws SQLException {
//        String sql = "UPDATE product SET stock_quantity=? WHERE product_id=?";
//        try (PreparedStatement ps = this.conn.prepareStatement(sql)) {
//            ps.setInt(1, quantity);
//            ps.setInt(2, productId);
//            int rowsAffected = ps.executeUpdate();
//            return rowsAffected;
//        } catch (SQLException e) {
//            e.printStackTrace();
//            throw e;
//        }



}
