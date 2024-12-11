package service;

import bean.Product_Color;
import dao.ColorDAO;

import java.util.List;

public class ColorService {
    public static ColorService instance;
    public static ColorService getInstance() {
        if (instance == null) instance = new ColorService();
        return instance;
    }
    public List<Product_Color> getColorByProductId(int id) {
        return ColorDAO.getColorByProductId(id);
    }
    public List<Product_Color> getListColorCodeByIdProduct(int id) {
        return ColorDAO.getListColorCodeByIdProduct(id);
    }
    public List<Product_Color> getAllColor() {
        return ColorDAO.getAllColor();
    }
}
