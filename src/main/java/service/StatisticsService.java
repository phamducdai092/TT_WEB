package service;

import bean.Product;
import bean.Revenue;
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

    public List<Revenue> getCurrentProductRevenue() {
        return StatisticsDAO.getCurrentProductRevenue();
    }

    public List<Revenue> get7DaysRevenue() {
        return StatisticsDAO.get7DaysRevenue();
    }

    public List<Revenue> get30DaysRevenue() {
        return StatisticsDAO.get30DaysRevenue();
    }

}
