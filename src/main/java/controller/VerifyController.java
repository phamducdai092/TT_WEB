package controller;

import dao.UserDAO;
import service.SignUpService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(value = "/verify")
public class VerifyController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("email");
        String emailForgetPassword = (String) session.getAttribute("emailForgetPassword");
        int userCodeEntered = Integer.parseInt(req.getParameter("userEnteredCode"));

        int verifyCode = (int) session.getAttribute("verificationCode");
        long codeTime = (long) session.getAttribute("verificationTime");

        long currentTime = System.currentTimeMillis();
        long expiredTime = currentTime - codeTime;

        if (email != null) {
            handleVerification(email, userCodeEntered, verifyCode, expiredTime, req, resp);
        } else if (emailForgetPassword != null) {
            handleVerification(emailForgetPassword, userCodeEntered, verifyCode, expiredTime, req, resp);
        } else {
            req.setAttribute("emailNotExist", "Email chưa được đăng ký");
            req.getRequestDispatcher("./verify.jsp").forward(req, resp);
        }
    }

    private void handleVerification(String email, int userCodeEntered, int verifyCode, long expiredTime, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (SignUpService.getInstance().checkEmailExist(email)) {
            if (expiredTime < 10 * 60 * 1000) {
                if (userCodeEntered == verifyCode) {
                    UserDAO.verifyUser(email);
                    req.setAttribute("verificationSuccess", "Xác minh thành công!");
                    req.getRequestDispatcher("./verify.jsp").forward(req, resp);
                } else {
                    req.setAttribute("errorMessage", "Mã xác minh không hợp lệ");
                    req.getRequestDispatcher("./verify.jsp").forward(req, resp);
                }
            }
        } else {
            req.setAttribute("email", email);
            req.setAttribute("emailNotExist", "Email chưa được đăng ký");
            req.getRequestDispatcher("./verify.jsp").forward(req, resp);
        }
    }
}
