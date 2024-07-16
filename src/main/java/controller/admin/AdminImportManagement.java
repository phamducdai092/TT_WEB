package controller.admin;

import bean.Product;
import bean.Product_Color;
import dao.ColorDAO;
import dao.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(value = "/adminImportServlet")
public class AdminImportManagement extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        List<Product> productList = ProductDAO.getProductList();
        List<Product_Color> colorList= ColorDAO.getAllColor();
        session.setAttribute("productList", productList);
        session.setAttribute("colorList", colorList);
        req.getRequestDispatcher("./adminEditImport.jsp").forward(req, resp);
    }
}
