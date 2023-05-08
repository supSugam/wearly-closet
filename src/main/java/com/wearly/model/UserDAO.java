package com.wearly.model;

import java.sql.*;

import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    private Connection conn;

    public UserDAO() {
        try {
            this.conn = DatabaseConnection.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public User saveUser(User user) {
        try {
            String query = "INSERT INTO user (first_name, last_name, phone_number, email, password, image_name,user_type) VALUES (?, ?, ?, ?, ?, ?,?)";
            PreparedStatement ps = this.conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, user.getFirst_name());
            ps.setString(2, user.getLast_name());
            ps.setString(3, user.getPhone_number());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPassword());
            ps.setString(6, user.getImage_name());
            ps.setString(7, user.getUser_type());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int user_id = rs.getInt(1);
                user.setUser_id(user_id);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }






    public List<User> getAllUsersList(){
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM user WHERE user_type = 'customer'";

        try (PreparedStatement ps = this.conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    User user = new User();
                    user.setUser_id(rs.getInt("user_id"));
                    user.setFirst_name(rs.getString("first_name"));
                    user.setLast_name(rs.getString("last_name"));
                    user.setPhone_number(rs.getString("phone_number"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setImage_name(rs.getString("image_name"));
                    user.setUser_type(rs.getString("user_type"));
                    user.setRegistered_date(rs.getDate("registered_date"));
                    users.add(user);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }

    public boolean updatePassword(String password, int user_id) {
        boolean result = false;
        try {
            String query = "UPDATE user SET password = ? WHERE user_id = ?";
            PreparedStatement ps = this.conn.prepareStatement(query);
            ps.setString(1, password);
            ps.setInt(2, user_id);
            if (ps.executeUpdate() > 0) {
                result = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }



    public boolean userAlreadyExists(String phoneNumber) {
        try {
            PreparedStatement ps = this.conn.prepareStatement("SELECT * FROM user WHERE phone_number = ?");
            ps.setString(1, phoneNumber);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true; // User already exists
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // User does not exist
    }

    public User getUserByEmail(String email) {
        User user = null;
        String sql = "SELECT * FROM user WHERE email = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setUser_id(rs.getInt("user_id"));
                    user.setFirst_name(rs.getString("first_name"));
                    user.setLast_name(rs.getString("last_name"));
                    user.setPhone_number(rs.getString("phone_number"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setImage_name(rs.getString("image_name"));
                    user.setUser_type(rs.getString("user_type"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    public User getUserDetailsByUserId(int userId){
        User user = null;
        String sql = "SELECT * FROM user WHERE user_id = ?";

        try (PreparedStatement ps = this.conn.prepareStatement(sql)) {
            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setUser_id(rs.getInt("user_id"));
                    user.setFirst_name(rs.getString("first_name"));
                    user.setLast_name(rs.getString("last_name"));
                    user.setPhone_number(rs.getString("phone_number"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setImage_name(rs.getString("image_name"));
                    user.setUser_type(rs.getString("user_type"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    public boolean updateUserDetails(User user,boolean imageChanged) {
        boolean result = false;
        String query;
        if(imageChanged){
            query = "update user set first_name=?, last_name=?, phone_number=?, email=?, image_name=? where user_id=?";
        } else{
            query = "update user set first_name=?, last_name=?, phone_number=?, email=? where user_id=?";
        }
        try {
            PreparedStatement ps = this.conn.prepareStatement(query);
            ps.setString(1, user.getFirst_name());
            ps.setString(2, user.getLast_name());
            ps.setString(3, user.getPhone_number());
            ps.setString(4, user.getEmail());
            if(imageChanged){
                ps.setString(5, user.getImage_name());
                ps.setInt(6, user.getUser_id());
            } else{
                ps.setInt(5, user.getUser_id());
            }
            ps.executeUpdate();
            result = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public String getUserPasswordById(int userId){
        String password = null;
        String sql = "SELECT password FROM user WHERE user_id = ?";

        try (PreparedStatement ps = this.conn.prepareStatement(sql)) {
            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    password = rs.getString("password");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return password;
    }

    public String getUserFirstNameById(int userId){
        String firstName = null;
        String sql = "SELECT first_name FROM user WHERE user_id = ?";

        try (PreparedStatement ps = this.conn.prepareStatement(sql)) {
            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    firstName = rs.getString("first_name");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return firstName;
    }


}
