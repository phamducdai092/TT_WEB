package controller.admin;

import bean.Brand;
import bean.Log;
import bean.Product;
import bean.User;
import dao.BrandDAO;
import dao.ProductDAO;
import service.LogService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


@WebServlet(value = "/hiddenProduct")
public class AdminHiddenProduct extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("auth");

        String preData, afterData, table, role, actionDetail;
        int productId = Integer.parseInt(req.getParameter("productId"));
        Product p = ProductDAO.getProductId(productId);
        LogService usl = new LogService();
        Log us = new Log();

        int userId = u.getId();


        table = "product_details";
        us.setTables(table);

        role = "adminId = " + userId;
        us.setRole(role);

        if (p.getStatus() == 1) {
            actionDetail = "disable";
        } else {
            actionDetail = "display";
        }
        us.setActionDetail(actionDetail);

        if (productId != 0) {
            ProductDAO.hiddenProduct(productId);
            resp.sendRedirect("./adminProductIndex");
            preData = "disatble productId = " + productId;
            us.setBeforeData(preData);
            usl.update(us);
        }
    }
}
