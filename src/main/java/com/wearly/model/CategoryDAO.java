package com.wearly.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CategoryDAO {

    private Connection conn;

    public CategoryDAO() {
        try {
            this.conn = DatabaseConnection.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public int getCategoryID(String gender, String category) throws SQLException {
        int categoryID = -1; // initialize to a default value

        String query = "SELECT category_id FROM category WHERE gender = ? AND category_name = ?";
        PreparedStatement statement = conn.prepareStatement(query);
        statement.setString(1, gender);
        statement.setString(2, category);

        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {
            categoryID = resultSet.getInt("category_id");
        }

        return categoryID;
    }

    // close the JDBC connection when done
    public void close() throws SQLException {
        conn.close();
    }


}
