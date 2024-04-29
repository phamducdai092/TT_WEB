package controller;

import bean.User;
import mail.MailService;
import service.SignUpService;
import service.UserService;
import util.Encode;
import util.VerificationCode;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "controller.LoginController", value = "/log")
public class LoginController extends HttpServlet {
    public static final String SUBJECT = "MÃ XÁC MINH";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        password = Encode.toSHA1(password);

        HttpSession session = req.getSession();

        if (email != null) {
            handleEmailVerification(email, session, req, resp);
            return;
        }

        handleUserLogin(username, password, session, req, resp);
    }

    private void handleEmailVerification(String email, HttpSession session, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (SignUpService.getInstance().checkEmailExist(email)) {
            int verificationCode = VerificationCode.generateVerificationCode();
            session.setAttribute("verificationCode", verificationCode);
            session.setAttribute("verificationTime", System.currentTimeMillis());
            session.setAttribute("email", email);
            MailService.send(email, SUBJECT, "Đây là mã xác minh của bạn : " + verificationCode);
            req.getRequestDispatcher("verify.jsp").forward(req, resp);
        } else {
            req.setAttribute("email", email);
            req.setAttribute("isNotVerify", "Tài khoản chưa được xác thực");
            req.setAttribute("emailNotExist", "Email chưa được đăng ký");
            req.getRequestDispatcher("./logIn.jsp").forward(req, resp);
        }
    }

    private void handleUserLogin(String username, String password, HttpSession session, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = UserService.getInstance().checkLogin(username, password);
        if (user != null) {
            if (user.getStatus() == 0) {
                req.setAttribute("isNotVerify", "Tài khoản chưa được xác thực");
                req.getRequestDispatcher("./logIn.jsp").forward(req, resp);
                return;
            }
            if (user.getStatus() != 0) {
                session.setAttribute("auth", user);
                resp.sendRedirect("./index.jsp");
                return;
            }
            if (user.getStatus() == -1) {
                req.setAttribute("error", "Tài khoản của quý khách đã ăn ban, tạo tài khoản mới đê, then kiu");
                req.getRequestDispatcher("./logIn.jsp").forward(req, resp);
            }
        } else {
            req.setAttribute("username", username);
            req.setAttribute("error", "Bạn nhập sai tài khoản hoặc mật khẩu vui lòng nhập lại");
            req.getRequestDispatcher("./logIn.jsp").forward(req, resp);
        }
    }
}
