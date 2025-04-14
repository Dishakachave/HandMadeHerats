package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.dao.OrderDAO;
import com.db.DBConnect;
import com.order.Order;
import com.user.UserDetails;

@WebServlet("/OrdersServlet")
public class OrdersServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDetails user = (UserDetails) session.getAttribute("user");

        if (user != null) {
            try {
                Connection conn = DBConnect.getConn();
                OrderDAO orderDAO = new OrderDAO(conn);

                List<Order> orders = orderDAO.getOrdersForUser(user.getId());

                // Debugging: Print orders list size
                System.out.println("Orders retrieved: " + orders.size());

                // Set orders attribute in request
                request.setAttribute("orders", orders);

                // Forward to orders.jsp
                request.getRequestDispatcher("orders.jsp").forward(request, response);

                conn.close();
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
                response.sendRedirect("orders.jsp?error=Failed to fetch orders");
            }
        } else {
            response.sendRedirect("login.jsp"); // Redirect to login if user not logged in
        }
    }
}
