package com.wearly.controller;

import com.google.gson.Gson;
import com.wearly.model.SearchDAO;
import com.wearly.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "SearchCustomersServlet", value = "/SearchCustomersServlet")
public class SearchCustomersServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String searchQuery = request.getParameter("searchQuery");

        SearchDAO searchDAO = new SearchDAO();

        List<User> matchingUsers = searchDAO.searchUsers(searchQuery);

        Gson gson = new Gson();
        String usersJson = gson.toJson(matchingUsers);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(usersJson);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
