package com.wearly.model;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordHandler {

    public String encryptPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-512");
        byte[] hashedBytes = md.digest(password.getBytes(StandardCharsets.UTF_8));

        StringBuilder sb = new StringBuilder();
        for (byte b : hashedBytes) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }
    public boolean verifyPassword(String enteredPassword, String realPassword) throws NoSuchAlgorithmException {
        String encryptedPassword = encryptPassword(enteredPassword);
        return encryptedPassword.equals(realPassword);
    }
}
