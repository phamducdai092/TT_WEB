package service;

import bean.Product;
import dao.StatisticsDAO;

import java.util.List;

public class StatisticsService {
    private static StatisticsService instance;

    public static StatisticsService getInstance() {
        if (instance == null) instance = new StatisticsService();
        return instance;
    }

    public List<Product> getTopSellingProducts() {
        return StatisticsDAO.getTopSellingProducts();
    }

    public List<Product> getOutOfStockProducts() {
        return StatisticsDAO.getOutOfStockProducts();
    }

}
