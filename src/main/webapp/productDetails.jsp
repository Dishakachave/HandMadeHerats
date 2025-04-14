<%@ page import="java.util.List"%>
<%@ page import="com.product.ProductDetails"%>
<%@ page import="com.dao.ProductDAO"%>
<%@ page import="com.db.DBConnect"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
int productId = 0;
ProductDetails product = null;
List<ProductDetails> relatedProducts = null;

try {
	String idParam = request.getParameter("id");
	if (idParam != null && !idParam.isEmpty()) {
		productId = Integer.parseInt(idParam);
	}

	Connection conn = DBConnect.getConn(); // Use DBConnect to get the connection
	ProductDAO productDAO = new ProductDAO(conn);
	product = productDAO.getProductById(productId);
	relatedProducts = productDAO.getRelatedProducts(productId);

	request.setAttribute("product", product);
	request.setAttribute("relatedProducts", relatedProducts);
} catch (NumberFormatException e) {
	e.printStackTrace();
	// Handle invalid product ID format
} catch (SQLException e) {
	e.printStackTrace();
	// Handle SQL exceptions
} catch (ClassNotFoundException e) {
	e.printStackTrace();
	// Handle Class not found exception
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%=product != null ? product.getName() : "Product Details"%></title>
<%@ include file="all_component/allcss.jsp"%>
<style>
/* Custom styles for product details page */
.product-details-container {
	padding: 20px;
	margin-top: 50px;
	background-color: #fefbf2;
	border: 1px solid white;
}

.product-details-img {
	width: 100%;
	border-radius: 10px;
}

.product-details-info {
	padding-left: 20px;
}

.product-details-info h1, .product-details-info h4 {
	color: #0a472e;
}

.product-details-info h1 {
	font-size: 30px;
	margin-bottom: 0.4em;
}

.product-details-info h4 {
	font-size: 24px;
	margin-bottom: 0.6em;
	font-weight: 700;
}

.product-details-info p {
	font-size: 16px;
	margin: 10px 0;
}

.qty-container {
	display: flex;
	align-items: center;
	margin: 10px 0;
}

.qty-container button {
	background-color: #fefbf2;
	border: 1px solid #ddd;
	border-radius: 50%;
	cursor: pointer;
	width: 38px;
	height: 38px;
	font-size: 18px;
	color: #0a472e;
	text-align: center;
}

.qty-container button:hover {
	background-color: #ff6347;
}

.qty-container input {
	width: 100px;
	color: black;
	background-color: white;
	text-align: center;
	border: 1px solid #ddd;
	height: 45px;
	margin: 0 5px;
	border-radius: 25px;
}

.add-to-cart-btn {
	color: #ffffff;
	background-color: #0a472e;
	padding: 18px 44px;
	border: none;
	border-radius: 26px;
	font-weight: 700;
	font-size: 12px;
	transition: background-color 0.3s ease-in-out;
}

.add-to-cart-btn:hover {
	color: #1b5f20;
	background-color: #ffffff;
}

.add-to-wishlist {
	color: #000;
	background-color: transparent;
	font-size: 15px;
	font-weight: 700;
	margin-top: 16px;
	display: inline-block;
}

.add-to-wishlist:hover {
	color: #1b5f20;
}

.stock-status {
	font-size: 10px;
	text-transform: uppercase;
	display: inline-block;
	padding: 5px 10px;
	color: #000;
	background: #defaf2;
	margin-bottom: 15px;
}

.out-of-stock {
	color: red;
}

.container-category {
	background-color: #fff9e1;
}

.related-products {
	margin-top: 40px;
}

.related-products h4 {
	font-size: 24px;
	margin-bottom: 20px;
}

.product-card {
	background-color: #fff;
	padding: 10px;
	transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
}

.product-card img {
	width: 100%;
}

.product-card h4 {
	font-size: 18px;
	margin: 10px 0;
	text-align: center;
	color: #333;
}

.product-card p {
	font-size: 16px;
	text-align: center;
	font-weight: bold;
	color: #555;
}

.product-card a.details-link {
	color: black;
	text-decoration: none;
	display: block;
	margin-top: 5px;
	padding-bottom: 20px;
	text-align: center;
	font-weight: bold;
}

.product-card a.details-link:hover {
	color: #1b5f20;
}

.product-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

@media ( max-width : 768px) {
	.product-details-info {
		padding: 0;
		text-align: center;
	}
	.product-details-info h1, .product-details-info h4 {
		font-size: 20px;
	}
	.qty-container {
		justify-content: center;
	}
	.add-to-cart-btn, .add-to-wishlist-btn {
		width: 100%;
	}
}
</style>
</head>
<body>
	<%@ include file="all_component/navbar.jsp"%>

	<div class="container product-details-container">
		<div class="row">
			<div class="col-md-6">
				<img id="mainProductImage"
					src="img/<%=product != null ? product.getImage() : "default.jpg"%>"
					alt="Product Image" class="product-details-img">
			</div>
			<div class="col-md-6 product-details-info">
				<%
				if (product != null) {
				%>
				<span
					class="stock-status <%=product.isInStock() ? "in-stock" : "out-of-stock"%>">
					<%=product.isInStock() ? "In Stock" : "Out of Stock"%>
				</span>
				<h1><%=product.getName()%></h1>
				<h4>
					₹<%=product.getPrice()%></h4>
				<form action="AddToCartServlet" method="post">
					<div class="qty-container">
						<button type="button"
							onclick="document.getElementById('qtyInput').stepDown()">
							<i class="fa fa-angle-down"></i>
						</button>
						<input type="number" id="qtyInput" name="quantity" value="1"
							min="1" max="10">
						<button type="button"
							onclick="document.getElementById('qtyInput').stepUp()">
							<i class="fa fa-angle-up"></i>
						</button>
					</div>
					<input type="hidden" name="productId"
						value="<%=product.getId()%>">
					<button type="submit" class="add-to-cart-btn">Add to Cart</button>
				</form>
				<form action="AddToWishlistServlet" method="post" style="display: inline;">
					<input type="hidden" name="productId"
						value="<%=product.getId()%>">
					<button type="submit" class="add-to-wishlist">
						<i class="fa fa-heart-o"> Add to Wishlist</i>
					</button>
				</form>
				<hr>
				<p><%=product.getDescription()%></p>
				<%
				} else {
				%>
				<p>Product not found.</p>
				<%
				}
				%>
			</div>
		</div>
	</div>

	<%
	if (relatedProducts != null && !relatedProducts.isEmpty()) {
	%>
	<div class="container-category">
		<div class="small-container">
			<h2 class="related-products-title">Related Products</h2>
			<div class="row">
				<%
				for (ProductDetails relatedProduct : relatedProducts) {
				%>
				<div class="col-md-3">
					<div class="product-card">
						<img src="img/<%=relatedProduct.getImage()%>"
							alt="<%=relatedProduct.getName()%>">
						<h4><%=relatedProduct.getName()%></h4>
						<p>
							₹<%=relatedProduct.getPrice()%></p>
						<a href="productDetails.jsp?id=<%=relatedProduct.getId()%>"
							class="details-link">View Details</a>
					</div>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</div>
	<%
	}
	%>

	<%@ include file="all_component/footer.jsp"%>
</body>
</html>
