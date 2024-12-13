package controller;

import bean.Key;
import bean.User;
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
        // Lấy thông tin người dùng từ session
        User user = (User) req.getSession().getAttribute("auth");
        if (user == null) {
            resp.sendRedirect("/login");
            return;
        }

        int userId = user.getId();
        KeyService keyService = KeyService.getInstance();

        // Lấy danh sách khóa và khóa chính
        List<Key> keys = keyService.getKeyListByUserId(userId);
        Key mainKey = keyService.getKeyByUserId(userId);

        // Kiểm tra nếu không có bất kỳ khóa nào
        if (keys == null || keys.isEmpty()) {
            req.setAttribute("message", "Bạn chưa có khóa. Vui lòng tạo khóa trước khi ký hóa đơn.");
        } else {
            req.setAttribute("keys", keys);
        }
        if (mainKey == null || mainKey.getPublicKey() == null || mainKey.getPublicKey().isEmpty()) {
            // Kiểm tra nếu khóa chính không hợp lệ
            req.setAttribute("message", "Bạn chưa có khóa công khai. Vui lòng tạo khóa trước khi ký hóa đơn.");
        } else {
            // Gán dữ liệu vào request để hiển thị
            req.setAttribute("publicKey", mainKey.getPublicKey());
        }

        // Chuyển hướng đến trang JSP
        req.getRequestDispatcher("/signBill.jsp").forward(req, resp);
    }
}
