package com.order;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;
import com.product.ProductDetails;

public class Order implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int userId;
    private String fullName;
    private String address;
    private List<ProductDetails> cartItems;
    private Timestamp orderDate;
    private double totalAmount;
    private String status;

    // Default Constructor
    public Order() {
    }

    // Parameterized Constructor
    public Order(int id, int userId, String fullName, String address, List<ProductDetails> cartItems, Timestamp orderDate, double totalAmount, String status) {
        this.id = id;
        this.userId = userId;
        this.fullName = fullName;
        this.address = address;
        this.cartItems = cartItems;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.status = status;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public List<ProductDetails> getCartItems() {
        return cartItems;
    }

    public void setCartItems(List<ProductDetails> cartItems) {
        this.cartItems = cartItems;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // toString Method for Logging and Debugging
    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", userId=" + userId +
                ", fullName='" + fullName + '\'' +
                ", address='" + address + '\'' +
                ", cartItems=" + cartItems +
                ", orderDate=" + orderDate +
                ", totalAmount=" + totalAmount +
                ", status='" + status + '\'' +
                '}';
    }
}
