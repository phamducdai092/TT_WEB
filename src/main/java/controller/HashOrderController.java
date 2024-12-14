package controller;

import bean.Item;
import util.HashUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.List;

@WebServlet(value = "/hashOrder")
public class HashOrderController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy thông tin đơn hàng từ form
        String name = req.getParameter("name");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String payment = req.getParameter("payment");
        String total = req.getParameter("total");
        var cart = (List<Item>)req.getSession().getAttribute("cart");

        String orderDetails = name +","+ phone +","+ address +","+ payment +","+ total;
        for (var item : cart) {
            orderDetails = orderDetails +","+ item.getProduct().getName() +","+ item.getColorName()+","+item.getQuantity();
        }
        System.out.println(orderDetails);

        // Băm dữ liệu sử dụng MD5
        String hashedOrderDetails = HashUtil.hashMD5(orderDetails);

        // Tạo file chứa thông tin đã băm
        String realPath = getServletContext().getRealPath("./hash/orderInf");
        File file = new File(realPath);
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            writer.write(hashedOrderDetails);
        }

        // Đặt thông tin file tải xuống
        resp.setContentType("application/octet-stream");
        resp.setHeader("Content-Disposition", "attachment; filename=orderHash.txt");
        try (InputStream in = new FileInputStream(file);
             OutputStream out = resp.getOutputStream()) {
            byte[] buffer = new byte[1024];
            int length;
            while ((length = in.read(buffer)) > 0) {
                out.write(buffer, 0, length);
            }
        }
    }
}
