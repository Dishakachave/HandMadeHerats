package com.servlet;

import com.dao.WishlistDAO;
import com.db.DBConnect;
import com.user.UserDetails;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AddToWishlistServlet")
public class AddToWishlistServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDetails user = (UserDetails) session.getAttribute("user");

        if (user != null) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            try (Connection conn = DBConnect.getConn()) {
                WishlistDAO wishlistDAO = new WishlistDAO(conn);
                wishlistDAO.addToWishlist(user.getId(), productId);
                response.sendRedirect("wishlist.jsp");
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
                response.sendRedirect("wishlist.jsp?error=Database error: " + e.getMessage());
            }
        } else {
            response.sendRedirect("register.jsp?message=Please login to add items to your wishlist");
        }
    }
}
