package controller.sign;

import bean.Key;
import service.KeyService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

@WebServlet(name = "controller.sign.GenerateKeyController", value = "/generate-key")
public class GenerateKeyController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        KeyService keyService = KeyService.getInstance();
        int userId = Integer.parseInt(req.getParameter("userId"));
        int keyLength = Integer.parseInt(req.getParameter("keyLength"));

        try {
            // Kiểm tra nếu user đã có key chưa hết hạn
            Key existingKey = keyService.getKeyByUserIdAndExpiredDateNull(userId);
            if (existingKey != null) {
                // Key hiện tại vẫn còn khả dụng, không tạo key mới
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("{\"error\":\"Bạn đã có một key chưa hết hạn. Vui lòng báo cáo lộ key trước khi tạo key mới.\"}");
                return;
            }

            // Tạo key mới
            keyService.createKey(userId, keyLength);
            Key key = keyService.getKey();
            String privateKey = keyService.getPrivateKey();
            String publicKey = key.getPublicKey();

            // Trả về JSON chứa public key và private key dưới dạng nội dung thay vì file
            String responseJson = String.format(
                    "{\"publicKey\":\"%s\", \"privateKey\":\"%s\"}",
                    publicKey, privateKey
            );
            resp.getWriter().write(responseJson);

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"error\":\"Có lỗi xảy ra khi tạo key: " + e.getMessage() + "\"}");
        }
    }
}
