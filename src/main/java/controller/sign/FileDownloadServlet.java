package controller.sign;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
@WebServlet(name = "FileDownloadServlet", value = "/download")
public class FileDownloadServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String fileName = req.getParameter("fileName");

        // Đảm bảo fileName không null và không rỗng
        if (fileName == null || fileName.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "File name is missing.");
            return;
        }

        // Đảm bảo rằng file tồn tại trong thư mục "keys"
        String uploadDir = getServletContext().getRealPath("/keys");
        File file = new File(uploadDir, fileName);
        if (!file.exists()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found.");
            return;
        }

        // Đặt headers để tải file
        resp.setContentType("application/octet-stream");
        resp.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

        // Gửi nội dung file tới client
        try (InputStream in = new FileInputStream(file);
             OutputStream out = resp.getOutputStream()) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
            out.flush();
        }
    }
}
