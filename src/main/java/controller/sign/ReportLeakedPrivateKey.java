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
        User user = (User) req.getSession().getAttribute("auth");
        if (user == null) {
            resp.sendRedirect("/login");
            return;
        }
        int userId = user.getId();
        KeyService keyService = KeyService.getInstance();
        try {
            keyService.reportLeakedPrivateKey(userId);
        } catch (Exception e) {
            e.printStackTrace();
            String message = "Đã xảy ra lỗi khi báo cáo khóa riêng tư bị rò rỉ.";
            req.setAttribute("message", message);
            resp.sendRedirect(req.getContextPath() + "/sign-bill");
            return;
        }
        String message = "Đã báo cáo khóa riêng tư bị rò rỉ thành công.";
        req.setAttribute("message", message);
        resp.sendRedirect(req.getContextPath() + "/sign-bill");
    }
}
