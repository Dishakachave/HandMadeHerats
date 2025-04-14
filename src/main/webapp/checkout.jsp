<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.product.ProductDetails" %>
<%@ page import="com.user.UserDetails"%>
<%@ page import="com.dao.CartDAO" %>
<%@ page import="com.db.DBConnect" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>

<%
    UserDetails user = (UserDetails) session.getAttribute("user");
    List<ProductDetails> cartItems = null;
    double total = 0.0;

    if (user != null) {
        try {
            Connection conn = DBConnect.getConn();
            CartDAO cartDAO = new CartDAO(conn);
            cartItems = cartDAO.getCartItems(user.getId());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    } else {
        response.sendRedirect("register.jsp?message=Please login to view your cart");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <!-- Include your CSS styles -->
<%@include file="all_component/allcss.jsp"%>
<style>
    body {
        font-family: Arial, sans-serif;
    }
    .checkout-page {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }
    h2, h3 {
        color: #0a472e; /* Dark green text color */
    }
    .order-details, .shipping-details {
        margin-bottom: 30px;
    }
    .cart-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }
    .cart-table th, .cart-table td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: left;
    }
    .cart-table th {
        background-color: #f4f4f4;
    }
    .cart-table td {
        vertical-align: middle;
    }
    .cart-table td:nth-child(3), .cart-table td:nth-child(4) {
        text-align: right;
    }
    .shipping-details form {
        display: flex;
        flex-direction: column;
    }
    .shipping-details label {
        margin-bottom: 5px;
        font-weight: bold;
    }
    .shipping-details input, .shipping-details textarea {
        margin-bottom: 10px;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        width: 100%;
        max-width: 400px;
    }
    .shipping-details button {
        padding: 10px 20px;
        background-color: #0a472e;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
    }
    .shipping-details button:hover {
        background-color: #083b24;
    }
    @media (max-width: 768px) {
        .cart-table, .shipping-details form {
            font-size: 14px;
        }
        .shipping-details input, .shipping-details textarea, .shipping-details button {
            max-width: 100%;
        }
    }
</style>
</head>
<body>
    <%@include file="all_component/navbar.jsp"%>

    <div class="container checkout-page">
        <h2>Review Your Order Details</h2>

        <div class="order-details">
            <h3>Cart Items</h3>
            <table class="cart-table">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (cartItems != null && !cartItems.isEmpty()) {
                        for (ProductDetails item : cartItems) { 
                            double itemTotal = item.getPrice() * item.getQuantity();
                            total += itemTotal;
                    %>
                    <tr>
                        <td><%= item.getName() %></td>
                        <td><%= item.getQuantity() %></td>
                        <td>₹<%= item.getPrice() %></td>
                        <td>₹<%= itemTotal %></td>
                    </tr>
                    <% } } %>
                    <tr>
                        <th colspan="3">Subtotal</th>
                        <td>₹<%= total %></td>
                    </tr>
                    <tr>
                        <th colspan="3">Shipping Charges</th>
                        <td>₹70</td>
                    </tr>
                    <tr>
                        <th colspan="3">Grand Total</th>
                        <td>₹<%= total + 70 %></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="shipping-details">
            <h3>Shipping Information</h3>
            <form action="PlaceOrderServlet" method="post">
                <label for="fullName">Full Name:</label>
                <input type="text" id="fullName" name="fullName" required>
                <br>
                <label for="address">Address:</label>
                <textarea id="address" name="address" required></textarea>
                <br>
                <button type="submit">Place Order</button>
            </form>
        </div>
    </div>

    <%@include file="all_component/footer.jsp"%>

</body>
</html>
