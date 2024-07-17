package controller.admin;

import bean.Brand;
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

@WebServlet(value = "/addCategory")
public class AdminAddCategory extends HttpServlet {
    String error = "Không thể thêm danh mục";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("auth");

        String newCategory = req.getParameter("new-category");
        boolean addSuccess = CategoryDAO.addNewCategory(newCategory);

        int categoryId = CategoryDAO.getCategoryByName(newCategory);

        String preData, afterData, table, role, actionDetail;

        LogService usl = new LogService();
        Log us = new Log();

        int userId = u.getId();


        table = "categories";
        us.setTables(table);

        role = "adminId = " + userId;
        us.setRole(role);

        actionDetail = "addCategory";
        us.setActionDetail(actionDetail);
        if (addSuccess) {
            req.getRequestDispatcher("./adminCategoryManagement").forward(req, resp);
            afterData = categoryId + ", " + newCategory;
            us.setAfterData(afterData);
            usl.insert(us);
        } else {
            req.setAttribute("error", error);
            req.getRequestDispatcher("./adminCategoryManagement").forward(req, resp);
        }
    }
}

