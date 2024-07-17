package controller.admin;

import bean.Brand;
import bean.Log;
import bean.User;
import dao.BrandDAO;
import service.LogService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(value = "/hiddenBrand")
public class AdminHiddenBrand extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("auth");

        String preData, afterData, table, role, actionDetail;
        int brandId = Integer.parseInt(req.getParameter("brandId"));
        Brand brand = BrandDAO.getBrandById(brandId);

        LogService usl = new LogService();
        Log us = new Log();

        int userId = u.getId();


        table = "brands";
        us.setTables(table);

        role = "adminId = " + userId;
        us.setRole(role);
        if (brand.getStatus() == 1) {
            actionDetail = "disable";
            us.setActionDetail(actionDetail);
        } else {
            actionDetail = "display";
            us.setActionDetail(actionDetail);
        }
        if (brandId != 0) {
            BrandDAO.hiddenBrand(brandId);
            req.getRequestDispatcher("./adminBrandManagement").forward(req, resp);
            preData = "disatble brandId = " + brandId;
            us.setBeforeData(preData);
            usl.update(us);
        }
    }
}
