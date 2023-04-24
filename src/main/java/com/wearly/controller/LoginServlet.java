package com.wearly.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.wearly.model.PasswordHandler;
import com.wearly.model.User;
import com.wearly.model.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        if(SessionManager.isAlreadyLoggedIn(request)) {
            response.sendRedirect("/view/index.jsp");
            return;
        }
        // Parsing the JSON request body after FORM SUBMISSION
        JsonObject requestBody = new JsonParser().parse(request.getReader()).getAsJsonObject();

        // Extract data from the request body
        String email = requestBody.get("email").getAsString();
        String password = requestBody.get("password").getAsString();
        boolean rememberPassword = requestBody.get("rememberPassword").getAsBoolean();

        System.out.println("am i executed? 111");
        // Check if email exists in the database
        UserDAO userDao = new UserDAO();
        User user = userDao.getUserByEmail(email);

        if (user == null) {

            System.out.println("User does not exist");
            return;
        }

        // Check if password is correct
        PasswordHandler passwordHandler = new PasswordHandler();
        try {
            if(!passwordHandler.verifyPassword(password, user.getPassword())) {
                System.out.println("Password is incorrect");
                response.setStatus(400);
                return;
            } else{
                // If password is correct, create a session
                System.out.println("am i executed?");
                System.out.println(user.getUser_type());
                SessionManager.createSession(request.getSession(), user.getUser_id(), user.getFirst_name(),user.getUser_type());

                RequestDispatcher rd = request.getRequestDispatcher("/view/login.jsp");
                rd.forward(request, response);
                response.setStatus(200);
            }
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }


    }
}
