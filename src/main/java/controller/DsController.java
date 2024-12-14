package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/DigitalSign")
public class DsController extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String payment = req.getParameter("payment");
        String total = req.getParameter("total");
        System.out.println("name: " + name+" phone: " + phone+" address: " + address+" payment: " + payment+" total: " + total);
        // Gửi dữ liệu sang verifyUser.jsp
        req.setAttribute("name", name);
        req.setAttribute("phone", phone);
        req.setAttribute("address", address);
        req.setAttribute("payment", payment);
        req.setAttribute("total", total);

        // Chuyển tiếp đến verifyUser.jsp
        req.getRequestDispatcher("verifyUser.jsp").forward(req, resp);
    }
}
