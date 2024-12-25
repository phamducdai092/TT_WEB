package controller.sign;

import bean.User;
import org.json.JSONObject;
import service.KeyService;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "ReportLeakedPrivateKey", value = "/report-leaked-private-key")
public class ReportLeakedPrivateKey extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        PrintWriter out = resp.getWriter();
        HttpSession session = req.getSession();

        // Kiểm tra người dùng đã đăng nhập hay chưa
        User user = (User) session.getAttribute("auth");
        if (user == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.write("{\"error\":\"Bạn cần đăng nhập để thực hiện hành động này.\"}");
            return;
        }

        // Đọc và parse dữ liệu từ request body
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = req.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        String requestBody = sb.toString();
        JSONObject jsonObject = new JSONObject(requestBody);

        // Lấy mật khẩu từ yêu cầu
        String inputPassword = jsonObject.getString("password");

        try {
            // Kiểm tra mật khẩu
            boolean isPasswordValid = UserService.getInstance().isValidPassword(user.getUsername(), inputPassword);
            if (!isPasswordValid) {
                resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
                out.write("{\"error\":\"Mật khẩu không chính xác.\"}");
                return;
            }

            // Kiểm tra xem người dùng có key khả dụng không
            KeyService keyService = KeyService.getInstance();
            boolean hasAvailableKey = keyService.checkAvailableKey(user.getId());
            if (!hasAvailableKey) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write("{\"error\":\"Bạn không có key khả dụng để báo cáo lộ private key.\"}");
                return;
            }

            // Thực hiện báo cáo key
            keyService.reportLeakedPrivateKey(user.getId());
            resp.setStatus(HttpServletResponse.SC_OK);
            out.write("{\"message\":\"Đã báo cáo khóa riêng tư bị rò rỉ thành công.\"}");

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"error\":\"Đã xảy ra lỗi khi báo cáo khóa riêng tư bị rò rỉ.\"}");
        }
    }
}


