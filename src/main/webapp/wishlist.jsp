<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.product.ProductDetails"%>
<%@ page import="com.user.UserDetails"%>
<%@ page import="com.dao.WishlistDAO"%>
<%@ page import="com.db.DBConnect"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException"%>

<%
UserDetails user = (UserDetails) session.getAttribute("user");
List<ProductDetails> wishlistItems = null;

if (user != null) {
	try {
		Connection conn = DBConnect.getConn();
		WishlistDAO wishlistDAO = new WishlistDAO(conn);
		wishlistItems = wishlistDAO.getWishlistItems(user.getId());
	} catch (SQLException e) {
		e.printStackTrace();
	}
} else {
	response.sendRedirect("register.jsp?message=Please login to view your wishlist");
	return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Wishlist</title>
<%@include file="all_component/allcss.jsp"%>

<style>
.wishlist-page {
	padding: 20px;
	margin:70px;
	margin-top: 25px;
	background-color: #fff9e1;
	border-radius: 10px;
}
.wishlist-page h2{
font-size: 2em;
    line-height: 1.214;
    font-weight: 700;
	color: #205300;
}
.wishlist-table {
	border-spacing: 0;
	width: 100%;
	display: table;
	unicode-bidi: isolate;
	text-indent: initial;
	border-color: gray;
	border-collapse: collapse;
}
.wishlist-table:hover{
background-color: rgb(255, 245, 208) ;
}

.wishlist-page .wishlist-table .item-remove .fa{
color: #555555;
font-size: 14px;
}
.wishlist-table tr td{
vertical-align: middle;
    padding: 10px;
}


.wishlist-table img {
	width: 80px;
	line-height: 1.8;
	height: auto;
	border-radius: 2px;
	border: none;
	padding: 0;
	margin: 0;
	box-shadow: none;
	max-width: 100%;
	display: block;
	overflow-clip-margin: content-box;
	overflow: clip;
}

.wishlist-table .item-remove {
	vertical-align: middle;
	width: 16px;
	line-height: 1.8;
}

.wishlist-table .item-info .item-title {
	font-weight: 700;
	color: #205300;
	background-color: transparent;
	line-height: 1.8;
}

.wishlist-table .item-info .item-price {
	font-size: 14px;
	font-weight: 450;
	color: gray;
	line-height: 1.8;
}

.wishlist-table .item-actions .item-add p{
margin: 0 0 1.41575em;
}

.wishlist-table .item-actions{
padding:10px;
	line-height: 1.8;

}
.wishlist-table .item-actions .item-stock{
font-size: 14px;
margin-top: 25px;
color: #555555;
}
.wishlist-table .item-actions .item-add .add-to-cart-inline .details-link{
			color: #1b5f20;
            text-decoration: none;
            display: block;
            margin-top: 6px;
            padding-bottom: 20px;
            text-align: left;
            font-weight: bold;
            font-size:14px;
}

</style>
</head>
<body>
	<%@include file="all_component/navbar.jsp"%>

	<div class="wishlist-page">
		<h2>Items in your wish list</h2>
		<table class="wishlist-table">
			<%
			if (wishlistItems != null && !wishlistItems.isEmpty()) {
				for (ProductDetails product : wishlistItems) {
			%>
			<tbody>
				<tr>

					<td class="item-remove"><a
						href="RemoveFromWishlistServlet?productId=<%=product.getId()%>"><i class="fa fa-times" aria-hidden="true"></i></a></td>

					<td class="item-image"><img src="img/<%=product.getImage()%>"
						alt="<%=product.getName()%>"></td>

					<td class="item-info">
						<div class="item-title"><%=product.getName()%></div>
						<div class="item-price">
							<span class="amount"> ₹<%=product.getPrice()%>
							</span>
						</div>
					</td>

					<td class="item-actions">
						<div class="item-stock"><%=product.isInStock() ? "In Stock" : "Out of Stock"%></div>
						<div class="item-add">
							<p class="add-to-cart-inline">
								<a href="productDetails.jsp?id=<%=product.getId()%>"
									class="details-link">Select Options <i
									class="fa fa-angle-double-right"></i>
								</a>
							</p>
						</div>
					</td>
				</tr>
			</tbody>
			<%
			}
			} else {
			%>
			<tbody>
				<td colspan="6">Your wishlist is empty.</td>
			</tbody>
			<%
			}
			%>
		</table>
	</div>
	<%@include file="all_component/footer.jsp"%>
</body>
</html>
