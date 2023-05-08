package com.wearly.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.wearly.model.Product;
import com.wearly.model.ProductDAO;
import com.wearly.model.SearchDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "Search", value = "/Search")
public class Search extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {



        String query = request.getParameter("query");

        List<String> matchingTerms = new ProductDAO().getMatchingSuggestions(query);
        for (String term : matchingTerms) {
            System.out.println(term);
        }
        // Send matching terms back to the client as JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(matchingTerms));
        out.flush();

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Parsing the JSON request body after FORM SUBMISSION
        JsonObject requestBody = new JsonParser().parse(request.getReader()).getAsJsonObject();

        // Extract data from the request body
        int minPrice = requestBody.get("minPrice").getAsInt();
        int maxPrice = requestBody.get("maxPrice").getAsInt();

        String category = requestBody.get("selectedCategory").getAsString();
        String gender = requestBody.get("selectedGender").getAsString();
        String brand = requestBody.get("selectedBrand").getAsString();

        String searchTerm = requestBody.get("searchTerm").getAsString();
        String sortBy = requestBody.get("selectedSortBy").getAsString();


        List<Product> matchingProducts =  new SearchDAO().getProductsByFilters(minPrice, maxPrice, category,gender,brand,searchTerm,sortBy);

        // Send matching products, and userType back to the client as JSON
        JsonObject responseObject = new JsonObject();
        responseObject.add("products", new Gson().toJsonTree(matchingProducts));
        responseObject.addProperty("isAdmin", SessionManager.isAdmin(request.getSession()));
        String jsonResponse = new Gson().toJson(responseObject);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(jsonResponse);
        out.flush();

    }
}
