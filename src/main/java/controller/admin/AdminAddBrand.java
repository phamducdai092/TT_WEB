package controller.admin;

import bean.Brand;
import bean.Log;
import bean.User;
import dao.BrandDAO;
import service.LogService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(value = "/addBrand")
public class AdminAddBrand extends HttpServlet {
    String error = "Không thể thêm thương hiệu";
    String newBrand;
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("auth");

        newBrand = req.getParameter("new-brand");
        boolean addSuccess = BrandDAO.addNewBrand(newBrand);
        Brand brand = BrandDAO.getBrandByName(newBrand);

        String preData, afterData, table, role, actionDetail;

        LogService usl= new LogService();
        Log us=new Log();

        int userId = u.getId();


        table = "brands";
        us.setTables(table);

        role = "adminId = " + userId;
        us.setRole(role);

        actionDetail = "addBrand";
        us.setActionDetail(actionDetail);
        if(addSuccess) {
            req.getRequestDispatcher("./adminBrandManagement").forward(req, resp);
            afterData = brand.getId() + ", " + newBrand;
            us.setAfterData(afterData);
            usl.insert(us);
        }else {
            req.setAttribute("error", error);
            req.getRequestDispatcher("./adminBrandManagement").forward(req, resp);
        }

    }
}
