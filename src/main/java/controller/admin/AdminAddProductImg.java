package controller.admin;

import dao.ImageDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;

@WebServlet(value = "/addProductImage")
@MultipartConfig
public class AdminAddProductImg extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = Integer.parseInt(req.getParameter("productId"));

        // Đường dẫn thư mục lưu ảnh
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploaded_images";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();  // Tạo thư mục nếu chưa tồn tại

        for (Part part : req.getParts()) {
            if (part.getName().equals("upload")) {
                String fileName = extractFileName(part);
                String filePath = uploadPath + File.separator + fileName;
                part.write(filePath);  // Lưu tệp tin vào thư mục

                String fileUrl = req.getContextPath() + "/uploaded_images/" + fileName;
                ImageDAO.addImg(fileUrl, productId);
            }
        }

        resp.sendRedirect("./adminViewProduct?productId=" + productId);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}
