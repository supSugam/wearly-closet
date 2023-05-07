package com.wearly.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.wearly.model.PasswordHandler;
import com.wearly.model.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;

@WebServlet(name = "EditPasswordServlet", value = "/EditPasswordServlet")
public class EditPasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        JsonObject requestBody = new JsonParser().parse(request.getReader()).getAsJsonObject();
        String currentPassword = requestBody.get("currentPassword").getAsString();
        String newPassword = requestBody.get("newPassword").getAsString();

        int userId = SessionManager.getUserId(request.getSession());

        UserDAO userDAO = new UserDAO();
        userDAO.getUserPasswordById(userId);
        PasswordHandler passwordHandler = new PasswordHandler();
        boolean passwordMatch = false;
        String newEncryptedPassword = null;
        try {
            passwordMatch = passwordHandler.verifyPassword(currentPassword, userDAO.getUserPasswordById(userId));
            newEncryptedPassword = passwordHandler.encryptPassword(newPassword);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
        if(!passwordMatch){
            response.setStatus(400);
            response.getWriter().println("Password does not match");
            return;
        }

        boolean passwordChanged = userDAO.updatePassword(newEncryptedPassword, userId);
        if (passwordChanged) {
            response.setStatus(200);
            response.getWriter().println("Password changed successfully");
        } else {
            response.setStatus(400);
            response.getWriter().println("Password change failed");
        }

    }
}
