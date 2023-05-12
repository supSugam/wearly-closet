package com.wearly.model;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.wearly.model.Product;
import com.wearly.model.ProductDAO;

public class SearchDAO {

    private Connection conn;

    public SearchDAO() {
        try {
            this.conn = DatabaseConnection.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public List<Product> searchProducts(String searchTerm) {
        List<Product> matchingProducts = new ArrayList<>();
        searchTerm = searchTerm.toLowerCase();
        // Retrieving the products are stored in a database or some other data store
        List<Product> allProducts = new ProductDAO().getAllProductsDetails(-1);

        for (Product product : allProducts) {
            if (product.getProduct_name().toLowerCase().contains(searchTerm) || product.getCategory_name().toLowerCase().contains(searchTerm) || product.getBrand().toLowerCase().contains(searchTerm) || product.getGender().toLowerCase().contains(searchTerm) || product.getDescription().toLowerCase().contains(searchTerm)){
                matchingProducts.add(product);
            }
        }
        return matchingProducts;
    }

    public List<User> searchUsers(String searchTerm) {
        List<User> matchingUsers = new ArrayList<>();
        searchTerm = searchTerm.toLowerCase();
        // Retrieving the products are stored in a database or some other data store
        List<User> allUsers = new UserDAO().getAllUsersList();

        for (User user : allUsers) {
            if(searchTerm.equals(("all"))){
                matchingUsers.add(user);
            }
            if (user.getFirst_name().toLowerCase().contains(searchTerm) || user.getLast_name().toLowerCase().contains(searchTerm)) {
                matchingUsers.add(user);
            }
        }
        return matchingUsers;
    }




//    public List<String> getMatchingProducts(String searchTerm) {
//        List<String> matchingTerms = new ArrayList<>();
//        searchTerm = searchTerm.toLowerCase();
//        // Retrieving the products are stored in a database or some other data store
//        List<String> matchingTerms = new ProductDAO().getMatchingSuggestions(searchTerm);
//        return matchingTerms;
//    }

    public List<Product> getProductsByFilters(int minPrice, int maxPrice, String category, String gender, String brand, String searchTerm, String sortBy) {
        List<Product> matchingProducts = new ArrayList<>();

        // Retrieve all products from the data store
        List<Product> allProducts = new ProductDAO().getSortedResults(sortBy, -1);

        for (Product product : allProducts) {
            boolean isMatch = true;

            // Check if the product matches the filter criteria
            if (minPrice > product.getPrice() || maxPrice < product.getPrice()) {
                isMatch = false;
            }
            if (!"all".equalsIgnoreCase(category) && !product.getCategory_name().equalsIgnoreCase(category)) {
                isMatch = false;
            }
            if (!"all".equalsIgnoreCase(gender) && !product.getGender().equalsIgnoreCase(gender)) {
                isMatch = false;
            }
            if (!"all".equalsIgnoreCase(brand) && !product.getBrand().equalsIgnoreCase(brand)) {
                isMatch = false;
            }
            if (!"all".equalsIgnoreCase(searchTerm) && !product.getProduct_name().toLowerCase().contains(searchTerm) && !product.getCategory_name().toLowerCase().contains(searchTerm)) {
                isMatch = false;
            }

            // Add the product to the list of matching products if it passes all filters
            if (isMatch) {
                matchingProducts.add(product);
            }
        }

        return matchingProducts;
    }


}
