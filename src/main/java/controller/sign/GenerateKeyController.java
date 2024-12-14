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
            // Tạo key
            keyService.createKey(userId, keyLength);
            Key key = keyService.getKey();
            String privateKey = keyService.getPrivateKey();
            String publicKey = key.getPublicKey();

            // Lưu các key vào file
            String uploadDir = getServletContext().getRealPath("/keys");
            File directory = new File(uploadDir);
            if (!directory.exists()) {
                directory.mkdir();
            }

            // Đường dẫn file
            String privateKeyFileName = "private_key_" + userId + ".txt";
            String publicKeyFileName = "public_key_" + userId + ".txt";
            File privateKeyFile = new File(uploadDir, privateKeyFileName);
            File publicKeyFile = new File(uploadDir, publicKeyFileName);

            // Ghi file
            try (FileWriter privateKeyWriter = new FileWriter(privateKeyFile);
                 FileWriter publicKeyWriter = new FileWriter(publicKeyFile)) {
                privateKeyWriter.write(privateKey);
                publicKeyWriter.write(publicKey);
            }

            req.setAttribute("message", "");

            // Trả về đường dẫn tải file
            String responseJson = String.format(
                    "{\"publicKey\":\"%s\", \"privateKeyFile\":\"%s\"}",
                    publicKey, privateKeyFileName
            );

            resp.getWriter().write(responseJson);

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"error\":\"Có lỗi xảy ra khi tạo key: " + e.getMessage() + "\"}");
        }
    }
}
