package controller.admin;

import bean.InventoryQuantity;
import bean.Product;
import bean.Revenue;
import com.google.gson.Gson;
import dto.ProductDTO;
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

        List<ProductDTO> productDTOs = null;
        List<Revenue> revenues = null;
        List<InventoryQuantity> inventoryQuantities = null;
        // Check dataType and fetch corresponding data
        if ("topSellingProducts".equals(dataType)) {

            productDTOs = StatisticsService.getInstance().getTopSellingProducts();
        } else if ("outOfStockProducts".equals(dataType)) {
            inventoryQuantities = StatisticsService.getInstance().getOutOfStockProducts();

        } else if ("revenueToday".equals(dataType)) {
            revenues = StatisticsService.getInstance().getCurrentProductRevenue();

            for (Revenue r : revenues) {
                r.setRevenue(r.getTotalPrice() * r.getSaleQuantity());
            }
        } else if ("revenue7Days".equals(dataType)) {
            revenues = StatisticsService.getInstance().get7DaysRevenue();

            for (Revenue r : revenues) {
                r.setRevenue(r.getTotalPrice() * r.getSaleQuantity());
            }
        } else if ("revenue30Days".equals(dataType)) {
            revenues = StatisticsService.getInstance().get30DaysRevenue();

            for (Revenue r : revenues) {
                r.setRevenue(r.getTotalPrice() * r.getSaleQuantity());
            }
        } else {
            // If no dataType or unknown dataType, return default data
            productDTOs = StatisticsService.getInstance().getTopSellingProducts(); // Default to top selling products
        }

        // Prepare response data
        String jsonInventoryQuantities = new Gson().toJson(inventoryQuantities);

        String jsonRevenues = new Gson().toJson(revenues);

        String jsonProductDTOs = new Gson().toJson(productDTOs);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        if (revenues != null) {
            resp.getWriter().write(jsonRevenues);
        } else if (productDTOs != null) {
            resp.getWriter().write(jsonProductDTOs);
        } else {
            resp.getWriter().write(jsonInventoryQuantities);
        }
    }
}

