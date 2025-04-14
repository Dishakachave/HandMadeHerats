<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Contact Us</title>
<%@include file="all_component/allcss.jsp"%>
<style>
  .contact-container {
    display: flex;
    align-items: center;
    justify-content: center;
   margin: 50px 10px;
    max-width: 1200px;
    padding: 20px;
    background-color: transparent; /* Ensure no background color */
  }
  .contact-image {
    flex: 1;
    margin-right: 20px;
    overflow: hidden; /* Hide any overflow from the image */
    max-width: 600px; /* Set maximum width for the image container */
  }
  .contact-image img {
    width: 100%; /* Ensure image fills its container */
    height: auto; /* Maintain aspect ratio */
    display: block; /* Remove any default spacing */
  }
  .contact-details {
    flex: 2;
    color: #0a472e; /* Dark green text color */
  }
  .contact-details h2 {
    font-size: 30px;
    color: #0a472e; /* Dark green header color */
    margin-bottom: 20px;
    font-weight: bold;
  }
  .contact-details p {
    font-size: 22px;
    line-height: 1.6;
    font-weight: bold;
  }
  .contact-details a {
    color: #0a472e;
    font-size: 20px;
    text-decoration: none;
    font-weight: bold;
  }
</style>
</head>
<body>
<%@include file="all_component/navbar.jsp"%>

<div class="contact-container">
  <div class="contact-image">
    <img src="img/Home_Bg_3.jpeg" alt="Contact Image">
  </div>
  <div class="contact-details">
    <h2>We would love to hear from you.</h2>
    <p>Leave us a message.</p>
    <p>Drop us an email on: <a href="mailto:handmadehearts.org.in">handmadehearts.org.in</a></p>
    <p>Or message us on: <a href="tel:+918541112568">+91 85411 12568</a></p>
  </div>
</div>

<%@include file="all_component/footer.jsp"%>
</body>
</html>
