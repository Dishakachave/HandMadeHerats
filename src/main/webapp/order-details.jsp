<%@ page import="com.order.Order" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Details</title>
    <%@include file="all_component/allcss.jsp"%>
    <style>
        /* Add your custom CSS styles */
        .order-details {
            margin-top: 20px;
        }
        .order-details p {
            font-size: 1.1em;
        }
    </style>
</head>
<body>
    <%@include file="all_component/navbar.jsp"%>
    <div class="container order-details">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h4>Order Details - Order ID: <%= order.getId() %></h4>
                    </div>
                    <div class="card-body">
                        <p><strong>Order Date:</strong> <%= order.getOrderDate() %></p>
                        <p><strong>Total Amount:</strong> ₹<%= order.getTotalAmount() %></p>
                        <p><strong>Status:</strong> <%= order.getStatus() %></p>
                        <% if (order.getCartItems() != null && !order.getCartItems().isEmpty()) { %>
                            <h5>Items:</h5>
                            <ul>
                                <% for (com.product.ProductDetails item : order.getCartItems()) { %>
                                    <li><%= item.getName() %> - ₹<%= item.getPrice() %> x <%= item.getQuantity() %></li>
                                <% } %>
                            </ul>
                        <% } else { %>
                            <p>No items found in this order.</p>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@include file="all_component/footer.jsp"%>
</body>
</html>
