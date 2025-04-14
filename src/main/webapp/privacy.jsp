<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Privacy Policy</title>
<%@include file="all_component/allcss.jsp"%>
<style>
.privacy-container {
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 50px 10px;
	max-width: 1200px;
	padding: 20px;
	background-color: transparent; /* Ensure no background color */
}

.privacy-details {
	flex: 2;
	color: #0a472e; /* Dark green text color */
}

.privacy-details h2 {
	font-size: 30px;
	color: #0a472e; /* Dark green header color */
	margin-bottom: 20px;
	font-weight: bold;
}
.privacy-details strong{
color: #0a472e;
}
.privacy-details p {
	font-size: 16px;
	line-height: 1.6;
	font-weight: bold;
	color: gray;
}

.privacy-details a {
	color: #0a472e;
	font-size: 20px;
	text-decoration: none;
	font-weight: bold;
}
</style>
</head>
<body>
	<%@include file="all_component/navbar.jsp"%>

	<div class="privacy-container">
		<div class="privacy-details">
			<h2>Privacy Policy</h2>
			<p>At Handmade Hearts, we are committed to protecting your
				privacy. This privacy policy explains how we collect, use, and
				protect your personal information.</p>
			<p>
				<strong>Information Collection:</strong> We may collect personal
				information such as your name, email address, phone number, and
				shipping address when you place an order or subscribe to our
				newsletter.
			</p>
			<p>
				<strong>Use of Information:</strong> The information we collect is
				used to process your orders, provide customer service, and send you
				updates and promotional offers. We do not share your personal
				information with third parties without your consent, except as
				required by law.
			</p>
			<p>
				<strong>Data Security:</strong> We implement a variety of security
				measures to maintain the safety of your personal information. Your
				data is stored on secure servers and accessed only by authorized
				personnel.
			</p>
			<p>
				<strong>Cookies:</strong> Our website uses cookies to enhance your
				browsing experience. You can choose to disable cookies through your
				browser settings, but this may affect the functionality of our site.
			</p>
			<p>
				If you have any questions about our privacy policy, please contact
				us at <a href="mailto:handmadehearts.org.in">handmadehearts.org.in</a>.
			</p>
		</div>
	</div>

	<%@include file="all_component/footer.jsp"%>
</body>
</html>
