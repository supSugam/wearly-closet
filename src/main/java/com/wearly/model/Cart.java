package com.wearly.model;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class Cart {

    private int cart_id;
    private int user_id;
    private Timestamp date_created;

    public int getCart_id() {
        return cart_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public Timestamp getDate_created() {
        return date_created;
    }

    public void setCart_id(int cart_id) {
        this.cart_id = cart_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public void setDate_created(Timestamp date_created) {
        this.date_created = date_created;
    }

    public Cart(int user_id, int cart_id, Timestamp date_created) {
        this.user_id = user_id;
        this.cart_id = cart_id;
        this.date_created = date_created;
    }


}

