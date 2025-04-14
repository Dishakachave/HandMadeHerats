package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.product.ProductDetails;

public class ProductDAO {
    private Connection conn;

    // Constructor
    public ProductDAO(Connection conn) {
        this.conn = conn;
    }

    // Add product method
    public boolean addProduct(ProductDetails product) {
        boolean isAdded = false;
        try {
            String query = "INSERT INTO products (name, price, description, image, inStock, category) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, product.getName());
            pstmt.setDouble(2, product.getPrice());
            pstmt.setString(3, product.getDescription());
            pstmt.setString(4, product.getImage());
            pstmt.setBoolean(5, product.isInStock());
            pstmt.setString(6, product.getCategory());
            int rows = pstmt.executeUpdate();
            isAdded = rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isAdded;
    }

    // Method to get all products
    public List<ProductDetails> getAllProducts() {
        List<ProductDetails> products = new ArrayList<>();
        try {
            String query = "SELECT * FROM products";
            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                ProductDetails product = new ProductDetails();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setDescription(rs.getString("description"));
                product.setImage(rs.getString("image"));
                product.setInStock(rs.getBoolean("inStock"));
                product.setCategory(rs.getString("category"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
 // Method to get the total number of products
    public int getTotalProducts() {
        int total = 0;
        try {
            String query = "SELECT COUNT(*) AS total FROM products";
            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    // Method to get products for a specific page
    public List<ProductDetails> getProductsPerPage(int offset, int limit) {
        List<ProductDetails> products = new ArrayList<>();
        try {
            String query = "SELECT * FROM products LIMIT ?, ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, offset);
            pstmt.setInt(2, limit);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                ProductDetails product = new ProductDetails();
                // Populate product details from the result set
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setImage(rs.getString("image"));
                product.setInStock(rs.getBoolean("inStock"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }



    // Method to update product
    public boolean updateProduct(ProductDetails product) {
        boolean isUpdated = false;
        try {
            String query = "UPDATE products SET name = ?, price = ?, description = ?, image = ?, inStock = ?, category = ? WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, product.getName());
            pstmt.setDouble(2, product.getPrice());
            pstmt.setString(3, product.getDescription());
            pstmt.setString(4, product.getImage());
            pstmt.setBoolean(5, product.isInStock());
            pstmt.setString(6, product.getCategory());
            pstmt.setInt(7, product.getId());
            int rows = pstmt.executeUpdate();
            isUpdated = rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isUpdated;
    }

    // Method to delete product
    public boolean deleteProduct(int id) {
        boolean isDeleted = false;
        try {
            String query = "DELETE FROM products WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, id);
            int rows = pstmt.executeUpdate();
            isDeleted = rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isDeleted;
    }

    // Method to get product by ID
    public ProductDetails getProductById(int id) throws SQLException {
        String sql = "SELECT * FROM products WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        ProductDetails product = null;
        if (rs.next()) {
            product = new ProductDetails();
            // Populate product details from the result set
            product.setId(rs.getInt("id"));
            product.setName(rs.getString("name"));
            product.setDescription(rs.getString("description"));
            product.setPrice(rs.getDouble("price"));
            product.setImage(rs.getString("image"));
            product.setInStock(rs.getBoolean("inStock"));
        }
        rs.close();
        ps.close();
        return product;
    }

    public List<ProductDetails> getRelatedProducts(int id) throws SQLException {
        String sql = "SELECT * FROM products WHERE category = (SELECT category FROM products WHERE id = ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        List<ProductDetails> products = new ArrayList<>();
        while (rs.next()) {
            ProductDetails product = new ProductDetails();
            // Populate product details from the result set
            product.setId(rs.getInt("id"));
            product.setName(rs.getString("name"));
            product.setDescription(rs.getString("description"));
            product.setPrice(rs.getDouble("price"));
            product.setImage(rs.getString("image"));
            product.setInStock(rs.getBoolean("inStock"));
            products.add(product);
        }
        rs.close();
        ps.close();
        return products;
    }
    
 // Get total number of products in a specific category
    public int getTotalProductsByCategory(String category) throws SQLException {
        String sql = "SELECT COUNT(*) FROM products WHERE category = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, category);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0; // Return 0 if there are no products found or an error occurs
    }


 // Get products by category with pagination
    public List<ProductDetails> getProductsByCategoryPerPage(String category, int start, int total) throws SQLException {
        List<ProductDetails> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE category = ? LIMIT ?, ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, category);
            stmt.setInt(2, start);
            stmt.setInt(3, total);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ProductDetails p = new ProductDetails();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setDescription(rs.getString("description"));
                    p.setImage(rs.getString("image"));
                    p.setInStock(rs.getBoolean("inStock"));
                    list.add(p);
                }
            }
        }
        return list;
    }

    public List<ProductDetails> searchProducts(String query) throws SQLException {
        List<ProductDetails> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE name LIKE ? OR description LIKE ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            String searchQuery = "%" + query + "%";
            stmt.setString(1, searchQuery);
            stmt.setString(2, searchQuery);
            

            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ProductDetails product = new ProductDetails();
                    product.setId(rs.getInt("id"));
                    product.setName(rs.getString("name"));
                    product.setPrice(rs.getDouble("price"));
                    product.setDescription(rs.getString("description"));
                    product.setImage(rs.getString("image"));
                    product.setInStock(rs.getBoolean("inStock"));
                    products.add(product);
                }
            }
        }
        return products;
    }


    public List<ProductDetails> getLatestProducts() {
        List<ProductDetails> products = new ArrayList<>();
        String query = "SELECT * FROM products ORDER BY id DESC LIMIT 8";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductDetails product = new ProductDetails();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setImage(rs.getString("image") != null ? rs.getString("image") : "default.jpg");
                product.setPrice(rs.getDouble("price"));
                product.setDescription(rs.getString("description") != null ? rs.getString("description") : "No description available");
                product.setInStock(rs.getInt("inStock") == 1);
                product.setCategory(rs.getString("category") != null ? rs.getString("category") : "Uncategorized");
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
}