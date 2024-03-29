package controller.admin;

import bean.Product;
import bean.User;
import dao.ProductDAO;
import dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(value = "/adminSearchProduct")
public class AdminSearchProduct extends HttpServlet {

    String searchValue;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        searchValue = req.getParameter("search-product");
        List<Product> productList = ProductDAO.adminSearchProduct(searchValue);
        req.setAttribute("productList", productList);
        req.setAttribute("searchValue", searchValue);
        req.getRequestDispatcher("./adminProduct.jsp").forward(req, resp);
    }
}
