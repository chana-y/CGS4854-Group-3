package com.cart.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.cart.model.Product;

public class DatabaseUtil {

    public static boolean authenticateUser(String email, String rawPassword) {
        String sql = "SELECT password_hash FROM users WHERE email = ?";
        
        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    // 1. Grab the hash from the database
                    String storedHash = rs.getString("password_hash");
                    
                    // 2. Hash what the user just typed in
                    String inputHash = SecurityUtil.hashSHA256(rawPassword);
                    
                    // 3. Do they match?
                    return storedHash.equals(inputHash);
                }
            }
        } catch (Exception e) {
            System.err.println("Database error during login.");
            e.printStackTrace();
        }
        return false; // User not found or error occurred
    }
    public static boolean registerUser(String name, String email, String rawPassword) {
        String checkSql = "SELECT id FROM users WHERE email = ?";
        String insertSql = "INSERT INTO users (name, email, password_hash) VALUES (?, ?, ?)";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) {
                
                // 1. Check if the email is already registered
                try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                    checkStmt.setString(1, email);
                    try (ResultSet rs = checkStmt.executeQuery()) {
                        if (rs.next()) {
                            return false; // Email already exists!
                        }
                    }
                }
                
                // 2. Hash the password and insert the new user
                try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                    insertStmt.setString(1, name);
                    insertStmt.setString(2, email);
                    insertStmt.setString(3, SecurityUtil.hashSHA256(rawPassword));
                    
                    int rowsAffected = insertStmt.executeUpdate();
                    return rowsAffected > 0; // Returns true if successful
                }
            }
        } catch (Exception e) {
            System.err.println("Database error during registration.");
            e.printStackTrace();
        }
        return false;
    }

 public static List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products";
        
        try {
            // 1. Wake up the MySQL Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
                 PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {
                 
                while (rs.next()) {
                    // 2. Perfectly matches the 5 columns we just built in MySQL
                    products.add(new Product(
                        rs.getInt("id"), 
                        rs.getString("name"), 
                        rs.getDouble("price"), 
                        rs.getString("image_url"),
                        rs.getString("description")
                    ));
                }
            }
        } catch (ClassNotFoundException e) {
            System.err.println("CRITICAL: MySQL Driver not found in getAllProducts!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Error pulling products from the database.");
            e.printStackTrace();
        }
        
        return products;
    }

    public static int getUserIdByEmail(String email) {
    String sql = "SELECT id FROM users WHERE email = ?";
    try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setString(1, email);
        try (ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) return rs.getInt("id");
        }
    } catch (Exception e) { e.printStackTrace(); }
    return -1;
}
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/minimalist_cart";
    private static final String USER = "root";
    private static final String PASS = "chanelyoung123";

    public static void saveOrder(String name, String email, double total, String tracking, String cc, int userId) {
    String orderId = "ORD-" + UUID.randomUUID().toString().substring(0, 8);
    
    try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) {
        // If userId is -1, it's a guest, so we find or create them
        if (userId == -1) {
            String guestSql = "INSERT INTO users (name, email, password_hash) VALUES (?, ?, 'GUEST_CHECKOUT') " +
                              "ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id)";
            try (PreparedStatement pstmt = conn.prepareStatement(guestSql, Statement.RETURN_GENERATED_KEYS)) {
                pstmt.setString(1, name);
                pstmt.setString(2, email);
                pstmt.executeUpdate();
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) userId = rs.getInt(1);
                }
            }
        }
        
        // Now insert the order using the correct userId (either existing or guest)
        String orderSql = "INSERT INTO orders (order_id, user_id, tracking_number, encrypted_cc_data, total_amount) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement pstmtOrder = conn.prepareStatement(orderSql)) {
            pstmtOrder.setString(1, orderId);
            pstmtOrder.setInt(2, userId); // This will now be correct!
            pstmtOrder.setString(3, tracking);
            pstmtOrder.setString(4, cc);
            pstmtOrder.setDouble(5, total);
            pstmtOrder.executeUpdate();
        }
    } catch (Exception e) { e.printStackTrace(); }
}
}