<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Shipping</title>
<%@include file="all_component/allcss.jsp"%>
<style>
  .shipping-container {
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 50px 10px;
    max-width: 1200px;
    padding: 20px;
    background-color: transparent; /* Ensure no background color */
  }
  .shipping-details {
    flex: 2;
    color: #0a472e; /* Dark green text color */
  }
  .shipping-details h2 {
    font-size: 30px;
    color: #0a472e; /* Dark green header color */
    margin-bottom: 20px;
    font-weight: bold;
  }
 .shipping-details strong{
color: #0a472e;
}
.shipping-details p {
	font-size: 16px;
	line-height: 1.6;
	font-weight: bold;
	color: gray;
}
  .shipping-details a {
    color: #0a472e;
    font-size: 20px;
    text-decoration: none;
    font-weight: bold;
  }
</style>
</head>
<body>
<%@include file="all_component/navbar.jsp"%>

<div class="shipping-container">
  <div class="shipping-details">
    <h2>Shipping Information</h2>
    <p>We strive to deliver your orders in the fastest and most efficient manner. Below are our shipping policies:</p>
    <p><strong>Processing Time:</strong> Orders are processed within 2-3 business days.</p>
    <p><strong>Shipping Time:</strong> Depending on your location, shipping time may vary from 5-10 business days.</p>
    <p><strong>Shipping Charges:</strong> Shipping charges are calculated at checkout based on your location and the weight of your order.</p>
    <p>If you have any questions about your order, please contact us at <a href="mailto:handmadehearts.org.in">handmadehearts.org.in</a>.</p>
  </div>
</div>

<%@include file="all_component/footer.jsp"%>
</body>
</html>
