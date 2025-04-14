<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>About</title>
<%@include file="all_component/allcss.jsp"%>
<style>
#sect1 {
	background-image: url("img/Home_Bg_1.webp");
	background-size: cover;
	background-repeat: no-repeat;
	background-attachment: fixed;
	width: 100%;
	height: 45vh;
	position: relative;
	border-bottom-left-radius: 50%;
	border-bottom-right-radius: 50%;
}

.dark-opacity {
	background-color: rgba(0, 0, 0, 0.2);
	height: 100%;
	width: 100%;
	position: absolute;
	top: 0;
	left: 0;
	border-bottom-left-radius: 50%;
	border-bottom-right-radius: 50%;
}

#section {
	text-align: center;
	margin-top: 48px;
	margin-bottom: 32px;
	position: relative;
}

.border {
	border: 3px solid rgb(10, 71, 46);
	width: 80px;
	margin: auto;
	margin-bottom: 32px;
	display: block;
	height: 0;
}

h2 {
	margin-top: 16px;
	font-weight: 500;
	color: #1b5f20;
	font-size: 60px;
	margin-bottom: 32px;
}

p {
	margin: 16px 0; /* Ensure spacing around text */
}

#purpose-txt {
	background-color: white;
	font-size: 18px;
	font-weight: 300;
	padding: 3rem;
	border-radius: 5px;
	margin-left: 4rem;
	margin-right: 4 rem;
	box-shadow: 0 1px 5px rgba(0, 0, 0, 0.2);
	width: 1300px;
	margin: auto;
	margin-bottom: 3rem;
}

 /* Responsive adjustments */
        @media screen and (max-width: 768px) {
            h2 {
                font-size: 40px; /* Decrease font size for smaller screens */
            }
            #purpose-txt {
                padding: 10px; /* Decrease padding for smaller screens */
            }
        }
</style>
</head>
<body>
	<%@include file="all_component/navbar.jsp"%>

	<div>
		<div id="sect1">
			<div class="dark-opacity"></div>
		</div>
		<div id="section">
			<div class="border"></div>
			<h2>OUR PURPOSE</h2>
			<div id="purpose-txt">
				<p style="width: 1000px; margin: auto">At HandMadeHearts, our
					purpose is to craft unique and heartfelt creations that bring joy
					and warmth to every home. We believe in the power of handmade
					artistry to inspire and connect people through meaningful gifts and
					décor. Our passion lies in creating beautifully crafted products
					that reflect love, creativity, and craftsmanship. Each piece tells
					a story and carries a piece of our dedication to quality and
					authenticity. Join us in celebrating the art of handmade and
					spreading love one heart at a time.</p>
			</div>
		</div>
	</div>
	<div id="section">
		<div class="border"></div>
		<h2>SUSTAINABILITY</h2>
		<div id="purpose-txt">
			<p style="width: 1000px; margin: auto">At HandMadeHearts,
				sustainability is at the heart of everything we do. We are committed
				to creating products that are not only beautiful and unique but also
				eco-friendly. We use ethically sourced materials and prioritize
				sustainable production practices. By supporting HandMadeHearts, you
				are contributing to a more sustainable future, where craftsmanship
				meets environmental responsibility. Together, we can make a
				difference, one handmade creation at a time.</p>
		</div>
	</div>

	<div id="section">
		<div class="border"></div>
		<h2>LOCAL INDIA SUPPORT</h2>
		<div id="purpose-txt">
			<p style="width: 1000px; margin: auto">HandMadeHearts proudly
				supports the Government of India's initiative to promote local
				artisans and craftsmanship. We collaborate with local artisans
				across India, celebrating their traditional skills and providing
				them with a platform to showcase their talent globally. By choosing
				HandMadeHearts, you are not only acquiring a piece of handcrafted
				artistry but also contributing to the preservation of India's rich
				cultural heritage and empowering local communities.</p>
		</div>
	</div>


	<div id="section">
		<div class="getting-involved" ></div>
		<h2>Getting Involved</h2>
		<p style="color:#0a472e; font-weight: bolder; font-size: 25px;margin-left:25px;text-align: center;">
			We are looking for enthusiastic, lively volunteers like you to help
			us in specific areas. Do write in to us at <a
				href="mailto:handmadehearts.org.in">handmadehearts.org.in</a> with
			details about yourself and your area(s) of interest.
		</p>
	</div>
<%@include file="all_component/footer.jsp"%>

</body>
</html>
