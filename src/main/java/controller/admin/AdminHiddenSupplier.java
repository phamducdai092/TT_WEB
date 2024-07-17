package controller.admin;

import bean.Log;
import bean.Supplier;
import bean.User;
import dao.ProductDAO;
import dao.SupplierDAO;
import service.LogService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(value = "/hiddenSupplier")
public class AdminHiddenSupplier extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("auth");

        String preData, afterData, table, role, actionDetail;
        int supplierId = Integer.parseInt(req.getParameter("supplierId"));
        Supplier s = SupplierDAO.getSupplierById(supplierId);

        LogService usl = new LogService();
        Log us = new Log();

        int userId = u.getId();


        table = "suppliers";
        us.setTables(table);

        role = "adminId = " + userId;
        us.setRole(role);
        if (s.getStatus() == 1) {
            actionDetail = "disable";
        } else {
            actionDetail = "display";
        }

        us.setActionDetail(actionDetail);

        if (supplierId != 0) {
            SupplierDAO.hiddenSupplier(supplierId);
            req.getRequestDispatcher("./adminSupplierManagement").forward(req, resp);
            preData = "disatble supplierId = " + supplierId;
            us.setBeforeData(preData);
            usl.update(us);
        }
    }
}

