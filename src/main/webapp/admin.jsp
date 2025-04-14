<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard</title>
<%@include file="all_component/allcss.jsp"%>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #fff9e1;
        color: #333;
    }
    .admin-container {
        padding: 20px;
        margin-top: 20px;
        background-color: transperent;
    }
    .admin-header {
        text-align: center;
        margin-bottom: 20px;
    }
    .admin-header img {
        width: 100px;
        height: auto;
    }
    .admin-menu {
        list-style-type: none;
        padding: 0;
        display: flex;
        justify-content: center;
        flex-wrap: wrap;
    }
    .admin-menu li {
        margin: 10px;
    }
    .admin-menu li a {
        color: #007BFF;
        text-decoration: none;
        padding: 10px 20px;
        border: 1px solid #007BFF;
        border-radius: 5px;
        transition: background-color 0.3s, color 0.3s;
    }
    .admin-menu li a:hover {
        background-color: #007BFF;
        color: #fff;
    }
    .admin-section {
        display: flex;
        justify-content: space-around;
        margin-top: 20px;
        flex-wrap: wrap;
    }
    .admin-section div {
        background-color: transperent;
        padding: 20px;
        border-radius: 8px;
        width: 45%;
        margin: 10px 0;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    .admin-section div h2 {
        margin-top: 0;
    }
    .admin-section div p {
        line-height: 1.6;
    }
    .admin-footer {
        text-align: center;
        margin-top: 20px;
    }
</style>
</head>
<body>
    <%@include file="all_component/navbar.jsp"%>
    <div class="container admin-container">
        <div class="admin-header">
            <img src="img/navtextlogo.png" alt="Site Logo">
            <h1>Welcome, Admin</h1>
        </div>
        <ul class="admin-menu">
            <li><a href="productManagement.jsp">Product Management</a></li>
        </ul>
        <div class="admin-section">
            <div class="logo">
                <p>This admin dashboard provides an overview and management tools for the site. Use the navigation links to manage products and view system information.</p>
           
                <img src="img/Handmade_Logo.png" alt="Another Image" style="width:50%; height:auto;margin-left: 95px;">
            </div>
            
        </div>
        <div class="admin-footer">
            <p>&copy; 2024 HandMadeHearts. All rights reserved.</p>
        </div>
    </div>
    <%@include file="all_component/footer.jsp"%>
</body>
</html>
