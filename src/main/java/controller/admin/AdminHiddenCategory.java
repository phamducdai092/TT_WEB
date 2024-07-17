package controller.admin;

import bean.Brand;
import bean.Category;
import bean.Log;
import bean.User;
import dao.BrandDAO;
import dao.CategoryDAO;
import service.LogService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


@WebServlet(value = "/hiddenCategory")
public class AdminHiddenCategory extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("auth");

        String categoryId = req.getParameter("categoryId");
        int idInt = Integer.parseInt(categoryId);
        Category c = CategoryDAO.getCategoryById(idInt);
        String preData, afterData, table, role, actionDetail;

        LogService usl = new LogService();
        Log us = new Log();

        int userId = u.getId();


        table = "categorys";
        us.setTables(table);

        role = "adminId = " + userId;
        us.setRole(role);
        if (c.getStatus() == 1) {
            actionDetail = "disable";
            us.setActionDetail(actionDetail);
        } else {
            actionDetail = "display";
            us.setActionDetail(actionDetail);
        }
        if (categoryId != null) {
            CategoryDAO.hiddenCategory(categoryId);
            resp.sendRedirect("./adminCategoryManagement");
            preData = "disatble categoryId = " + categoryId;
            us.setBeforeData(preData);
            usl.update(us);
        }
    }
}

