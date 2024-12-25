package controller;

import bean.Bill;
import bean.User;
import dao.BillDAO;
import mail.MailService;
import service.SignUpService;
import service.UserService;
import util.Encode;
import util.VerificationCode;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

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
        // Lấy số lần nhập sai từ session, nếu không có thì gán giá trị mặc định là 0
        Integer failedAttempts = (Integer) session.getAttribute("failedAttempts");
        if (failedAttempts == null) {
            failedAttempts = 0;
        }

        // Kiểm tra xem người dùng có bị chặn tạm thời không
        Boolean isBlocked = (Boolean) session.getAttribute("blocked");
        if (isBlocked != null && isBlocked) {
            // Lấy thời gian khi người dùng bị chặn
            Long blockTime = (Long) session.getAttribute("blockTime");
            if (blockTime != null) {
                // Tính thời gian hiện tại
                long currentTime = System.currentTimeMillis();
                // Kiểm tra xem đã qua 1 phút từ lúc bị chặn hay chưa
                if (currentTime - blockTime >= 60000) { // 60000 milliseconds = 1 phút
                    // Đặt lại số lần nhập sai và cho phép đăng nhập lại
                    session.removeAttribute("failedAttempts");
                    session.removeAttribute("blocked");
                } else {
                    // Nếu chưa qua 1 phút, thông báo cho người dùng và không cho phép đăng nhập
                    req.setAttribute("errorAttempt", "Bạn đã nhập sai quá nhiều lần. Vui lòng thử lại sau 1 phút.");
                    req.getRequestDispatcher("./logIn.jsp").forward(req, resp);
                    return;
                }
            }
        }

        User user = UserService.getInstance().checkLogin(username, password);
        if (user != null) {
            if (user.getStatus() == 0) {
                req.setAttribute("isNotVerify", "Tài khoản chưa được xác thực");
                req.getRequestDispatcher("./logIn.jsp").forward(req, resp);
                return;
            }
            if (user.getStatus() != 0) {
                if (user.getRole() == 1) {
                    session.setAttribute("auth", user);
                    session.setAttribute("role", "admin");
                    resp.sendRedirect("./home");
                } else {
                    List<String> noti = new ArrayList<>();
                    List<Bill> bills = BillDAO.getInstance().getBillsNotDONE(user);
                    session.setAttribute("auth", user);
                    session.setAttribute("role", "user");
                    resp.sendRedirect("./home");
                }
            }
        } else {
            failedAttempts++; // Tăng số lần nhập sai
            session.setAttribute("failedAttempts", failedAttempts); // Lưu số lần nhập sai vào session

            if (failedAttempts >= 3) { // Kiểm tra nếu số lần nhập sai vượt quá ngưỡng
                // Tạm thời chặn người dùng và lưu thời gian chặn
                session.setAttribute("blocked", true);
                session.setAttribute("blockTime", System.currentTimeMillis());
                req.setAttribute("errorAttempt", "Bạn đã nhập sai quá nhiều lần. Vui lòng thử lại sau 1 phút.");
                req.getRequestDispatcher("./logIn.jsp").forward(req, resp);
                return;
            }

            req.setAttribute("username", username);
            req.setAttribute("error", "Bạn nhập sai tài khoản hoặc mật khẩu vui lòng nhập lại");
            req.getRequestDispatcher("./logIn.jsp").forward(req, resp);
        }
    }

    private List<String> getnotiListUser(List<Bill> bills) {
        List<String> noti = new ArrayList<>();
        int count = 0;
        int tempId = 0;
        String orderDetails = "";
        for (int i = 0; i < bills.size(); i++) {
            if (count == 0) {
                tempId = bills.get(i).getId();
                DecimalFormat decimalFormat = new DecimalFormat("#");
                String name = bills.get(i).getFullName();
                String phone = bills.get(i).getPhone();
                String address = bills.get(i).getAddress();
                String payment = bills.get(i).getPaymentMethod();
                String total = decimalFormat.format(bills.get(i).getTotalPrice());
                orderDetails = name + "," + phone + "," + address + "," + payment + "," + total + "," + bills.get(i).getProductName() + "," + bills.get(i).getProductColor() + "," + bills.get(i).getQuantity();
                if(i<bills.size()-1){
                    if (bills.get(i + 1).getId() == tempId) {
                        count=1;
                    } else {
                        noti.add(orderDetails);
                        orderDetails = "";
                        count = 0;
                    }
                }else{
                    noti.add(orderDetails);
                }
            } else {
                orderDetails += "," + bills.get(i).getProductName() + "," + bills.get(i).getProductColor() + "," + bills.get(i).getQuantity();
                if(i<bills.size()-1){
                    if (bills.get(i + 1).getId() == tempId) {
                        count=1;
                    } else {
                        noti.add(orderDetails);
                        orderDetails = "";
                        count = 0;
                    }
                }else{
                    noti.add(orderDetails);
                }
            }
        }
        return noti;
    }

    public static void main(String[] args) {
        User user = new User(24, "0", "dai123", "dai0601", "21130304@st.hcmuaf.edu.vn", 0, "", "", "2024-12-11", "", 0, 1);
        List<Bill> bill = BillDAO.getInstance().getBillsNotDONE(user);
        LoginController test= new LoginController();
        List<String> noti= test.getnotiListUser(bill);
        for(Bill b : bill) {
            System.out.println("b: "+b);
        }
        for(String s: noti){
            System.out.println("s: "+ s);
        }
    }
}
