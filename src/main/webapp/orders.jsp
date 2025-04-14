<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.order.Order" %>
<%@ page import="com.product.ProductDetails" %>
<%@ page import="com.user.UserDetails" %>
<%@ page import="java.sql.Timestamp" %>

<%
    // Dummy data to simulate orders
    List<Order> orders = new ArrayList<>();
    
    // Create dummy orders
    Order order1 = new Order();
    order1.setId(1);
    order1.setOrderDate(new Timestamp(System.currentTimeMillis()));
    order1.setTotalAmount(1500.0);
    order1.setStatus("Shipped");

    Order order2 = new Order();
    order2.setId(2);
    order2.setOrderDate(new Timestamp(System.currentTimeMillis() - 86400000)); // 1 day ago
    order2.setTotalAmount(2800.0);
    order2.setStatus("Delivered");

    orders.add(order1);
    orders.add(order2);

    // Error handling section
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Orders</title>
    <%@include file="all_component/allcss.jsp"%>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            color: #333;
        }
        .orders-page {
            margin: 20px;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .orders-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .orders-table thead {
            background-color: #007bff;
            color: #fff;
        }
        .orders-table th, .orders-table td {
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd;
        }
        .orders-table tbody tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .orders-table a {
            color: #007bff;
            text-decoration: none;
        }
        .orders-table a:hover {
            text-decoration: underline;
        }
        h2 {
            color: #007bff;
            text-align: center;
        }
    </style>
</head>
<body>
    <%@include file="all_component/navbar.jsp"%>

    <%-- Error handling section --%>
    <% if (error != null) { %>
        <div class="container">
            <div class="alert alert-danger" role="alert">
                <%= error %>
            </div>
        </div>
    <% } %>

    <div class="container orders-page">
        <h2>Your Orders</h2>
        
        <table class="orders-table">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Order Date</th>
                    <th>Total Amount</th>
                    <th>Status</th>
                    <th>Details</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    if (orders != null && !orders.isEmpty()) {
                        for (Order order : orders) { 
                %>
                <tr>
                    <td><%= order.getId() %></td>
                    <td><%= order.getOrderDate() %></td>
                    <td>₹<%= order.getTotalAmount() %></td>
                    <td><%= order.getStatus() %></td>
                    <td><a href="OrderDetailsServlet?orderId=<%= order.getId() %>">View Details</a></td>
                </tr>
                <% 
                        } 
                    } else { 
                %>
                <tr>
                    <td colspan="5">No orders found.</td>
                </tr>
                <% 
                    } 
                %>
            </tbody>
        </table>
    </div>

    <%@include file="all_component/footer.jsp"%>
</body>
</html>
