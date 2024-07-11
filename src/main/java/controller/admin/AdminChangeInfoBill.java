package controller.admin;

import bean.Bill;
import dao.BillDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(value = "/changeInfoBill")
public class AdminChangeInfoBill extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String status = req.getParameter("bill-status");
        int billId = Integer.parseInt(req.getParameter("billId"));


        BillDAO.changeInfoBill(billId, status);

        Bill updatedBill = BillDAO.getInstance().getBillById(billId);
        HttpSession session = req.getSession();
        session.setAttribute("bill", updatedBill);


        req.getRequestDispatcher("./adminEditBill.jsp").forward(req, resp);
    }
}
