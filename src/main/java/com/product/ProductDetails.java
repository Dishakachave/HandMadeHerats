package com.product;

public class ProductDetails {
    private int id;
    private String name;
    private String description;
    private double price;
    private String image;
    private boolean inStock;
    private String category;
    private int quantity; // New field for quantity

    // Default constructor
    public ProductDetails() {}

    // Constructor with parameters
    public ProductDetails(String name, double price, String description, String image, boolean inStock, String category) {
        this.name = name;
        this.price = price;
        this.description = description;
        this.image = image;
        this.inStock = inStock;
        this.category = category;
    }

    // Getters and setters for all fields

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public boolean isInStock() {
        return inStock;
    }

    public void setInStock(boolean inStock) {
        this.inStock = inStock;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    // Getter and setter for quantity

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
