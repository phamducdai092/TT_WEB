package controller.admin;

import bean.Bill;
import com.google.gson.Gson;
import dao.BillDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(value = "/getBillDetails")
public class AdminGetBillDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy thông tin id từ tham số yêu cầu
        int idBillDetail = Integer.parseInt(req.getParameter("id"));

        // Lấy thông tin hóa đơn từ cơ sở dữ liệu
        Bill bill = BillDAO.getInstance().getBillByIdBillDetail(idBillDetail); // Giả sử bạn có một service để lấy hóa đơn từ DB

        // Chuyển thông tin hóa đơn thành JSON và trả về cho client
        resp.setContentType("application/json");
        resp.getWriter().write(new Gson().toJson(bill));
    }
}
