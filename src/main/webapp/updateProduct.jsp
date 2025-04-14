<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="com.dao.ProductDAO"%>
<%@ page import="com.product.ProductDetails"%>
<%@ page import="com.db.DBConnect"%>
<%@ page import="java.lang.ClassNotFoundException"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Update Product</title>
<%@include file="all_component/allcss.jsp"%>
</head>
<body>
    <%@include file="all_component/navbar.jsp"%>
    <div class="container">
        <h1>Update Product</h1>
        <% 
            int id = 0;
            try {
                id = Integer.parseInt(request.getParameter("id"));
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
            Connection conn = null;
            ProductDetails product = null;
            try {
                conn = DBConnect.getConn();
                ProductDAO productDAO = new ProductDAO(conn);
                product = productDAO.getProductById(id);
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
        %>
        <% if (product != null) { %>
        <form action="UpdateProductServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="<%= product.getId() %>">
            <input type="hidden" name="oldImage" value="<%= product.getImage() %>">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" class="form-control" id="name" name="name" value="<%= product.getName() %>" required>
            </div>
            <div class="form-group">
                <label for="description">Description:</label>
                <textarea class="form-control" id="description" name="description" required><%= product.getDescription() %></textarea>
            </div>
            <div class="form-group">
                <label for="price">Price:</label>
                <input type="number" class="form-control" id="price" name="price" value="<%= product.getPrice() %>" step="0.01" required>
            </div>
            <div class="form-group">
                <label for="image">Image:</label>
                <input type="file" class="form-control" id="image" name="image">
                <br>
                <img src="img/<%= product.getImage() %>" class="product-image" alt="<%= product.getName() %>" style="width: 100px;">
            </div>
            <div class="form-group">
                <label for="category">Category:</label>
                <input type="text" id="category" name="category" class="form-control" value="<%= product.getCategory() %>" required>
            </div>
            <div class="form-group">
                <label for="inStock">In Stock:</label>
                <input type="checkbox" id="inStock" name="inStock" <%= product.isInStock() ? "checked" : "" %>>
            </div>
            <button type="submit" class="btn btn-primary">Update Product</button>
        </form>
        <% } else { %>
        <p>Product not found!</p>
        <% } %>
    </div>
    <%@include file="all_component/footer.jsp"%>
</body>
</html>
