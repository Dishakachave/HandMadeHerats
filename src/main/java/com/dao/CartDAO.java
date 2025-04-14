package com.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.product.ProductDetails;

public class CartDAO {
    private Connection connection;

    public CartDAO(Connection connection) {
        this.connection = connection;
    }

    public boolean addToCart(int userId, int productId, int quantity) {
        boolean result = false;
        try {
            String query = "INSERT INTO cart(user_id, product_id, quantity) VALUES(?, ?, ?)";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);
            int i = ps.executeUpdate();
            if (i == 1) {
                result = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }


    public void removeFromCart(int userId, int productId) throws SQLException {
        System.out.println("Removing from cart: userId=" + userId + ", productId=" + productId);

        String deleteQuery = "DELETE FROM cart WHERE user_id=? AND product_id=?";
        try (PreparedStatement statement = connection.prepareStatement(deleteQuery)) {
            statement.setInt(1, userId);
            statement.setInt(2, productId);
            statement.executeUpdate();
        }
    }

    public boolean updateCartItem(int userId, int productId, int quantity) throws SQLException {
        String query = "UPDATE cart SET quantity=? WHERE user_id=? AND product_id=?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, quantity);
            ps.setInt(2, userId);
            ps.setInt(3, productId);
            return ps.executeUpdate() == 1;
        }
    }


    public List<ProductDetails> getCartItems(int userId) throws SQLException {
        System.out.println("Fetching cart items for userId=" + userId);

        List<ProductDetails> cartItems = new ArrayList<>();
        String selectQuery = "SELECT * FROM cart WHERE user_id=?";
        try (PreparedStatement statement = connection.prepareStatement(selectQuery)) {
            statement.setInt(1, userId);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                // Fetch product details by ID
                ProductDetails product = getProductDetailsById(resultSet.getInt("product_id"));
                product.setQuantity(resultSet.getInt("quantity"));
                cartItems.add(product);
            }
        }
        return cartItems;
    }

    private ProductDetails getProductDetailsById(int productId) throws SQLException {
        String query = "SELECT * FROM products WHERE id=?";
        ProductDetails product = null;
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, productId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                product = new ProductDetails();
                product.setId(resultSet.getInt("id"));
                product.setName(resultSet.getString("name"));
                product.setDescription(resultSet.getString("description"));
                product.setPrice(resultSet.getDouble("price"));
                product.setImage(resultSet.getString("image"));
                // Add more fields as per your `ProductDetails` class
            }
        }
        return product;
    }
    
    public int getCartItemCount(int userId) throws SQLException {
        String query = "SELECT COUNT(*) FROM cart WHERE user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    public void clearCart(int userId) throws SQLException {
        String query = "DELETE FROM cart WHERE user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        }
    }

}
