package com.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

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

@WebServlet("/UpdateProductServlet")
@MultipartConfig
public class UpdateProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        String oldImage = request.getParameter("oldImage");
        boolean inStock = Boolean.parseBoolean(request.getParameter("inStock"));
        String category = request.getParameter("category");
        
        Part part = request.getPart("image");
        String fileName = part.getSubmittedFileName();
        
        ProductDetails product = new ProductDetails();
        product.setId(id);
        product.setName(name);
        product.setDescription(description);
        product.setPrice(price);
        product.setInStock(inStock);
        product.setCategory(category);
        
        Connection conn = null;

        try {
            conn = DBConnect.getConn(); // Get the database connection
            ProductDAO dao = new ProductDAO(conn);
            
            // Update image only if a new file is uploaded
            if (fileName != null && !fileName.isEmpty()) {
                product.setImage(fileName);
                String imagePath = getServletContext().getRealPath("/") + "img" + File.separator + fileName;
                part.write(imagePath);
                
                String oldImagePath = getServletContext().getRealPath("/") + "img" + File.separator + oldImage;
                File oldImageFile = new File(oldImagePath);
                if (oldImageFile.exists()) {
                    oldImageFile.delete();
                }
            } else {
                product.setImage(oldImage); // Keep the old image
            }
            
            // Simplified code for updating product
            boolean result = dao.updateProduct(product);	
            if (result) {
                response.sendRedirect(request.getContextPath() + "/productManagement.jsp");
            } else {
                response.getWriter().println("Error updating product");
            }
        } catch (ClassNotFoundException | SQLException e) {
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
