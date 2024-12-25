package controller.admin;

import bean.Bill;
import bean.Product;
import dao.BillDAO;
import dao.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(value = "/adminBillIndex")
public class AdminBillManagement extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Bill> billList = BillDAO.getInstance().getBillList();
        List<Product> productList = ProductDAO.getProductList();
        req.setAttribute("billList", billList);
        req.setAttribute("productList", productList);
        req.getRequestDispatcher("./adminBill.jsp").forward(req, resp);
    }
}
