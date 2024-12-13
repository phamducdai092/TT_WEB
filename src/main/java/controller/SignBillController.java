package controller;

import bean.Key;
import bean.User;
import dao.KeyDAO;
import service.KeyService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(value = "/sign-bill")
public class SignBillController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("auth");
        if (user == null) {
            resp.sendRedirect("/login");
            return;
        }
        int id = user.getId();
        Key key = KeyService.getInstance().getKeyByUserId(id);
        if(key == null) {
            req.setAttribute("message", "Bạn chưa có khóa. Vui lòng tạo khóa trước khi ký hóa đơn.");
        } else {
            String publicKey = key.getPublicKey();
            List<Key> keys = KeyService.getInstance().getKeyListByUserId(id);
            if(publicKey == null || publicKey.isEmpty()) {
                req.setAttribute("message", "Bạn chưa có khóa công khai. Vui lòng tạo khóa trước khi ký hóa đơn.");
            } else {
                req.setAttribute("publicKey", publicKey);
            }
            if (keys.isEmpty()) {
                req.setAttribute("message", "Bạn chưa có khóa. Vui lòng tạo khóa trước khi ký hóa đơn.");
            } else {
                req.setAttribute("keys", keys);
            }
        }

        req.getRequestDispatcher("/signBill.jsp").forward(req, resp);
    }
}
