package com.wearly.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.wearly.model.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Base64;
import java.util.Random;

@WebServlet(name = "AddProductServlet", value = "/AddProductServlet")
public class AddProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        if(SessionManager.isAlreadyLoggedIn(request) && SessionManager.isAdmin(request.getSession())){

            // Parsing the JSON request body after FORM SUBMISSION
            JsonObject requestBody = new JsonParser().parse(request.getReader()).getAsJsonObject();


            // Extract data from the request body
            String productName = requestBody.get("productName").getAsString();
            String productBrand = requestBody.get("productBrand").getAsString();
            String productGender = requestBody.get("productGender").getAsString();
            String productCategory = requestBody.get("productCategory").getAsString();
            int productPrice = requestBody.get("productPrice").getAsInt();
            int productQuantity = requestBody.get("productQuantity").getAsInt();



            int categoryId = -1;
            try {
                categoryId = new CategoryDAO().getCategoryID(productGender, productCategory);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }


            String descriptionString = requestBody.get("productDescriptionText").getAsString();
            System.out.println(descriptionString);
            // Split the string back into an array using the same delimiter
            String[] descriptionArray = descriptionString.split("\\|\\|");
            System.out.println(descriptionArray);

            // Now you can iterate over the array and do whatever you need with each line
            for (String line : descriptionArray) {
                System.out.println(line);
            }

            Random random = new Random();
            double min = 3.00;
            double max = 5.00;
            double rating = min + random.nextDouble() * (max - min);
            System.out.println(rating);


            // Get the ServletContext object
            ServletContext context = request.getServletContext();

            // Get the absolute path to the webapp directory
            String basePath = context.getRealPath("/");

            // Build the path to the user-images directory
            String imageDirPath = basePath + "images/product-images/";

            String imageDirForView = imageDirPath+ "/";


            // Get the value of the profileImage key from the JSON object
            String imageDataUrl = requestBody.get("productImage").getAsString();

            // Extract the extension from the data URL
            String extension = imageDataUrl.substring(imageDataUrl.indexOf("/") + 1, imageDataUrl.indexOf(";base64"));

            // Generate a unique name for the image file

            ImageHandler imageHandler = new ImageHandler();
            String imageName = imageHandler.generateImageName(productName,extension);

            System.out.println(imageName);

            // Extract the Base64 encoded data from the data URL
            String base64Data = imageDataUrl.split(",")[1];

            // Decode the Base64 data to binary data
            byte[] imageData = Base64.getDecoder().decode(base64Data);

            // Save the image data to a file
            boolean imageUploaded = imageHandler.saveImage(imageName,imageData, imageDirPath);

            System.out.println(imageDirPath+"--"+imageUploaded);

            if (imageUploaded){

                Product product = new Product(productName,productPrice,productBrand,productQuantity,categoryId,descriptionString,imageName,rating);
                ProductDAO productDAO = new ProductDAO();
                productDAO.saveProduct(product);
                response.setStatus(200);
            }
            else{
                response.setStatus(400);

            }

        }
        else{
            response.sendRedirect(request.getContextPath()+ "/view/login.jsp");
        }
    }
}
