package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import com.dao.CartDAO;
import com.dao.OrderDAO;
import com.db.DBConnect;
import com.order.Order;
import com.product.ProductDetails;
import com.user.UserDetails;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDetails user = (UserDetails) session.getAttribute("user");

        if (user != null) {
            String fullName = request.getParameter("fullName");
            String address = request.getParameter("address");

            if (fullName != null && !fullName.isEmpty() && address != null && !address.isEmpty()) {
                Connection conn = null;
                try {
                    conn = DBConnect.getConn();
                    CartDAO cartDAO = new CartDAO(conn);
                    OrderDAO orderDAO = new OrderDAO(conn);

                    List<ProductDetails> cartItems = cartDAO.getCartItems(user.getId());
                    double total = calculateTotal(cartItems);

                    Order order = new Order();
                    order.setUserId(user.getId());
                    order.setFullName(fullName);
                    order.setAddress(address);
                    order.setCartItems(cartItems);
                    order.setOrderDate(new Timestamp(System.currentTimeMillis()));
                    order.setTotalAmount(total);
                    order.setStatus("Pending");

                    System.out.println("Placing order: " + order); // Log order details

                    int orderId = orderDAO.saveOrder(order);

                    if (orderId > 0) {
                        System.out.println("Order saved successfully with ID: " + orderId);
                        cartDAO.clearCart(user.getId());
                        response.sendRedirect("order-success.jsp");
                    } else {
                        System.out.println("Order save failed");
                        response.sendRedirect("checkout.jsp?error=Failed to save order");
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    e.printStackTrace();
                    response.sendRedirect("checkout.jsp?error=Database error: " + e.getMessage());
                } finally {
                    try {
                        if (conn != null && !conn.isClosed()) {
                            conn.close();
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                response.sendRedirect("checkout.jsp?error=Please provide both name and address.");
            }
        } else {
            response.sendRedirect("register.jsp?message=Please login to place your order");
        }
    }

    private double calculateTotal(List<ProductDetails> cartItems) {
        double total = 0.0;
        for (ProductDetails item : cartItems) {
            total += item.getPrice() * item.getQuantity();
        }
        return total;
    }
}
