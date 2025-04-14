<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Forgot Password</title>
<%@include file="all_component/allcss.jsp"%>

</head>
<body>

	<body>
    <header>
        <%@include file="all_component/navbar.jsp"%>

        <div class="container my-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card forgot-password-card">
                        <div class="card-header custom-header">
                            <h4 class="header-name">Forgot Password</h4>
                        </div>
                        <div class="card-body custom-body custom-body-forgot-password">
                            <%
                            String errorMsg = (String) session.getAttribute("error-msg");
                            if (errorMsg != null) {
                            %>
                            <div class="alert alert-danger" role="alert"><%=errorMsg%></div>
                            <%
                            session.removeAttribute("error-msg");
                            }
                            %>
                            <form class="forms" action="ForgotPasswordServlet" method="post">
                                <div class="form-group">
                                    <label for="email">Email address<span>*</span></label>
                                    <input type="email" class="form-control form-control-small" id="email" name="email" placeholder="Enter email">
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
                                <div class="form-group">
                                    <label for="newPassword">New Password<span>*</span></label>
                                    <input type="password" class="form-control form-control-small" id="newPassword" name="newPassword" placeholder="Enter new password">
                                </div>
                                <button type="submit" class="btn btn-success btn-block">Reset Password</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <footer>
        <%@include file="all_component/footer.jsp"%>
    </footer>
</body>
	
</body>
</html>