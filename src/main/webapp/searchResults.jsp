<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.product.ProductDetails"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Search Results</title>
<%@include file="all_component/allcss.jsp"%>

<style>
.shopnow-container-category {
	padding: 20px;
	margin-top: 20px;
}

.shopnow-category-list {
	list-style-type: none;
	padding: 0;
}

.shopnow-category-list li {
	margin: 5px 0;
}

.shopnow-category-list li a {
	color: #333;
	text-decoration: none;
}

.shopnow-category-list li a:hover {
	text-decoration: underline;
}

.form-control {
	display: block;
	width: 15%;
	padding: .375rem .75rem;
	font-size: 0.8rem;
	font-weight: bold;
	line-height: 1.5;
	margin-left: 80%;
	margin-bottom: 10px;
	color: var(--bs-body-color);
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	background-color: var(--bs-body-bg);
	background-clip: padding-box;
	border: var(--bs-border-width) solid var(--bs-border-color);
	border-radius: var(--bs-border-radius);
	transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
}

.col-md-12 {
	flex: 0 0 auto;
	width: 100%;
	margin-top: 40px;
}

.shopnow-product-card {
	border: 1px solid #ddd;
	margin-bottom: 20px;
	background-color: #fff;
	padding: 10px;
	transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
}

.shopnow-product-card img {
	width: 100%;
	height: auto;
}

.shopnow-product-card h4 {
	font-size: 12px;
	text-align: center;
	margin-top: 5px;
	color: gray;
}

.shopnow-product-card p {
	font-size: 16px;
	color: #1b5f20;
	text-align: center;
	font-weight: bolder;
}

.shopnow-product-card a.details-link {
	color: black;
	text-decoration: none;
	display: block;
	margin-top: 5px;
	padding-bottom: 20px;
	text-align: center;
	font-weight: bold;
}

.shopnow-product-card a.details-link:hover {
	color: #1b5f20;
}

.shopnow-product-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

</style>
</head>
<body class="shopnow-body">

<%@include file="all_component/navbar.jsp"%>

<div class="container-fluid">
    <div class="row">
    	<div class="col-md-3">
				<div class="shopnow-container-category">
					<h4>Explore</h4>
					<ul class="shopnow-category-list">
						<li><a class="dropdown-item" href="category.jsp?category=home_decor">Home Decor</a></li>
						<li><a class="dropdown-item" href="category.jsp?category=kitchen_dining">Kitchen & Dining</a></li>
						<li><a class="dropdown-item" href="category.jsp?category=wooden_crafts">Wooden Crafts</a></li>
						<li><a class="dropdown-item" href="category.jsp?category=textiles">Textiles</a></li>
						<li><a class="dropdown-item" href="category.jsp?category=accessories">Accessories</a></li>
						<li><a class="dropdown-item" href="category.jsp?category=gifts">Gifts</a></li>
						<li><a class="dropdown-item" href="category.jsp?category=art_collectibles">Art & Collectibles</a></li>
						<li><a class="dropdown-item" href="category.jsp?category=kids">Kids</a></li>
						<li><a class="dropdown-item" href="category.jsp?category=holiday_seasonal">Holiday & Seasonal</a></li>
						<li><a class="dropdown-item" href="category.jsp?category=outdoor_garden">Outdoor & Garden</a></li>
					</ul>

				</div>
			</div>
			<div class="col-md-9">
				<div class="row">
					<div class="col-md-12">
						<h5>
							Showing search
							results
						</h5>
						
					</div>
				</div>
				<div class="row">
        <%
            List<ProductDetails> searchResults = (List<ProductDetails>) request.getAttribute("searchResults");
            if (searchResults != null && !searchResults.isEmpty()) {
                for (ProductDetails product : searchResults) {
        %>
        <div class="col-md-3 col-sm-6">
						<div class="shopnow-product-card">
							<img src="img/<%=product.getImage()%>"
								alt="<%=product.getName()%>">
							<h4><%=product.getName()%></h4>
							<p>
								₹<%=product.getPrice()%></p>
							<a href="productDetails.jsp?id=<%=product.getId()%>"
								class="details-link">Select Options <i
								class="fa fa-angle-double-right"></i>
							</a>
						</div>
					</div>
        <%
                }
            } else {
        %>
        <div class="col-12">
            <p>No products found matching your search.</p>
        </div>
        <%
            }
        %>
    </div>
</div>

<%@include file="all_component/footer.jsp"%>
</body>
</html>
