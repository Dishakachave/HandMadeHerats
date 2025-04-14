package com.dao;

import com.product.ProductDetails;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WishlistDAO {
    private Connection conn;

    public WishlistDAO(Connection conn) {
        this.conn = conn;
    }

    public void addToWishlist(int userId, int productId) throws SQLException {
        String sql = "INSERT INTO wishlist(user_id, product_id) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            stmt.executeUpdate();
        }
    }

    public void removeFromWishlist(int userId, int productId) throws SQLException {
        String sql = "DELETE FROM wishlist WHERE user_id = ? AND product_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            stmt.executeUpdate();
        }
    }

    public List<ProductDetails> getWishlistItems(int userId) throws SQLException {
        List<ProductDetails> wishlistItems = new ArrayList<>();
        String sql = "SELECT p.id, p.name, p.price, p.description, p.image, p.inStock " +
                     "FROM wishlist w " +
                     "JOIN products p ON w.product_id = p.id " +
                     "WHERE w.user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ProductDetails product = new ProductDetails();
                    product.setId(rs.getInt("id"));
                    product.setName(rs.getString("name"));
                    product.setPrice(rs.getDouble("price"));
                    product.setDescription(rs.getString("description"));
                    product.setImage(rs.getString("image"));
                    product.setInStock(rs.getBoolean("inStock"));
                    wishlistItems.add(product);
                }
            }
        }
        return wishlistItems;
    }
    
    public int getWishlistItemCount(int userId) throws SQLException {
        String query = "SELECT COUNT(*) FROM wishlist WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
}
