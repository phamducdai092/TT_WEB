package controller.admin;

import dao.CategoryDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet(value = "/hiddenCategory")
public class AdminHiddenCategory extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String categoryId = req.getParameter("categoryId");
        System.out.println(categoryId);
        CategoryDAO.hiddenCategory(categoryId);
        resp.sendRedirect("./adminCategoryManagement");

    }
    }
