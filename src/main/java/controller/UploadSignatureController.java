package controller;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/uploadSignature")
public class UploadSignatureController extends HttpServlet {
    private String uploadedSignature;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (ServletFileUpload.isMultipartContent(req)) {
            try {
                // Cấu hình thư mục tạm thời để lưu file upload
                DiskFileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);

                // Parse request để lấy các file
                List<FileItem> formItems = upload.parseRequest(req);

                for (FileItem item : formItems) {
                    if (!item.isFormField()) {
                        // Đọc nội dung file
                        String content = item.getString("UTF-8"); // Giả sử chữ ký là dạng text
                        uploadedSignature = content; // Lưu chữ ký vào biến
                        System.out.println("Uploaded Signature: " + uploadedSignature);
                    }
                }

                resp.getWriter().write("Upload file thành công!");
            } catch (Exception ex) {
                ex.printStackTrace();
                resp.getWriter().write("Error!");
            }
        } else {
            resp.getWriter().write("Request không chứa data!");
        }
    }

    public String getUploadedSignature() {
        return uploadedSignature;
    }
}
