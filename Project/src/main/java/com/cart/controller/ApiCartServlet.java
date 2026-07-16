package com.cart.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import org.json.JSONObject;
import com.cart.model.CartItem;
import com.cart.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet({"/api/cart", "/api/cart/*"})
public class ApiCartServlet extends HttpServlet {

    @SuppressWarnings("unchecked")
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        BufferedReader reader = request.getReader();
        String jsonString = reader.lines().collect(Collectors.joining());
        JSONObject payload = new JSONObject(jsonString);

        int productId = payload.getInt("productId");
        String name = payload.optString("name", "Unknown Product");
        double price = payload.getDouble("price");
        int quantity = payload.optInt("quantity", 1);

        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(1800); 
        
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        boolean found = false;
        for (CartItem item : cart) {
            if (item.getProduct().getId() == productId) {
                item.setQuantity(item.getQuantity() + quantity);
                found = true; 
                break;
            }
        }
        
        if (!found) cart.add(new CartItem(new Product(productId, name, price, ""), quantity));

        // Let the Servlet do the math!
        updateSessionTotals(session, cart);

        response.setContentType("application/json");
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write(String.format("{\"totalItems\": %d, \"cartTotal\": %.2f}", 
                session.getAttribute("totalItems"), session.getAttribute("cartSubtotal")));
    }

    @SuppressWarnings("unchecked")
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("cart") != null) {
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            String pathInfo = request.getPathInfo();

            if (pathInfo == null || pathInfo.equals("/")) {
                session.removeAttribute("cart");
                updateSessionTotals(session, new ArrayList<>()); // Reset to 0
            } else {
                int productId = Integer.parseInt(pathInfo.substring(1));
                cart.removeIf(item -> item.getProduct().getId() == productId);
                updateSessionTotals(session, cart);
            }
        }
        response.setStatus(HttpServletResponse.SC_OK);
    }

    // Helper method to keep math consistent
    private void updateSessionTotals(HttpSession session, List<CartItem> cart) {
        int totalItems = 0;
        double cartSubtotal = 0.0;
        for (CartItem item : cart) {
            totalItems += item.getQuantity();
            cartSubtotal += item.getTotal();
        }
        session.setAttribute("totalItems", totalItems);
        session.setAttribute("cartSubtotal", cartSubtotal);
    }
}