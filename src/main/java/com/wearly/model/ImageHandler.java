package com.wearly.model;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

public class ImageHandler {

    public String generateImageName(String nameToInclude, String extension) {

        // Generate a random UUID (Universally unique identifier).
        // Convert UUID to a String
        String randomUUID =  UUID.randomUUID().toString();

        // Get current date time
        Date now = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
        String dateStr = format.format(now);
        String imageName = dateStr+ "_" + nameToInclude.replace(" ","-").replace("/","-") + "_" + randomUUID + "." + extension ;
        return imageName;

    }

    public boolean saveImage(String imageName, byte[] imageData, String imageFolder) {

        // Create the directory if it doesn't exist
        File imageDir = new File(imageFolder);
        if (!imageDir.exists()) {
            imageDir.mkdirs();
        }

        // Save the image to the user-images directory
        File imageFile = new File(imageDir, imageName);
        try (OutputStream outputStream = new FileOutputStream(imageFile)) {
            outputStream.write(imageData);
            return true;
        } catch (IOException e) {
            // Handle the exception
            e.printStackTrace();
        }
        return false;


}}
