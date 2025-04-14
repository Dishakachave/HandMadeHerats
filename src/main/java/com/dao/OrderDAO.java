package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.order.Order;
import com.product.ProductDetails;

public class OrderDAO {
    private Connection connection;

    public OrderDAO(Connection connection) {
        this.connection = connection;
    }

    public int saveOrder(Order order) throws SQLException {
        int orderId = 0;
        String query = "INSERT INTO orders(user_id, full_name, address, order_date, total_amount, status) VALUES(?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, order.getUserId());
            ps.setString(2, order.getFullName());
            ps.setString(3, order.getAddress());
            ps.setTimestamp(4, order.getOrderDate());
            ps.setDouble(5, order.getTotalAmount());
            ps.setString(6, order.getStatus());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderId = rs.getInt(1);
                        System.out.println("Generated Order ID: " + orderId);
                        saveOrderItems(orderId, order.getCartItems());
                    }
                }
            } else {
                System.out.println("Order insertion failed, no rows affected.");
            }
        } catch (SQLException e) {
            System.err.println("SQL Error: " + e.getMessage());
            throw e;
        }
        return orderId;
    }

    private void saveOrderItems(int orderId, List<ProductDetails> cartItems) throws SQLException {
        String query = "INSERT INTO order_items(order_id, product_id, quantity) VALUES(?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            for (ProductDetails item : cartItems) {
                ps.setInt(1, orderId);
                ps.setInt(2, item.getId());
                ps.setInt(3, item.getQuantity());
                ps.addBatch();
            }
            ps.executeBatch();
        } catch (SQLException e) {
            System.err.println("Error saving order items: " + e.getMessage());
            throw e;
        }
    }

    


    public List<Order> getOrdersForUser(int userId) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM orders WHERE user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setFullName(rs.getString("full_name"));
                    order.setAddress(rs.getString("address"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setStatus(rs.getString("status"));
                    orders.add(order);
                }
            }
        }
        return orders;
    }


    public boolean updateOrder(Order order) throws SQLException {
        boolean result = false;
        String query = "UPDATE orders SET order_date=?, total_amount=?, status=? WHERE id=?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setTimestamp(1, order.getOrderDate());
            ps.setDouble(2, order.getTotalAmount());
            ps.setString(3, order.getStatus());
            ps.setInt(4, order.getId());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 1) {
                result = true;
            }
        }
        return result;
    }

    public boolean cancelOrder(int orderId) throws SQLException {
        boolean result = false;
        String updateQuery = "UPDATE orders SET status='Cancelled' WHERE id=?";
        try (PreparedStatement ps = connection.prepareStatement(updateQuery)) {
            ps.setInt(1, orderId);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 1) {
                // Optionally, you can implement logic to update order_items table or do other necessary tasks
                result = true;
            }
        }
        return result;
    }
    
    public Order getOrderById(int orderId) throws SQLException {
        Order order = null;
        String query = "SELECT * FROM orders WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setFullName(rs.getString("full_name"));
                    order.setAddress(rs.getString("address"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setStatus(rs.getString("status"));
                    // You can also fetch cart items if needed
                }
            }
        }
        return order;
    }
}
