package controller.admin;

import bean.Product;
import bean.Revenue;
import com.google.gson.Gson;
import service.StatisticsService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "StatisticsController", value = "/statistics")
public class AdminStatistical extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String dataType = req.getParameter("dataType");

        List<Product> products = null;
        List<Revenue> revenues = null;
        int revenue = 0;
        // Check dataType and fetch corresponding data
        if ("topSellingProducts".equals(dataType)) {
            products = StatisticsService.getInstance().getTopSellingProducts();
        } else if ("outOfStockProducts".equals(dataType)) {
            products = StatisticsService.getInstance().getOutOfStockProducts();
        } else if ("revenueToday".equals(dataType)){
            revenues = StatisticsService.getInstance().getCurrentProductRevenue();
            for (Revenue r: revenues) {
                r.setRevenue(r.getTotalPrice() * r.getSaleQuantity());
            }
        } else if ("revenue7Days".equals(dataType)) {
            revenues = StatisticsService.getInstance().get7DaysRevenue();
            for (Revenue r: revenues) {
                r.setRevenue(r.getTotalPrice() * r.getSaleQuantity());
            }
        } else if ("revenue30Days".equals(dataType)) {
            revenues = StatisticsService.getInstance().get30DaysRevenue();
            for (Revenue r: revenues) {
                r.setRevenue(r.getTotalPrice() * r.getSaleQuantity());
            }
        }
        else {
            // If no dataType or unknown dataType, return default data
            products = StatisticsService.getInstance().getTopSellingProducts(); // Default to top selling products
        }

        // Prepare response data
        String jsonProducts = new Gson().toJson(products);
        String jsonRevenues = new Gson().toJson(revenues);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        if(revenues != null) {
            resp.getWriter().write(jsonRevenues);
        } else {
            resp.getWriter().write(jsonProducts);
        }
    }
}

