package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
@WebServlet(value = "/verifyStatus")
public class VerifyStatusController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        boolean isVerified = (boolean) session.getAttribute("isVerify");
        System.out.println("isVerified = " + isVerified);
        if (!isVerified) {
            resp.getWriter().write("{\"status\":\"error\", \"message\":\"Xác minh thất bại.\"}");
        }else{
            resp.getWriter().write("{\"status\":\"success\", \"verified\":true}");
        }
    }
}
