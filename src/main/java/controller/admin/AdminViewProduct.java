package controller.admin;

import bean.Brand;
import bean.Category;
import bean.Product;
import bean.Supplier;
import dao.BrandDAO;
import dao.CategoryDAO;
import dao.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(value = "/adminViewProduct")
public class AdminViewProduct extends HttpServlet {
    int productId;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        productId = Integer.parseInt(req.getParameter("productId"));

        Product product = ProductDAO.adminViewProduct(productId);

        List<Category> categoryList = CategoryDAO.getAllCategory();

        List<Brand> brandList = BrandDAO.getAllBrands();

        List<Supplier> supplierList = CategoryDAO.getListSupplier();

        HttpSession session = req.getSession();
        session.setAttribute("product", product);
        session.setAttribute("categories", categoryList);
        session.setAttribute("brands", brandList);
        session.setAttribute("suppliers", supplierList);
        session.setAttribute("productId", productId);
        req.getRequestDispatcher("./adminEditProduct.jsp").forward(req, resp);
    }
}
