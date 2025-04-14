package com.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.product.ProductDetails;
import com.user.UserDetails;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    HttpSession session = request.getSession();
	    UserDetails user = (UserDetails) session.getAttribute("user");
	    List<ProductDetails> cartItems = (List<ProductDetails>) session.getAttribute("cartItems");

	    if (user != null && cartItems != null && !cartItems.isEmpty()) {
	        String fullName = request.getParameter("fullName");
	        String address = request.getParameter("address");

	        // Set attributes for the order review page (checkout.jsp)
	        request.setAttribute("fullName", fullName);
	        request.setAttribute("address", address);
	        request.setAttribute("cartItems", cartItems); // Ensure cartItems is set

	        request.getRequestDispatcher("checkout.jsp").forward(request, response);
	    } else {
	        response.sendRedirect("cart.jsp?message=Your cart is empty or you are not logged in.");
	    }
	}
}

