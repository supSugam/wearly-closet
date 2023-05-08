package com.wearly.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.wearly.model.ImageHandler;
import com.wearly.model.User;
import com.wearly.model.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.Base64;

@WebServlet(name = "EditProfileServlet", value = "/EditProfileServlet")
public class EditProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        JsonObject requestBody = new JsonParser().parse(request.getReader()).getAsJsonObject();

        String firstName = requestBody.get("firstName").getAsString();
        String lastName = requestBody.get("lastName").getAsString();
        String phoneNumber = String.valueOf(requestBody.get("phoneNumber").getAsNumber());
        String email = requestBody.get("email").getAsString();
        boolean imageChanged = requestBody.get("imageChanged").getAsBoolean();
        int userId = SessionManager.getUserId(request.getSession());
        System.out.println(userId);
        UserDAO userDAO = new UserDAO();

        boolean userDetailsUpdated = false;

        if (imageChanged){
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
                User user = new User();
                user.setUser_id(userId);
                user.setFirst_name(firstName);
                user.setLast_name(lastName);
                user.setPhone_number(phoneNumber);
                user.setEmail(email);
                user.setImage_name(imageName);
                // Save the user to the database
                userDetailsUpdated = userDAO.updateUserDetails(user,true);
            }
        } else{
            // Create a User object
            User user = new User();
            user.setUser_id(userId);
            user.setFirst_name(firstName);
            user.setLast_name(lastName);
            user.setPhone_number(phoneNumber);
            user.setEmail(email);
            // Save the user to the database
            userDetailsUpdated = userDAO.updateUserDetails(user,false);
        }
        if(userDetailsUpdated){
            response.setStatus(200);
        } else{
            response.setStatus(400);
            response.getWriter().println("User details update failed");
        }

    }
}
