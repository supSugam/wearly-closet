package com.wearly.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.wearly.model.ImageHandler;
import com.wearly.model.PasswordHandler;
import com.wearly.model.User;
import com.wearly.model.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.File;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;


@WebServlet(name = "UserRegistrationServlet", value = "/UserRegistrationServlet")
public class UserRegistrationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {



        // Parsing the JSON request body after FORM SUBMISSION
        JsonObject requestBody = new JsonParser().parse(request.getReader()).getAsJsonObject();

        // Extract data from the request body
        String firstName = requestBody.get("firstName").getAsString();
        String lastName = requestBody.get("lastName").getAsString();
        String phoneNumber = String.valueOf(requestBody.get("phone").getAsNumber());
        String email = requestBody.get("email").getAsString();

//         Verify if User already exists
        UserDAO userDAO = new UserDAO();
        if (userDAO.userAlreadyExists(phoneNumber)) {
            response.setStatus(400);
            response.getWriter().println("User already exists");
            return;
        }


        // To be executed if user does not exist:

        // Calling the encryptPassword method from the PasswordHandler class
        String password = null;
        try {
            password = new PasswordHandler().encryptPassword(requestBody.get("password").getAsString());
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }

        // Get the ServletContext object
        ServletContext context = request.getServletContext();

// Get the absolute path to the webapp directory
        String basePath = context.getRealPath("/");

// Build the path to the user-images directory
        String imageDirPath = basePath + "images/user-images/";

        String imageDirForView = imageDirPath+ "/";
        System.out.println(imageDirForView);



        // Get the value of the profileImage key from the JSON object
        String imageDataUrl = requestBody.get("profileImage").getAsString();

        // Extract the extension from the data URL
        String extension = imageDataUrl.substring(imageDataUrl.indexOf("/") + 1, imageDataUrl.indexOf(";base64"));

        // Generate a unique name for the image file

        ImageHandler imageHandler = new ImageHandler();
        String imageName = imageHandler.generateImageName(firstName,extension);

        System.out.println(imageName);

        // Extract the Base64 encoded data from the data URL
        String base64Data = imageDataUrl.split(",")[1];

        // Decode the Base64 data to binary data
        byte[] imageData = Base64.getDecoder().decode(base64Data);

        // Save the image data to a file
        boolean imageUploaded = imageHandler.saveImage(imageName,imageData, imageDirPath);

        System.out.println(imageDirPath+"--"+imageUploaded);

        if(imageUploaded) {
            // Create a User object
            User user = new User(firstName, lastName, phoneNumber, email, password, imageName);
            SessionManager.createSession(request.getSession(), user.getUser_id(), user.getFirst_name(),user.getUser_type());

            // Save the user to the database
            userDAO.saveUser(user);


            SessionManager.createSession(request.getSession(), user.getUser_id(), user.getFirst_name(),user.getUser_type());

            RequestDispatcher rd = request.getRequestDispatcher("/view/login.jsp");
            rd.forward(request, response);
            response.setStatus(200);

        } else {
            response.setStatus(400);
            System.out.println("Not registered");
        }

    }
}
