<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="all_component/allcss.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <style>
        .order-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            border-radius: 8px;
        }
        .order-container h2 {
            color: #0a472e;
            font-size: 28px;
            margin-bottom: 20px;
        }
        .order-container p {
            font-size: 18px;
            margin-bottom: 30px;
            color: #333;
        }
        .order-container .btn {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            background-color: #0a472e;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .order-container .btn:hover {
            background-color: #083b24;
        }
        @media (max-width: 768px) {
            .order-container {
                padding: 10px;
                margin: 20px;
            }
            .order-container h2 {
                font-size: 24px;
            }
            .order-container p {
                font-size: 16px;
            }
            .order-container .btn {
                padding: 8px 16px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <%@ include file="all_component/navbar.jsp"%>

    <div class="order-container">
        <h2>Order Confirmation</h2>
        <p><%= session.getAttribute("message") %></p>
        <a href="index.jsp" class="btn">Continue Shopping</a>
    </div>

    <%@ include file="all_component/footer.jsp"%>
</body>
</html>
