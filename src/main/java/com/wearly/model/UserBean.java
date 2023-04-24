package com.wearly.model;

import java.io.Serializable;

public class UserBean implements Serializable {
    private boolean isLoggedIn;
    private String userType;
    private int userId;
    private String userName;
    private boolean isAdmin;
    private boolean isCustomer;

    public UserBean() {}

    public boolean getIsLoggedIn() {
        return isLoggedIn;
    }

    public void setIsLoggedIn(boolean isLoggedIn) {
        this.isLoggedIn = isLoggedIn;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public boolean getIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
    }

    public boolean getIsCustomer() {
        return isCustomer;
    }

    public void setIsCustomer(boolean isCustomer) {
        this.isCustomer = isCustomer;
    }
}
