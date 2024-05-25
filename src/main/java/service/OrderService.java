package service;

import dao.ProductDAO;

public class OrderService {
    public static OrderService instance;
    private ProductDAO productDAO;

    public OrderService(ProductDAO productDAO) {
        this.productDAO = productDAO;
    }

    public OrderService() {

    }

    public static OrderService getInstance() {
        if (instance == null) instance = new OrderService();
        return instance;
    }

}
