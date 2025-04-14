<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.product.ProductDetails" %>
<%@ page import="com.dao.ProductDAO" %>
<%@ page import="com.db.DBConnect" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Product Management</title>
<%@include file="all_component/allcss.jsp"%>
<style>
    .product-management-container {
        padding: 20px;
        margin-top: 20px;
    }
    .product-table {
        width: 100%;
        margin-top: 20px;
    }
    .product-image {
        width: 100px;
        height: 100px;
        object-fit: cover;
    }
</style>
</head>
<body>
    <%@include file="all_component/navbar.jsp"%>
    <div class="container product-management-container">
        <h1>Product Management</h1>
        <a href="addProduct.jsp" class="btn btn-primary">Add New Product</a>
        <hr>
        <%
            Connection conn = null;
            List<ProductDetails> productList = null;
            try {
                conn = DBConnect.getConn();
                ProductDAO productDAO = new ProductDAO(conn);
                productList = productDAO.getAllProducts();
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

            // Iterate over productList directly in scriptlet
            if (productList != null) {
                for (ProductDetails product : productList) {
        %>
        <table class="product-table table table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Image</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Price</th>
                    <th>In Stock</th>
                    <th>Category</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><%= product.getId() %></td>
                    <td><img src="img/<%= product.getImage() %>" class="product-image" alt="<%= product.getName() %>"></td>
                    <td><%= product.getName() %></td>
                    <td><%= product.getDescription() %></td>
                    <td><%= product.getPrice() %></td>
                    <td><%= product.isInStock() ? "Yes" : "No" %></td>
                    <td><%= product.getCategory() %></td>
                    <td>
                        <a href="updateProduct.jsp?id=<%= product.getId() %>" class="btn btn-warning">Edit</a>
                        <form action="DeleteProductServlet" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<%= product.getId() %>">
                            <input type="hidden" name="image" value="<%= product.getImage() %>">
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </form>
                    </td>
                </tr>
            </tbody>
        </table>
        <% // End of product table loop
                }
            }
        %>
    </div>
    <%@include file="all_component/footer.jsp"%>
</body>
</html>
