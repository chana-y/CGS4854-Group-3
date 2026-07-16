package com.cart.controller;

import com.cart.utils.DatabaseUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Attempt to register
        if (DatabaseUtil.registerUser(name, email, password)) {
            // Registration Success: Fetch ID and log in automatically
            int userId = DatabaseUtil.getUserIdByEmail(email);
            
            HttpSession session = request.getSession();
            session.setAttribute("userEmail", email);
            session.setAttribute("userId", userId);
            
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            // Registration Failure
            request.setAttribute("error", "Registration failed. That email may already be in use.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}