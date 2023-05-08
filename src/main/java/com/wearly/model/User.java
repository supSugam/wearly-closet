package com.wearly.model;

import java.io.Serializable;
import java.sql.Date;

public class User implements Serializable {

        private int user_id;
        private String first_name;


        private String last_name;
        private String phone_number;
        private String email;
        private String password;
        private String image_name;
        private String user_type;
        private Date registered_date;

        public User() {

        }

        public User(String first_name, String last_name, String phone_number, String email, String password,
                        String image_name) {
                super();
//                this.user_id = user_id;
                this.first_name = first_name;
                this.last_name = last_name;
                this.phone_number = phone_number;
                this.email = email;
                this.password = password;
                this.image_name = image_name;
        }

        public int getUser_id() {
                return user_id;
        }

        public void setUser_id(int user_id) {
                this.user_id = user_id;
        }

        public String getFirst_name() {
                return first_name;
        }

        public void setFirst_name(String first_name) {
                this.first_name = first_name;
        }

        public String getLast_name() {
                return last_name;
        }
        public void setUser_type(String user_type) {
                this.user_type = user_type;
        }

        public String getUser_type() {
                return user_type;
        }

        public void setLast_name(String last_name) {
                this.last_name = last_name;
        }

        public String getPhone_number() {
                return phone_number;
        }

        public void setPhone_number(String phone_number) {
                this.phone_number = phone_number;
        }

        public String getEmail() {
                return email;
        }


        public void setEmail(String email) {
                this.email = email;
        }

        public String getPassword() {
                return password;
        }

        public void setPassword(String password) {
                this.password = password;
        }

        public String getImage_name() {
                return image_name;
        }

        public void setImage_name(String image_name) {
                this.image_name = image_name;
        }

        public Date getRegistered_date() {
                return registered_date;
        }
        public void setRegistered_date(Date registered_date) {
                this.registered_date = registered_date;
        }

}
