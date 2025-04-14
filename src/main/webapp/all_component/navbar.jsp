<%@ page import="com.user.UserDetails"%>

<nav class="navbar navbar-expand-lg navbar-dark bg-custom navbar-custom">
	<div class="container-fluid">
		<a class="navbar-brand" href="#"> <img src="img/navtextlogo.png"
			alt="HandMadeHearts Logo" class="logo-image">
		</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon custom-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="index.jsp">Home</a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="shopNow.jsp"
					id="shopNowLink" data-bs-toggle="dropdown" aria-expanded="false">
						Shop Now </a>
					<ul class="dropdown-menu" aria-labelledby="shopNowLink">
						<li><a class="dropdown-item"
							href="category.jsp?category=home_decor">Home Decor</a></li>
						<li><a class="dropdown-item"
							href="category.jsp?category=kitchen_dining">Kitchen & Dining</a></li>
						<li><a class="dropdown-item"
							href="category.jsp?category=wooden_crafts">Wooden Crafts</a></li>
						<li><a class="dropdown-item"
							href="category.jsp?category=textiles">Textiles</a></li>
						<li><a class="dropdown-item"
							href="category.jsp?category=accessories">Accessories</a></li>
						<li><a class="dropdown-item"
							href="category.jsp?category=gifts">Gifts</a></li>
						<li><a class="dropdown-item"
							href="category.jsp?category=art_collectibles">Art &
								Collectibles</a></li>
						<li><a class="dropdown-item"
							href="category.jsp?category=kids">Kids</a></li>
						<li><a class="dropdown-item"
							href="category.jsp?category=holiday_seasonal">Holiday &
								Seasonal</a></li>
						<li><a class="dropdown-item"
							href="category.jsp?category=outdoor_garden">Outdoor & Garden</a></li>
					</ul></li>

				<li class="nav-item"><a class="nav-link" href="about.jsp">About HandMadeHearts</a></li>

				<li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
			</ul>
			<form class="d-flex" role="search" action="SearchServlet"
				method="get">
				<input class="form-cont me-2" type="search" name="query"
					placeholder="Search products" aria-label="Search">
				<button class="btn btn-outline-success" type="submit">Search</button>
			</form>


			<%
			// Check if user is logged in
			UserDetails loggedInUser = (UserDetails) session.getAttribute("user");
			if (loggedInUser != null) {
			%>
			<a class="header-account" href="profile.jsp"><i
				class="bi bi-person-fill"></i></a>
			<%
			}
			%>


			<a class="header-wishlist" href="wishlist.jsp"> <i
				class="bi bi-heart-fill"></i> <span class="count"> <%
 Integer wishlistCount = (Integer) session.getAttribute("wishlistCount");
 if (wishlistCount != null) {
 	out.print(wishlistCount);
 } else {
 	out.print("0");
 }
 %>
			</span>
			</a> <a class="header-cart" href="cart.jsp"> <i
				class="bi bi-cart-fill"></i> <span class="count"> <%
 Integer cartCount = (Integer) session.getAttribute("cartCount");
 if (cartCount != null) {
 	out.print(cartCount);
 } else {
 	out.print("0");
 }
 %>
			</span>
			</a>




		</div>
	</div>
	<script>
		document.addEventListener('DOMContentLoaded', function() {
			const shopNowLink = document.getElementById('shopNowLink');
			const dropdown = shopNowLink.nextElementSibling;

			shopNowLink.addEventListener('mouseover', function() {
				const bootstrapDropdown = new bootstrap.Dropdown(shopNowLink);
				bootstrapDropdown.show();
			});

			dropdown.addEventListener('mouseleave', function() {
				const bootstrapDropdown = new bootstrap.Dropdown(shopNowLink);
				bootstrapDropdown.hide();
			});

			shopNowLink.addEventListener('click', function(event) {
				event.preventDefault();
				window.location.href = shopNowLink.href;
			});
		});
	</script>

</nav>
