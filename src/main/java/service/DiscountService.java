package service;

import dao.DiscountDAO;

public class DiscountService {
    public static DiscountService instance;
    public static DiscountService getInstance() {
        if (instance == null) instance = new DiscountService();
        return instance;
    }
    public double getDiscount(int id) {
        return DiscountDAO.getDiscount(id);
    }
}
