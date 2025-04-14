<%@page import="java.sql.Connection"%>
<%@page import="com.db.DBConnect"%>
<%@page import="java.util.List"%>
<%@page import="com.product.ProductDetails"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.back-img {
	background: linear-gradient(rgba(0, 0, 0, .5), rgba(0, 0, 0, .5)),
		url("img/Home_Bg_2.jpg");
	background-position: center;
	background-size: cover;
	background-repeat: no-repeat;
	height: 100vh;
	position: relative;
	display: flex;
	align-items: center;
	justify-content: center;
	text-align: center;
}

.back-img .text {
	position: relative;
	z-index: 1;
}

.back-img::after {
	content: '';
	position: absolute;
	width: 100%;
	height: 100%;
	top: 0;
	left: 0;
	background: rgba(0, 0, 0, .5);
}

.back-img img {
	max-width: 100%;
	height: auto;
}

.btn-category {
	font-family: "Mazzard Soft H";
	border: none;
	text-decoration: none;
	text-align: left;
	line-height: 18px;
	letter-spacing: 0px;
	font-weight: 700;
	font-size: 18px;
	padding: 18px 44px;
	transform-origin: 50% 50%;
	transition: background-color 0.3s ease-in-out;
}

@
keyframes fadeInUp { 0% {
	opacity: 0;
	transform: translateY(20px);
}

100






%
{
opacity






:






1




;
transform






:






translateY




(






0






)




;
}
}
.hidden {
	opacity: 0;
	transition: opacity 0.5s ease-in-out, transform 0.5s ease-in-out;
}

.visible {
	opacity: 1;
	transform: translateY(0);
}

#why-choose .row {
	margin-bottom: 20px;
}

#why-choose  h5 {
	font-size: 1.25rem;
	text-transform: uppercase;
	color: #1b5f20;
	font-weight: 900;
}

p {
	margin-top: 0;
	margin-bottom: 1rem;
	color: gray;
	font-weight: 600;
}

#why-choose .col-md-4 {
	opacity: 0;
	transform: translateY(20px);
	transition: opacity 1s ease, transform 1s ease;
}

#why-choose .col-md-4.visible {
	opacity: 1;
	transform: translateY(0);
}
</style>
<meta charset="ISO-8859-1">
<title>Home Page</title>
<%@include file="all_component/allcss.jsp"%>
</head>
<body>
	<%@include file="all_component/navbar.jsp"%>

