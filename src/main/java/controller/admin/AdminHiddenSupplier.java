package controller.admin;

import dao.SupplierDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/hiddenSupplier")
public class AdminHiddenSupplier extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int supplierId = Integer.parseInt(req.getParameter("supplierId"));
        SupplierDAO.hiddenSupplier(supplierId);
        req.getRequestDispatcher("./adminSupplierManagement").forward(req, resp);

    }
}
