<%@ page import="java.util.List" %>
<%@ page import="com.order.Order" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <%@include file="all_component/allcss.jsp"%>
    <style>
        .profile-card {
            margin-top: 30px;
        }
        .custom-header {
            background-color:  #fffcf0;
            color: white;
            text-align: center;
        }
        .custom-body {
            padding: 20px;
        }
        .custom-body-profile {
            background-color:  #fffcf0;
        }
        .btn-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }
        .btn-block {
            width: 200px;
            margin-top: 10px;
        }
        .orders-section {
            margin-top: 30px;
        }
        .orders-table {
            width: 100%;
            border-collapse: collapse;
        }
        .orders-table th, .orders-table td {
            border: 1px solid #dee2e6;
            padding: 8px;
            text-align: center;
        }
        .orders-table th {
            background-color: #007bff;
            color: white;
        }
        .order-actions {
            display: flex;
            justify-content: space-around;
        }
    </style>
</head>
<body>
    <header>
        <%@include file="all_component/navbar.jsp"%>
        <div class="container my-5">
            <div class="row">
                <div class="col-md-12">
                    <div class="card profile-card">
                        <div class="card-header custom-header">
                            <h4 class="header-name">User Profile</h4>
                        </div>
                        <div class="card-body custom-body custom-body-profile">
                            <% 
                            String updateMsg = (String) session.getAttribute("update-success");
                            if (updateMsg != null) {
                            %>
                            <div class="alert alert-success" role="alert"><%=updateMsg%></div>
                            <%
                            session.removeAttribute("update-success");
                            }
                            %>
                            <% 
                            String errorMsg = (String) session.getAttribute("update-failed");
                            if (errorMsg != null) {
                            %>
                            <div class="alert alert-danger" role="alert"><%=errorMsg%></div>
                            <%
                            session.removeAttribute("update-failed");
                            }
                            %>
                            <form class="forms" action="ProfileServlet" method="post">
                                <div class="form-group">
                                    <label>First Name:</label>
                                    <input type="text" class="form-control form-control-small" name="firstName" value="${user.firstName}">
                                </div>
                                <div class="form-group">
                                    <label>Last Name:</label>
                                    <input type="text" class="form-control form-control-small" name="lastName" value="${user.lastName}">
                                </div>
                                <div class="form-group">
                                    <label>Address:</label>
                                    <input type="text" class="form-control form-control-small" name="address" value="${user.address}">
                                </div>
                                <div class="form-group">
                                    <label>Phone Number:</label>
                                    <input type="text" class="form-control form-control-small" name="phoneNumber" value="${user.phoneNumber}">
                                </div>
                                <div class="btn-container">
                                    <button type="submit" class="btn btn-success">Update Profile</button>
                                    <a href="LogoutServlet" class="btn btn-success">Logout</a>
                                    <a href="index.jsp" class="btn btn-success">Keep Shopping</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
    </header>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <footer>
        <%@include file="all_component/footer.jsp"%>
    </footer>
</body>
</html>
