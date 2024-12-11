package service;

import bean.InventoryQuantity;
import bean.Product;
import bean.Revenue;
import dao.StatisticsDAO;
import dto.ProductDTO;

import java.util.List;

public class StatisticsService {
    private static StatisticsService instance;

    public static StatisticsService getInstance() {
        if (instance == null) instance = new StatisticsService();
        return instance;
    }

    public List<ProductDTO> getTopSellingProducts() {
        return StatisticsDAO.getTopSellingProducts();
    }

    public List<InventoryQuantity> getOutOfStockProducts() {
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

    public static void main(String[] args) {
//        System.out.println(getOutOfStockProducts());
    }
}
