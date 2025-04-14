package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.dao.ProductDAO;
import com.product.ProductDetails;
import com.db.DBConnect;

@WebServlet("/index")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;

    public void init() throws ServletException {
        try {
            Connection connection = DBConnect.getConn();
            productDAO = new ProductDAO(connection);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            throw new ServletException("Unable to initialize ProductDAO", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<ProductDetails> latestProducts = productDAO.getLatestProducts();
        request.setAttribute("latestProducts", latestProducts);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
