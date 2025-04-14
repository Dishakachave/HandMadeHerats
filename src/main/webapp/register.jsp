<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register Page</title>
<%@include file="all_component/allcss.jsp"%>
</head>
<body>
    <header>
        <%@include file="all_component/navbar.jsp"%>

        <div class="container my-5">
            <div class="row">
                <!-- Login Form -->
                <div class="col-md-6">
                    <div class="card login-card">
                        <div class="card-header custom-header headername-login">
                            <h4 class="header-name">Login</h4>
                        </div>
                        <div class="card-body custom-body custom-body-login">
                            <%
                            String loginFailedMsg = (String) session.getAttribute("login-failed");
                            if (loginFailedMsg != null) {
                            %>
                            <div class="alert alert-danger" role="alert"><%=loginFailedMsg%></div>
                            <%
                            session.removeAttribute("login-failed");
                            }
                            %>
                            <form class="forms" action="LoginServlet" method="post">
                                <div class="form-group">
                                    <label for="loginEmail">Email address<span>*</span></label>
                                    <input type="email" class="form-control form-control-small" id="loginEmail" name="email" placeholder="Enter email">
                                </div>
                                <div class="form-group">
                                    <label for="loginPassword">Password<span>*</span></label>
                                    <input type="password" class="form-control form-control-small" id="loginPassword" name="password" placeholder="Password">
                                </div>
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input" id="loginCheck" name="remember">
                                    <label class="form-check-label" for="loginCheck">Remember me</label>
                                </div>
                                <button type="submit" class="btn btn-success btn-block">Login</button>
                                <a href="forgotPassword.jsp" class="forgot-password-link">Forgot Password?</a>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- Register Form -->
                <div class="col-md-6">
                    <div class="card register-card">
                        <div class="card-header custom-header">
                            <h4 class="header-name">Register</h4>
                        </div>
                        <%
                        String regMsg = (String) session.getAttribute("reg-success");
                        if (regMsg != null) {
                        %>
                        <div class="alert alert-success" role="alert"><%=regMsg%></div>
                        <%
                        session.removeAttribute("reg-success");
                        }
                        %>
                        <%
                        String failedMsg = (String) session.getAttribute("failed-msg");
                        if (failedMsg != null) {
                        %>
                        <div class="alert alert-danger" role="alert"><%=failedMsg%></div>
                        <%
                        session.removeAttribute("failed-msg");
                        }
                        %>
                        <div class="card-body custom-body custom-body-register">
                            <form class="forms" action="UserServlet" method="post">
                                <div class="form-group">
                                    <label>Enter Full Name</label>
                                    <input type="text" class="form-control form-control-small" id="registerName" name="fname">
                                </div>
                                <div class="form-group">
                                    <label>Enter Email</label>
                                    <input type="email" class="form-control form-control-small" id="registerEmail" name="uemail">
                                </div>
                                <div class="form-group">
                                    <label for="registerPassword">Enter Password<span>*</span></label>
                                    <input type="password" class="form-control form-control-small" id="registerPassword" name="upassword">
                                </div>
                                <div class="form-group">
                                    <label for="securityQuestion">Security Question<span>*</span></label>
                                    <select class="form-control form-control-small" id="securityQuestion" name="securityQuestion">
                                        <option value="What is your pet's name?">What is your pet's name?</option>
                                        <option value="What is your mother's maiden name?">What is your mother's maiden name?</option>
                                        <option value="What is your favorite color?">What is your favorite color?</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="securityAnswer">Answer<span>*</span></label>
                                    <input type="text" class="form-control form-control-small" id="securityAnswer" name="securityAnswer">
                                </div>
                                <button type="submit" class="btn btn-success btn-block">Register</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const urlParams = new URLSearchParams(window.location.search);
            const showLogin = urlParams.get('showLogin');
            const showRegister = urlParams.get('showRegister');
            
            if (showLogin) {
                document.getElementById('loginEmail').focus();
            }

            if (showRegister) {
                document.getElementById('registerName').focus();
            }
        });
    </script>
    <footer>
        <%@include file="all_component/footer.jsp"%>
    </footer>
</body>
</html>
