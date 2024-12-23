package controller.sign;

import bean.User;
import service.KeyService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ReportLeakedPrivateKey", value = "/report-leaked-private-key")
public class ReportLeakedPrivateKey extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        User user = (User) req.getSession().getAttribute("auth");
        if (user == null) {
            resp.sendRedirect("/login");
            return;
        }
        int userId = user.getId();
        KeyService keyService = KeyService.getInstance();

        try {
            // Kiểm tra xem người dùng có key khả dụng không
            boolean hasAvailableKey = keyService.checkAvailableKey(userId);
            if (!hasAvailableKey) {
                // Nếu không còn key khả dụng, ngừng xử lý báo cáo
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("{\"error\":\"Bạn không có key khả dụng để báo cáo lộ private key.\"}");
                return;
            }

            // Nếu có key khả dụng, tiếp tục báo cáo
            keyService.reportLeakedPrivateKey(userId);

            String message = "Đã báo cáo khóa riêng tư bị rò rỉ thành công.";
            req.setAttribute("message", message);
            resp.sendRedirect(req.getContextPath() + "/sign-bill");

        } catch (Exception e) {
            e.printStackTrace();
            String message = "Đã xảy ra lỗi khi báo cáo khóa riêng tư bị rò rỉ.";
            req.setAttribute("message", message);
            resp.sendRedirect(req.getContextPath() + "/sign-bill");
        }
    }
}

