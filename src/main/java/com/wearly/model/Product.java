package com.wearly.model;

public class Product {
    private String product_name;
    private String description;
    private int price;
    private int product_id;
    private String category_name;
    private String gender;
    private String brand;

    private int stock_quantity;
    private String image_name;
    private int category_id;

    private double rating;

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

public String getCategory_name() {
        return category_name;
    }
    public void setCategory_name(String category_name) {
        this.category_name = category_name;
    }

    public String getGender(){
        return gender;
    }

    public void setGender(String gender){
        this.gender = gender;
    }
    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getStock_quantity() {
        return stock_quantity;
    }

    public void setStock_quantity(int stock_quantity) {
        this.stock_quantity = stock_quantity;
    }

    public String getImage_name() {
        return image_name;
    }

    public void setImage_name(String image_name) {
        this.image_name = image_name;
    }

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }




    public Product(String product_name, int price,String brand, int stock_quantity,int category_id, String description, String image_name,double rating) {
        super();
        this.brand = brand;
        this.product_name = product_name;
        this.description = description;
        this.price = price;
        this.stock_quantity = stock_quantity;
        this.image_name = image_name;
        this.category_id = category_id;
        this.rating = rating;
    }

    public Product(String product_name, int price,String brand, int stock_quantity,String category_name,String gender, String description, String image_name,double rating) {
        super();
        this.brand = brand;
        this.product_name = product_name;
        this.description = description;
        this.price = price;
        this.stock_quantity = stock_quantity;
        this.image_name = image_name;
        this.category_name = category_name;
        this.gender = gender;
        this.rating = rating;
    }

    public Product() {
    }






}
