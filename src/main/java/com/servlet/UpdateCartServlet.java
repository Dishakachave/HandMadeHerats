package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Enumeration;

import com.dao.CartDAO;
import com.db.DBConnect;
import com.user.UserDetails;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDetails user = (UserDetails) session.getAttribute("user");

        if (user != null) {
            Connection conn = null;
            try {
                conn = DBConnect.getConn();
                CartDAO cartDAO = new CartDAO(conn);
                
                Enumeration<String> parameterNames = request.getParameterNames();
                while (parameterNames.hasMoreElements()) {
                    String paramName = parameterNames.nextElement();
                    if (paramName.startsWith("quantity")) {
                        int productId = Integer.parseInt(paramName.substring(8));
                        int quantity = Integer.parseInt(request.getParameter(paramName));
                        cartDAO.updateCartItem(user.getId(), productId, quantity);
                    }
                }
                
                response.sendRedirect("cart.jsp");
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
                response.sendRedirect("cart.jsp?error=Database error: " + e.getMessage());
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
            response.sendRedirect("register.jsp?message=Please login to update your cart");
        }
    }
}
