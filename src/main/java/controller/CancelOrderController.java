package controller;

import service.BillService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/cancelOrder")
public class CancelOrderController extends HttpServlet {

    private final BillService billService = new BillService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();

        try {
            // Gọi OrderService để hủy đơn hàng
            boolean isCanceled = billService.cancelOrder(orderId);

            if (isCanceled) {
                // Trả về JSON response thành công
                out.write("{\"success\": true}");
            } else {
                // Trả về JSON response thất bại
                out.write("{\"success\": false}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.write("{\"success\": false}");
        } finally {
            out.flush();
            out.close();
        }
    }
}
