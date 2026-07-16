package com.cart.model;

import java.io.Serializable;

public class Product implements Serializable {
    private int id;
    private String name;
    private double price;
    private String imageUrl;
    private String description;

    // 1. New Constructor
    public Product(int id, String name, double price, String imageUrl, String description) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.imageUrl = imageUrl;
        this.description = description; 
    }

    // 2. Old Constructor
    public Product(int id, String name, double price, String imageUrl) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.imageUrl = imageUrl;
        this.description = "No description available."; 
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public double getPrice() { return price; }
    public String getImageUrl() { return imageUrl; }
    public String getDescription() { return description; }
}