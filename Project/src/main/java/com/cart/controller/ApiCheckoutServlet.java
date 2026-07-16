package com.cart.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
import org.json.JSONObject;
import com.cart.model.CartItem;
import com.cart.service.APIService;
import com.cart.utils.DatabaseUtil;
import com.cart.utils.SecurityUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/api/checkout")
public class ApiCheckoutServlet extends HttpServlet {
    
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            BufferedReader reader = request.getReader();
            String jsonString = reader.lines().collect(Collectors.joining());
            JSONObject payload = new JSONObject(jsonString);

            if (!payload.has("name") || !payload.has("email") || !payload.has("cc")) {
                throw new IllegalArgumentException("Missing required checkout fields.");
            }

            String name = payload.getString("name");
            String email = payload.getString("email");
            String cc = payload.getString("cc");

            String encryptedCC = SecurityUtil.encryptAES(cc);
            String tracking = APIService.getTrackingNumber("ORD-API");
            
            HttpSession session = request.getSession(false);
            double realTotal = 0.0;

            // Logged-in shoppers get their receipt at their account email;
            // guests get it at whatever address they typed into the checkout form.
            Object sessionEmail = (session != null) ? session.getAttribute("userEmail") : null;
            String confirmationEmail = (sessionEmail != null) ? (String) sessionEmail : email;
            
            if (session != null && session.getAttribute("cart") != null) {
                
                List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                for (CartItem item : cart) {
                    realTotal += item.getTotal();
                }

int userId = -1; // Default for guests
                if (session != null && session.getAttribute("userId") != null) {
    userId = (int) session.getAttribute("userId");
}
                
                
                DatabaseUtil.saveOrder(name, email, realTotal, tracking, encryptedCC, userId);
                
                // Clear the cart and reset session math to 0!
                session.removeAttribute("cart");
                session.setAttribute("totalItems", 0);
                session.setAttribute("cartSubtotal", 0.00);

                APIService.sendConfirmationEmail(confirmationEmail, tracking);
            } 

            response.setContentType("application/json");
            response.setStatus(HttpServletResponse.SC_OK);
            String jsonResponse = String.format("{\"status\": \"success\", \"tracking\": \"%s\", \"email\": \"%s\"}", tracking, confirmationEmail);
            response.getWriter().write(jsonResponse);

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }
}