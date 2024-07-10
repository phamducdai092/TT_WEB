package controller.admin;

import dao.BrandDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/hiddenBrand")
public class AdminHiddenBrand extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int brandId = Integer.parseInt(req.getParameter("brandId"));
        BrandDAO.hiddenBrand(brandId);
        req.getRequestDispatcher("./adminBrandManagement").forward(req, resp);
    }
}
