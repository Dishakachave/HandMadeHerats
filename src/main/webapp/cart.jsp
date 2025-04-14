<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.product.ProductDetails" %>
<%@ page import="com.user.UserDetails"%>
<%@ page import="com.dao.CartDAO" %>
<%@ page import="com.db.DBConnect" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>

<% 
    UserDetails user = (UserDetails) session.getAttribute("user");
    List<ProductDetails> cartItems = null;
    double total = 0.0;

    if (user != null) {
        try {
            Connection conn = DBConnect.getConn();
            CartDAO cartDAO = new CartDAO(conn);
            cartItems = cartDAO.getCartItems(user.getId());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    } else {
        response.sendRedirect("register.jsp?message=Please login to view your cart");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Shopping Cart</title>
<%@include file="all_component/allcss.jsp"%>

<style>
/* Container for the cart page */

.container {
    max-width: 1280px;
    margin-top: 30px;
}
.container.cart-page {
    display: flex;
    flex-wrap: wrap;
    margin-top: 20px;
    padding: 40px;
    background-color: #fff9e1;
    border-radius: 10px;
}

/* Cart items section */
.cart-items {
    flex: 1 1 65%;
    margin-right: 20px;
}

.cart-table {
    width: 100%;
    border-collapse: collapse;
}

.cart-table th, .cart-table td {
    padding: 10px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

.cart-table th {
    background-color: transperent;
    color: graytext;
}

.cart-table img {
    width: 50%;
    height: auto;
    vertical-align: middle;
    line-height: 1.8;
}

/* Cart summary section */
.cart-summary {
    flex: 1 1 30%;
    padding: 15px 35px 30px;
    position: relative;
    border: 6px solid;
    border-color: #ebebeb;
    background-color: transperent;
    border-radius: 2px;
}

.cart-summary h2 {
   font-size: 20px;
   font-weight: bolder;
    text-transform: uppercase;
    border-bottom: 2px solid;
    border-bottom-color: #ebebeb;
    padding-bottom: 0.5em;
    margin-bottom: 0;
    line-height: 1.214;
    clear: both;
    margin: 0 0 0.5407911001em;
    color: #0a472e;
}

.cart-summary table{
border-spacing: 0;
    width: 100%;
    border-collapse: collapse;
    margin: 0 0 1.41575em;
    display: table;
    text-indent: initial;
    unicode-bidi: isolate;
        border-color: gray;
}
tr {
    display: table-row;
    vertical-align: inherit;
    unicode-bidi: isolate;
    border-color: inherit;
}
.cart-summary tbody{
display: table-row-group;
    vertical-align: middle;
    unicode-bidi: isolate;
    border-color: inherit;
}

.cart-summary .cart-subtotals{
border-bottom: 1px solid;
    border-bottom-color: #ebebeb;
}

.cart-summary table th{
color: #0a472e;
}

.cart-summary table td {
display: block;
    text-align: right;
    clear: both;
    vertical-align: top;
    word-break: break-all;
        unicode-bidi: isolate;
}

.cart-summary .cart-subtotal .amount{
font-weight: 700;
    color: #0a472e;
    font-size: 18px;
}

.cart-summary .shipping-charge .amount{
font-weight: 700;
    color: #0a472e;
    font-size: 18px;
}
.cart-summary .grand-total{
border-top: 1px solid;
    border-top-color: #ebebeb;
}
.cart-summary .grand-total th{
vertical-align: middle;
font-weight: 700;
    float: left;
    font-size: 2.2906835em;
    padding: 0.5em 0;
}

.cart-summary .grand-total .amount{
color: #0a472e;
font-weight: 700;
color: #205300;
font-size: 24px;
text-align: right;
}
.cart-summary table th, .cart-summary table td{
padding: 1em 0;
}

.proceed-to-checkout .btn-checkout{
font-size: 14px;
    display: block;
    text-align: center;
    border-color: #205300;
    background-color: #205300;
    border-radius: 3px;
    border: none;
    color: #fff;
    cursor: pointer;
    padding: 0.6180469716em 1.41575em;
    text-decoration: none;
    text-shadow: none;
    font-weight: 700;
}

.proceed-to-checkout .btn-checkout:hover{
background-color: #a8b324;
    border-color: #a8b324;
}
.cart-actions {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
}

.cart-actions .btn {
font-size: 14px;
    font-weight: 700;
    padding: 10px 20px;
     border-color: #205300;
    background-color:  #205300;
    color: white;
    border: none;
    border-radius: 3px;
    cursor: pointer;
}

.cart-actions .btn:hover {
background-color: #a8b324;
    border-color: #a8b324;
    }

.qty-container {
    display: flex;
    align-items: center;
}

.qty-container button {
    background-color: #fff9e1;
    color:#205300;
    border: none;
    border-color: #fff9e1;
    padding: 5px 10px;
    cursor: pointer;
    border-radius: 5px;
}

.qty-container button:hover {
background-color: #a8b324;
    border-color: #a8b324;}

.qty-container input[type="number"] {
    width: 50px;
    text-align: center;
    margin: 0 5px;
}

@media (max-width: 768px) {
    .container.cart-page {
        flex-direction: column;
    }

    .cart-items, .cart-summary {
        flex: 1 1 100%;
        margin-right: 0;
        margin-bottom: 20px;
    }
}
</style>
</head>
<body>
<%@include file="all_component/navbar.jsp"%>

<div class="container cart-page">
    <div class="cart-items">
        <form id="updateCartForm" action="UpdateCartServlet" method="post">
            <table class="cart-table">
                <thead>
                    <tr>
                        <th></th>
                        <th></th>
                        <th>Product</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (cartItems != null && !cartItems.isEmpty()) {
                        for (ProductDetails item : cartItems) { 
                            double itemTotal = item.getPrice() * item.getQuantity();
                            total += itemTotal;
                    %>
                    <tr>
                    <td>
                            <form action="RemoveFromCartServlet" method="post">
                                <input type="hidden" name="productId" value="<%= item.getId() %>">
                                <i class="fa fa-times-circle" aria-hidden="true"></i>
                            </form>
                        </td>
                        <td>
                            <img src="img/<%= item.getImage() %>" alt="<%= item.getName() %>">
                           
                        </td>
                        <td> <span><%= item.getName() %></span></td>
                        <td>
                            <div class="qty-container">
                                <button type="button" onclick="document.getElementById('qtyInput<%= item.getId() %>').stepDown()"><i class="fa fa-minus"></i></button>
                                <input type="number" id="qtyInput<%= item.getId() %>" name="quantity<%= item.getId() %>" value="<%= item.getQuantity() %>" min="1" max="10">
                                <button type="button" onclick="document.getElementById('qtyInput<%= item.getId() %>').stepUp()"><i class="fa fa-plus"></i></button>
                            </div>
                        </td>
                        <td>₹<%= item.getPrice() %></td>
                        <td>₹<%= itemTotal %></td>
                        
                    </tr>
                    <% } } else { %>
                    <tr>
                        <td colspan="5">Your cart is empty.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <div class="cart-actions">
                <button class="btn" type="button" onclick="window.location.href='index.jsp'">Continue Shopping</button>
                <button class="btn" type="button" onclick="updateCart()">Update Cart</button>
            </div>
        </form>
    </div>
    <div class="cart-summary">
    <h2>Cart totals</h2>
    <table>
    <tbody>
    	<tr class="cart-subtotal">
    		<th>Subtotal:</th>
    		<td><span class="amount">₹<%= total %></span></td>
    	</tr>
    	<tr class="shipping-charge">
    		<th>Shipping Charges:</th>
    		<td><span class="amount">₹70</span></td>
    	</tr>
    	
    	<tr class="grand-total">
    		<th>Grand Total:</th>
    		 <td><span class="amount">₹<%= total + 70 %></span></td>	
    	</tr>
    </tbody>
    </table>
        
        <div class="proceed-to-checkout">
        <a href="checkout.jsp" class="btn-checkout">Proceed to Checkout</a>
        </div>
    </div>
</div>

<%@include file="all_component/footer.jsp"%>

<script>
//JavaScript functions for updating cart quantity and form submission
function updateQuantity(productId, action) {
    var qtyInput = document.getElementById('qty' + productId);
    if (action === 'minus' && qtyInput.value > 1) {
        qtyInput.value--;
    } else if (action === 'plus' && qtyInput.value < 10) {
        qtyInput.value++;
    }
}

function updateCart() {
    var form = document.getElementById('updateCartForm');
    <% if (cartItems != null && !cartItems.isEmpty()) {
        for (ProductDetails item : cartItems) { %>
        var qtyInput = document.getElementById('qtyInput<%= item.getId() %>');
        var hiddenQtyInput = document.createElement('input');
        hiddenQtyInput.type = 'hidden';
        hiddenQtyInput.name = 'quantity<%= item.getId() %>';
        hiddenQtyInput.value = qtyInput.value;
        form.appendChild(hiddenQtyInput);
    <% } } %>
    form.submit();
}
</script>
</body>
</html>
