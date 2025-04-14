package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import com.dao.OrderDAO;
import com.order.Order;
import com.db.DBConnect;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/OrderDetailsServlet")
public class OrderDetailsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        try {
            Connection conn = DBConnect.getConn(); // Ensure correct connection handling
            OrderDAO orderDAO = new OrderDAO(conn);

            Order order = orderDAO.getOrderById(orderId);
            conn.close(); // Close connection after use

            if (order != null) {
                System.out.println("Order Details: " + order); // Debug output
                request.setAttribute("order", order);
                request.getRequestDispatcher("order-details.jsp").forward(request, response);
            } else {
                response.sendRedirect("orders.jsp?error=Order not found");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("orders.jsp?error=Database error");
        }
    }
}
