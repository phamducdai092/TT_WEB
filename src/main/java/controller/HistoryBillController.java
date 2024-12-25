package controller;


import bean.Bill;
import bean.User;
import dao.BillDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "HistoryBillController", value = "/history-bill")
public class HistoryBillController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("auth");

        List<Bill> bills = BillDAO.getInstance().getBillsByUser(user);

        Map<Integer, List<Bill>> groupByBillId = bills.stream().collect(java.util.stream.Collectors.groupingBy(Bill::getId));

        req.setAttribute("userBill", groupByBillId);
        req.getRequestDispatcher("/userHistoryBill.jsp").forward(req, resp);
    }
}