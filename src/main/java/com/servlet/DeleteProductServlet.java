package com.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import com.dao.ProductDAO;
import com.db.DBConnect;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String imageName = request.getParameter("image");

        Connection conn = null;
        try {
            conn = DBConnect.getConn();  // Get the database connection
            ProductDAO dao = new ProductDAO(conn);
            boolean isDeleted = dao.deleteProduct(id);

            if (isDeleted) {
                String imagePath = getServletContext().getRealPath("/") + "img" + File.separator + imageName;
                File imageFile = new File(imagePath);
                if (imageFile.exists()) {
                    imageFile.delete();
                }
            }

            // Redirect to appropriate page based on result
            if (isDeleted) {
                response.sendRedirect("productManagement.jsp");
            } else {
                response.getWriter().println("Error adding product");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().println("Database connection error: " + e.getMessage());
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
