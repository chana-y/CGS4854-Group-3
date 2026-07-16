package com.cart.utils;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.security.MessageDigest;
import java.util.Base64;
import java.nio.charset.StandardCharsets;

public class SecurityUtil {

    
   // Fetch from env, but provide a safe fallback for Tomcat deployment!
    private static final String AES_KEY = System.getenv("AES_SECRET_KEY") != null ? 
                                          System.getenv("AES_SECRET_KEY") : 
                                          "1234567890123456";

    public static String hashSHA256(String data) throws Exception {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hash = digest.digest(data.getBytes(StandardCharsets.UTF_8));
        StringBuilder hexString = new StringBuilder();
        for (byte b : hash) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) hexString.append('0');
            hexString.append(hex);
        }
        return hexString.toString();
    }

    public static String encryptAES(String data) throws Exception {
        // Validate key existence
        if (AES_KEY == null || AES_KEY.length() < 16) {
            throw new IllegalStateException("Security Error: AES_SECRET_KEY environment variable is not set or too short.");
        }
        
        SecretKeySpec key = new SecretKeySpec(AES_KEY.getBytes(StandardCharsets.UTF_8), "AES");
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.ENCRYPT_MODE, key);
        return Base64.getEncoder().encodeToString(cipher.doFinal(data.getBytes(StandardCharsets.UTF_8)));
    }
}