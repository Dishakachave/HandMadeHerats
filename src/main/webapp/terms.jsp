<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Terms and Conditions</title>
<%@include file="all_component/allcss.jsp"%>
<style>
.terms-container {
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 50px 10px;
	max-width: 1200px;
	padding: 20px;
	background-color: transparent; /* Ensure no background color */
}

.terms-details {
	flex: 2;
	color: #0a472e; /* Dark green text color */
}

.terms-details h2 {
	font-size: 30px;
	color: #0a472e; /* Dark green header color */
	margin-bottom: 20px;
	font-weight: bold;
}

.terms-details strong{
color: #0a472e;
}
.terms-details p {
	font-size: 16px;
	line-height: 1.6;
	font-weight: bold;
	color: gray;
}

.terms-details a {
	color: #0a472e;
	font-size: 20px;
	text-decoration: none;
	font-weight: bold;
}
</style>
</head>
<body>
	<%@include file="all_component/navbar.jsp"%>

	<div class="terms-container">
		<div class="terms-details">
			<h2>Terms and Conditions</h2>
			<p>Welcome to our website. If you continue to browse and use this
				website, you are agreeing to comply with and be bound by the
				following terms and conditions of use, which together with our
				privacy policy govern Handmade Hearts's relationship with you in
				relation to this website.</p>
			<p>If you disagree with any part of these terms and conditions,
				please do not use our website.</p>
			<p>
				<strong>Use of the Site:</strong> The content of the pages of this
				website is for your general information and use only. It is subject
				to change without notice.
			</p>
			<p>
				<strong>Privacy:</strong> Your use of this website is also subject
				to our Privacy Policy. Please review our Privacy Policy, which also
				governs the Site and informs users of our data collection practices.
			</p>
			<p>
				<strong>Limitation of Liability:</strong> Neither we nor any third
				parties provide any warranty or guarantee as to the accuracy,
				timeliness, performance, completeness or suitability of the
				information and materials found or offered on this website for any
				particular purpose.
			</p>
			<p>
				If you have any questions about our terms and conditions, please
				contact us at <a href="mailto:handmadehearts.org.in">handmadehearts.org.in</a>.
			</p>
		</div>
	</div>

	<%@include file="all_component/footer.jsp"%>
</body>
</html>
