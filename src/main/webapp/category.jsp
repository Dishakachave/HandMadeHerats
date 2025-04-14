<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.product.ProductDetails"%>
<%@ page import="com.dao.ProductDAO"%>
<%@ page import="com.db.DBConnect"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Category</title>
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

.page-btn {
	margin: 20px auto 80px;
	text-align: center;
}

.page-btn .pagination-style {
	color: #999;
	font-weight: bold;
	margin-left: 10px;
	width: 30px;
	height: 30px;
	display: inline-block;
	border: none;
	text-align: center;
	border-radius: 50%;
	line-height: 30px;
	cursor: pointer;
}

.page-btn .pagination-style:hover {
	border: 1px solid #1b5f20;
	background-color: #0a472e;
}
</style>
</head>
<body class="shopnow-body">
	<%@include file="all_component/navbar.jsp"%>

	<div class="container-fluid">
		<%
    String category = request.getParameter("category");
    int productsPerPage = 12; // Number of products to display per page
    int currentPage = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1;

    Connection conn = null;
    List<ProductDetails> productList = null;
    int totalProducts = 0;
    int totalPages = 0;
    try {
        conn = DBConnect.getConn();
        ProductDAO productDAO = new ProductDAO(conn);
        totalProducts = productDAO.getTotalProductsByCategory(category); // Get total number of products for the category
        totalPages = (int) Math.ceil((double) totalProducts / productsPerPage); // Calculate total pages

        // Adjust currentPage to ensure it's within the valid range
        if (currentPage < 1) {
            currentPage = 1;
        } else if (currentPage > totalPages) {
            currentPage = totalPages;
        }

        // Calculate start index for the current page
        int start = (currentPage - 1) * productsPerPage;

        // Fetch products for the current page
        productList = productDAO.getProductsByCategoryPerPage(category, start, productsPerPage);
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    } finally {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>


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
						<h2 style="text-transform: uppercase; font-weight: 800;"><%=category.replace("_", " ")%></h2>
						<h5>Showing <%=productList.size()%> results</h5>
				

					</div>
				</div>
				<div class="row">
					<%
					if (productList != null && !productList.isEmpty()) {
						for (ProductDetails product : productList) {
					%>
					<div class="col-md-3 col-sm-6">
						<div class="shopnow-product-card">
							<img src="img/<%=product.getImage()%>"
								alt="<%=product.getName()%>">
							<h4><%=product.getName()%></h4>
							<p>₹<%=product.getPrice()%></p>
							<a href="productDetails.jsp?id=<%=product.getId()%>" class="details-link">Select Options <i class="fa fa-angle-double-right"></i></a>
						</div>
					</div>
					<%
						}
					} else {
					%>
					<div class="col-md-12">
						<p>No products found in this category.</p>
					</div>
					<%
					}
					%>
				</div>
				<div class="page-btn">
					<%
					for (int i = 1; i <= totalPages; i++) {
						if (i == currentPage) {
					%>
					<span class="pagination-style"><%=i%></span>
					<%
						} else {
					%>
					<a href="category.jsp?category=<%=category%>&page=<%=i%>" class="pagination-style"><%=i%></a>
					<%
						}
					}
					%>
				</div>
			</div>
		</div>
	</div>
	<%@include file="all_component/footer.jsp"%>
</body>
</html>
