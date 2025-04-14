package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import com.dao.OrderDAO;
import com.db.DBConnect;

@WebServlet("/CancelOrderServlet")
public class CancelOrderServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        try {
            Connection conn = DBConnect.getConn();
            OrderDAO orderDAO = new OrderDAO(conn);

            boolean orderCancelled = orderDAO.cancelOrder(orderId);

            if (orderCancelled) {
                response.sendRedirect("OrdersServlet");
            } else {
                response.sendRedirect("OrdersServlet?error=Failed to cancel order");
            }

            conn.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("OrdersServlet?error=Database error: " + e.getMessage());
        }
    }
}
