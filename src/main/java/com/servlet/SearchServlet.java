package com.servlet;

import com.dao.ProductDAO;
import com.db.DBConnect;
import com.product.ProductDetails;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");

        Connection conn = null;
        List<ProductDetails> searchResults = null;
        try {
            conn = DBConnect.getConn();
            ProductDAO productDAO = new ProductDAO(conn);
            searchResults = productDAO.searchProducts(query);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        request.setAttribute("searchResults", searchResults);
        request.getRequestDispatcher("searchResults.jsp").forward(request, response);
    }
}
