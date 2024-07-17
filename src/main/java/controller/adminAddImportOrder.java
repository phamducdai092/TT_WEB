package controller;

import bean.ImportOrder;
import dao.ImportOrderDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/addImportOrder")
public class adminAddImportOrder extends HttpServlet {
    String productName,colorName,timeSet;
    int quantity;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ImportOrder importOrder=new ImportOrder();
        productName=req.getParameter("productName");
        colorName=req.getParameter("colorName");
        quantity= Integer.parseInt(req.getParameter("quantity"));
        timeSet=req.getParameter("import-date");
        ImportOrderDAO.addImportOrder(productName, colorName, quantity, timeSet);
        req.getRequestDispatcher("./adminEditImport.jsp").forward(req, resp);
    }
}
