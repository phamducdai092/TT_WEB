package controller;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.List;
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 5 * 5)
@WebServlet("/uploadSignature")
public class UploadSignatureController extends HttpServlet {
    private String uploadedSignature;
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        if (ServletFileUpload.isMultipartContent(req)) {
            try {
                DiskFileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List<FileItem> formItems = upload.parseRequest(req);

                for (FileItem item : formItems) {
                    if (!item.isFormField()) {
                        // Đọc nội dung file
                        String uploadedSignature = item.getString("UTF-8");
                        session.setAttribute("uploadedSignature", uploadedSignature);
                        System.out.println("sign: " + uploadedSignature);
                        // Log tên file
                        System.out.println("File uploaded: " + item.getName());
                    }
                }

                // Trả trạng thái HTTP 200 OK nếu thành công
                resp.setStatus(HttpServletResponse.SC_OK);
            } catch (Exception ex) {
                ex.printStackTrace();
                // Trả trạng thái HTTP 500 Internal Server Error nếu có lỗi
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } else {
            // Trả trạng thái HTTP 400 Bad Request nếu request không hợp lệ
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

}
