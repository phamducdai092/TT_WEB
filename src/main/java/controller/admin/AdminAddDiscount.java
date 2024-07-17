package controller.admin;

import bean.Log;
import bean.User;
import dao.CategoryDAO;
import dao.DiscountDAO;
import service.LogService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(value = "/addDiscount")
public class AdminAddDiscount extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("auth");

        double amount = Double.parseDouble(req.getParameter("percentage-discount"));
        String startDate = req.getParameter("start-date");
        String endDate = req.getParameter("end-date");

        boolean addSuccess = DiscountDAO.addDiscount(amount/100, startDate, endDate);

        String preData, afterData, table, role, actionDetail;

        LogService usl = new LogService();
        Log us = new Log();

        int userId = u.getId();


        table = "discount";
        us.setTables(table);

        role = "adminId = " + userId;
        us.setRole(role);

        actionDetail = "addDiscount";
        us.setActionDetail(actionDetail);
        if (addSuccess) {
            req.getRequestDispatcher("./adminDiscountManagement").forward(req, resp);
            afterData = "amount = " + amount/100 + ", " + "startDate = " + startDate + ", " + "endDate = " + endDate;
            us.setAfterData(afterData);
            usl.insert(us);
        }
    }
}