<div>
	<div class="container-fluid back-img">
		<div class="text">
			<img src="img/Handmade_Logo.png" class="logo">
			<div class="tagline">
				Crafted with <span>Love</span>, Made by <span>Hand</span>
			</div>
			<div class="explore-products">
				<a href="shopNow.jsp" class="btn btn-explore">Explore Our
					Products <i class="fa fa-angle-double-right"></i>
				</a>
			</div>
		</div>
	</div>

	<!-- Featured Categories -->
	<div class="container-category">
		<div class="small-container">
			<h2 class="title">Most Loved Categories</h2>
			<div class="row">

				<div class="col-md-4 col-3">
					<div class="card">
						<img src="img/textileCategory.jpg" class="card-img-top" alt="Category 1">
						<div class="card-body">
							<h5 class="card-title" style="text-transform: uppercase; font-weight: 800;">Texttiles</h5>
							<p class="card-text">Explore our collection of Textile
								products.</p>
							<a href="category.jsp?category=textiles" class="btn btn-category"
								style="color: #bc3726; white-space: nowrap; line-height: 18px; letter-spacing: 0px; font-weight: 700; font-size: 18px; padding: 18px 44px; transform-origin: 50% 50%; transition: background-color 0.3s ease-in-out;">View
								Products&#8594</a>
						</div>
					</div>
				</div>

				<div class="col-md-4 col-3">
					<div class="card">
						<img src="img/acessoriesCategory.jpeg" class="card-img-top" alt="Category 2">
						<div class="card-body">
							<h5 class="card-title"style="text-transform: uppercase; font-weight: 800;">Accessories</h5>
							<p class="card-text">Discover the latest arrivals in Accessories.</p>
							<a href="category.jsp?category=accessories" class="btn btn-category"
								style="color: #bc3726; white-space: nowrap; line-height: 18px; letter-spacing: 0px; font-weight: 700; font-size: 18px; padding: 18px 44px; transform-origin: 50% 50%; transition: background-color 0.3s ease-in-out;">View
								Products&#8594</a>
						</div>
					</div>
				</div>

				<div class="col-md-4 col-3">
					<div class="card">
						<img src="img/kitchenCategory2.jpeg" class="card-img-top" alt="Category 3">
						<div class="card-body">
							<h5 class="card-title" style="text-transform: uppercase; font-weight: 800;">Kitchen & Dinning</h5>
							<p class="card-text">Find unique products for your kitchen.</p>
							<a href="category.jsp?category=kitchen_dining" class="btn btn-category"
								style="color: #bc3726; white-space: nowrap; line-height: 18px; letter-spacing: 0px; font-weight: 700; font-size: 18px; padding: 18px 44px; transform-origin: 50% 50%; transition: background-color 0.3s ease-in-out;">View
								Products&#8594</a>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="small-container">
			<h2 class="title">Why Choose HandMadeHearts?</h2>
			<div id="why-choose" class="row">
				<div class="col-md-4" style="--animation-order: 1;">
					<h5>Our Story</h5>
					<p>HandMadeHearts is more than just a brand; it's a story of
						passion, creativity, and dedication to craft.</p>
				</div>
				<div class="col-md-4" style="--animation-order: 2;">
					<h5>Community Impact</h5>
					<p>By choosing us, you support local artisans and help sustain
						their livelihoods and traditions.</p>
				</div>
				<div class="col-md-4" style="--animation-order: 3;">
					<h5>Innovative Designs</h5>
					<p>We blend traditional craftsmanship with modern design to
						create unique and timeless pieces.</p>
				</div>
				<div class="col-md-4" style="--animation-order: 4;">
					<h5>Customization</h5>
					<p>We offer bespoke services to create personalized items that
						cater to your individual preferences.</p>
				</div>
				<div class="col-md-4" style="--animation-order: 5;">
					<h5>Ethical Practices</h5>
					<p>Our production process adheres to fair trade practices,
						ensuring ethical treatment of artisans.</p>
				</div>
				<div class="col-md-4" style="--animation-order: 6;">
					<h5>Exceptional Experience</h5>
					<p>We strive to provide a seamless and delightful shopping
						experience for all our customers.</p>
				</div>
			</div>
		</div>

		<!-----offer----->
		<div class="container-category">
			<div class="offer">
				<div class="small-container">
					<div class="row">
						<div class="col-md-6 col-12">
							<img src="img/string_art-removebg-preview.png" class="offer-img"
								alt="Craft Image">
						</div>
						<div class="col-md-6 col-12">
							<p>Exclusively at HandMadeHearts</p>
							<h1>Limited Edition Crafts</h1>
							<small>Discover our exclusive range of limited edition
								handcrafted items. Each piece is designed with care and
								creativity, ensuring you own something truly special.</small> <a href="category.jsp?category=gifts"
								class="btn btn-explore">Buy Now &#8594</a>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="container-items">
			<div class="small-container">
				<div class="row">
					<!-- First Item -->
					<div class="col-md-4 col-5 item">
						<img src="img/shape1.png" alt="Shape 1">
						<div class="text">
							<h5>Handmade</h5>
							<small>Made with passion by our community</small>
						</div>
					</div>
					<!-- Second Item -->
					<div class="col-md-4 col-5 item">
						<img src="img/shape2.png" alt="Shape 2">
						<div class="text">
							<h5>100% Natural</h5>
							<small>Shop local, Eat local, support small farmers,
								workers</small>
						</div>
					</div>
					<!-- Third Item -->
					<div class="col-md-4 col-5 item">
						<img src="img/shape3.png" alt="Shape 3">
						<div class="text">
							<h5>Shipping</h5>
							<small>Across India</small>
						</div>
					</div>
					<!-- Fourth Item -->
					<div class="col-md-4 col-5 item">
						<img src="img/shape4.png" alt="Shape 4">
						<div class="text">
							<h5>Craftmark</h5>
							<small>Hand made in India</small>
						</div>
					</div>
					<!-- Fifth Item -->
					<div class="col-md-4 col-5 item">
						<img src="img/shape5.png" alt="Shape 5">
						<div class="text">
							<h5>Quality</h5>
							<small>Best quality products</small>
						</div>
					</div>
				</div>
			</div>
		</div>
</div>
<script>
document.addEventListener('DOMContentLoaded', function () {
    const elements = document.querySelectorAll('#why-choose .col-md-4');
    const observer = new IntersectionObserver(entries => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
                observer.unobserve(entry.target);
            }
        });
    }, {
        threshold: 0.5
    });

    elements.forEach(element => {
        observer.observe(element);
    });
});
</script>

<footer style="width: 100%;">

		    <%@include file="all_component/footer.jsp"%>
</footer>
</body>

</html>
