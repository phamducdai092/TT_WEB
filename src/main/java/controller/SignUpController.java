package controller;

import dao.UserDAO;
import mail.MailService;
import service.SignUpService;
import util.Encode;
import util.VerificationCode;
import bean.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(value = "/signup")
public class SignUpController extends HttpServlet {

    public static final String SUBJECT = "MÃ XÁC MINH";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = createUserFromRequest(req);

        HttpSession session = req.getSession();
        session.removeAttribute("verificationCode");
        session.removeAttribute("verificationTime");

        int verifyCode = VerificationCode.generateVerificationCode();
        int countError = 0;

        if (SignUpService.getInstance().checkUsernameExist(user.getUsername())) {
            countError++;
            req.setAttribute("usernameError", "Username đã tồn tại");
        }

        if (SignUpService.getInstance().checkEmailExist(user.getEmail())) {
            countError++;
            req.setAttribute("emailError", "Email đã tồn tại");
        }

        if (!SignUpService.getInstance().checkConfirmPassword(user.getPassword(), req.getParameter("confirm__password"))) {
            countError++;
            req.setAttribute("confirmWrong", "Xác thực mật khẩu thất bại");
        } else {
            user.setPassword(Encode.toSHA1(user.getPassword()));
        }

        if (countError == 0) {
            UserDAO.registerUser(user.getUsername(), user.getEmail(), user.getPassword());
            session.setAttribute("verificationCode", verifyCode);
            session.setAttribute("verificationTime", System.currentTimeMillis());
            session.setAttribute("email", user.getEmail());
            req.getRequestDispatcher("verify.jsp").forward(req, resp);
            MailService.send(user.getEmail(), SUBJECT, "Đây là mã xác minh của bạn : " + verifyCode);
        } else {
            req.setAttribute("user", user);
            req.getRequestDispatcher("./signUp.jsp").forward(req, resp);
        }
    }

    private User createUserFromRequest(HttpServletRequest req) {
        String username = req.getParameter("username__signup");
        String email = req.getParameter("email__signup");
        String password = req.getParameter("password__signup");
        return new User(username, password, email);
    }
}
