package controller.admin;

import bean.*;
import dao.BillDAO;
import dao.BrandDAO;
import dao.ProductDAO;
import dao.UserDAO;
import mail.MailService;
import service.LogService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet(value = "/adminEditBill")
public class AdminEditBill extends HttpServlet {
    LocalDateTime now = LocalDateTime.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
    String currentDateTime = now.format(formatter);

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String billIdStr = req.getParameter("billId");
        String idBillDetailStr = req.getParameter("idBillDetail");
        String userIdStr = req.getParameter("userId");
        String productIdStr = req.getParameter("productName");
        String quantityStr = req.getParameter("quantity");
        String colorStr = req.getParameter("color");
        String address = req.getParameter("address");
        int billId = Integer.parseInt(billIdStr);
        int idBillDetail = Integer.parseInt(idBillDetailStr);
        int productId = Integer.parseInt(productIdStr);
        int userId = Integer.parseInt(userIdStr);
        int quantity = Integer.parseInt(quantityStr);
        int color = Integer.parseInt(colorStr);

        Product product = ProductDAO.getProductId(productId);
        User user = UserDAO.getUserById(userId);

        double price = product.getTotalPrice()*quantity;
        boolean success = BillDAO.adminUpdateBill(billId, address, idBillDetail, productId, color, quantity, price);
        if (success) {
            MailService.send(user.getEmail(), "THÔNG BÁO CHỈNH SỬA ĐƠN HÀNG",
                    "Đơn hàng của bạn đã bị thay đổi vào " + currentDateTime + " , vui long kiểm tra lại thông tin tại webbantrong.com");
            req.setAttribute("message", "Đã cập nhật hóa đơn thành công!");
            req.getRequestDispatcher("./adminBillIndex").forward(req, resp);
            resp.sendRedirect("./adminBillIndex");
        }else{
            req.setAttribute("message", "Đã có lỗi xảy ra, vui lòng thử lại!");
            req.getRequestDispatcher("./adminBillIndex").forward(req, resp);
        }
    }
}
