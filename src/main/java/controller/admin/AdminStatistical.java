package controller.admin;

import bean.Product;
import com.google.gson.Gson;
import service.StatisticsService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "StatisticsController", value = "/statistics")
public class AdminStatistical extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String dataType = req.getParameter("dataType");

        List<Product> products = null;

        // Check dataType and fetch corresponding data
        if ("topSellingProducts".equals(dataType)) {
            products = StatisticsService.getInstance().getTopSellingProducts();
        } else if ("outOfStockProducts".equals(dataType)) {
            products = StatisticsService.getInstance().getOutOfStockProducts();
        } else {
            // If no dataType or unknown dataType, return default data
            products = StatisticsService.getInstance().getTopSellingProducts(); // Default to top selling products
        }

        // Prepare response data
        String json = new Gson().toJson(products);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(json);
    }
}
