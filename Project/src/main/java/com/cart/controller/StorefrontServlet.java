package com.cart.controller;

import com.cart.model.Product;
import com.cart.utils.DatabaseUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class StorefrontServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Fetch products from your database
        List<Product> products = DatabaseUtil.getAllProducts();
        request.setAttribute("products", products);
        
        // 2. Initialize cart numbers if they don't exist yet!
        HttpSession session = request.getSession();
        if (session.getAttribute("totalItems") == null) {
            session.setAttribute("totalItems", 0);
            session.setAttribute("cartSubtotal", 0.00);
        }
        
        // 3. Forward to index.jsp
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}