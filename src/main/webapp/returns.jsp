<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Returns</title>
<%@include file="all_component/allcss.jsp"%>
<style>
.returns-container {
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 50px 10px;
	max-width: 1200px;
	padding: 20px;
	background-color: transparent; /* Ensure no background color */
}

.returns-details {
	flex: 2;
	color: #0a472e; /* Dark green text color */
}

.returns-details h2 {
	font-size: 30px;
	color: #0a472e; /* Dark green header color */
	margin-bottom: 20px;
	font-weight: bold;
}

.returns-details strong{
color: #0a472e;
}
.returns-details p {
	font-size: 16px;
	line-height: 1.6;
	font-weight: bold;
	color: gray;
}

.returns-details a {
	color: #0a472e;
	font-size: 20px;
	text-decoration: none;
	font-weight: bold;
}
</style>
</head>
<body>
	<%@include file="all_component/navbar.jsp"%>

	<div class="returns-container">
		<div class="returns-details">
			<h2>Returns Policy</h2>
			<p>
				Since most of our products are handmade and unique, we are currently
				not accepting returns. However, in the rare situation that your
				order is received in a damaged condition, or if you have not
				received the correct items, please write to us immediately at <a
					href="mailto:handmadehearts.org.in">handmadehearts.org.in</a> and
				we shall rectify the situation.
			</p>
		</div>
	</div>

	<%@include file="all_component/footer.jsp"%>
</body>
</html>
