package com.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.dao.ProductDAO;
import com.db.DBConnect;
import com.product.ProductDetails;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/AddProductServlet")
@MultipartConfig
public class AddProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        boolean inStock = request.getParameter("inStock") != null;

        // Handle file upload for main image
        Part imagePart = request.getPart("image");
        String imageName = imagePart.getSubmittedFileName();
        String appPath = getServletContext().getRealPath("");
        String imgDirPath = appPath + "img";
        File imgDir = new File(imgDirPath);
        if (!imgDir.exists()) {
            imgDir.mkdirs();
        }
        String imagePath = imgDirPath + File.separator + imageName;
        imagePart.write(imagePath);

        // Create a ProductDetails object using the retrieved data
        ProductDetails product = new ProductDetails();
        product.setName(name);
        product.setPrice(price);
        product.setDescription(description);
        product.setImage(imageName);
        product.setCategory(category);
        product.setInStock(inStock);

        Connection conn = null;
        try {
            // Get a connection to the database
            conn = DBConnect.getConn();
            ProductDAO dao = new ProductDAO(conn);

            // Add the product to the database
            boolean result = dao.addProduct(product);

            // Redirect to appropriate page based on result
            if (result) {
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
