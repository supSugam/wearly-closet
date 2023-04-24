package com.wearly.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.wearly.model.CategoryDAO;
import com.wearly.model.ImageHandler;
import com.wearly.model.Product;
import com.wearly.model.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Base64;

@WebServlet(name = "EditProductServlet", value = "/EditProductServlet")
public class EditProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        String productId = request.getParameter("productId");

        Product product = new ProductDAO().getProductInfoById(Integer.parseInt(productId));

        Gson gson = new Gson();
        String productJson = gson.toJson(product);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(productJson);


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        JsonObject requestBody = new JsonParser().parse(request.getReader()).getAsJsonObject();
        System.out.println(requestBody);


        // Extract data from the request body
        String productName = requestBody.get("productName").getAsString();
        String productBrand = requestBody.get("productBrand").getAsString();
        int productId = requestBody.get("productId").getAsInt();
        int productPrice = requestBody.get("productPrice").getAsInt();
        int productQuantity = requestBody.get("productQuantity").getAsInt();
        String productGender = requestBody.get("productGender").getAsString();
        String productCategory = requestBody.get("productCategory").getAsString();


        int categoryId = -1;
        try {
            categoryId = new CategoryDAO().getCategoryID(productGender, productCategory);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


        String descriptionString = requestBody.get("productDescriptionText").getAsString();
        // Split the string back into an array using the same delimiter
        String[] descriptionArray = descriptionString.split("\\|\\|");


        boolean newImage = requestBody.get("newImage").getAsBoolean();

        // Declaring Intiials

        ProductDAO productDAO = new ProductDAO();
        boolean productUpdated = false;
        String imageDataUrl = null;
        if(newImage){
            imageDataUrl = requestBody.get("productImage").getAsString();

            // Get the ServletContext object
            ServletContext context = request.getServletContext();

            // Get the absolute path to the webapp directory
            String basePath = context.getRealPath("/");

            // Build the path to the user-images directory
            String imageDirPath = basePath + "images/product-images/";


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

            if (imageUploaded){


                try {
                    productUpdated= productDAO.updateProductInfo(productId, productName, productBrand, productPrice, productQuantity, categoryId,descriptionString, imageName);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                if(productUpdated)
                    response.setStatus(200);
                else{
                    response.setStatus(400);
                }
            }
            else{
                response.setStatus(400);
                System.out.println("Image not uploaded");

            }
        } else{
            imageDataUrl = requestBody.get("productImage").getAsString();
            try {
                productUpdated= productDAO.updateProductInfo(productId, productName, productBrand, productPrice, productQuantity, categoryId,descriptionString, imageDataUrl);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            if(productUpdated)
                response.setStatus(200);
            else{
                response.setStatus(400);
            }
        }


    }
}
