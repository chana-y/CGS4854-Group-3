package com.cart.controller;

import com.cart.utils.DatabaseUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Single, clean authentication check
        if (DatabaseUtil.authenticateUser(email, password)) {
            // Get the User ID from the database
            int userId = DatabaseUtil.getUserIdByEmail(email); 
            
            // Store everything in the session
            HttpSession session = request.getSession();
            session.setAttribute("userEmail", email);
            session.setAttribute("userId", userId); 
            
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            // Login Failed
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}