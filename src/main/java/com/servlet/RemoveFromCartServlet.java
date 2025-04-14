package com.servlet;

import java.io.*;
import java.sql.Connection;
import java.sql.SQLException;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import com.dao.CartDAO;
import com.db.DBConnect;
import com.user.UserDetails;

public class RemoveFromCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        
        UserDetails user = (UserDetails) request.getSession().getAttribute("user");
        
        if(user != null) {
            try {
                Connection conn = DBConnect.getConn();
                CartDAO cartDAO = new CartDAO(conn);
                cartDAO.removeFromCart(user.getId(), productId);
                conn.close();
                response.sendRedirect("cart.jsp"); // Redirect to cart page after removing
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            }
        } else {
            response.sendRedirect("register.jsp?message=Please login to remove items from cart");
        }
    }
}
