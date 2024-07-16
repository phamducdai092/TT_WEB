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

        List<Product> topSellingProducts = StatisticsService.getInstance().getTopSellingProducts();
        List<Product> outOfStockProducts = StatisticsService.getInstance().getOutOfStockProducts();


        Map<String, Object> data = new HashMap<>();
        data.put("topSellingProducts", topSellingProducts);
        data.put("outOfStockProducts", outOfStockProducts);

        String json = new Gson().toJson(data);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(json);
    }
}
