package dao;

import bean.Product_Color;
import db.JDBIConnector;

import java.awt.*;
import java.util.List;
import java.util.stream.Collectors;

public class ColorDAO {
    public static List<Product_Color> getColorByProductId(int id) {
        List<Product_Color> colorList = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("Select product_color.nameColor from product_color\n" +
                                "where detailId = :id")
                        .bind("id", id)
                        .mapToBean(Product_Color.class)
                        .collect(Collectors.toList())
        );
        return colorList;
    }

    //    public static List<Product_Color> getCodeColor(String codeColor) {
//        List<Product_Color> colorList = JDBIConnector.me().withHandle(handle ->
//                handle.createQuery("Select Distinct product_color.codeColor from product_color\n"
//                        .matches(Product_Color.class)
//                        .collect(Collectors.toList()))
//        );
//        return colorList;
//    }
    public static List<Product_Color> getAllColor(){
        List<Product_Color> listColor = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT product_color.* " +
                                "From product_color ")
                        .mapToBean(Product_Color.class)
                        .collect(Collectors.toList())
        );
        return listColor;
    }
    public static List<Product_Color> getListColorCodeByIdProduct(int id) {
        List<Product_Color> listColor = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT product_color.* " +
                                "From product_color " +
                                "Inner Join product_details On product_color.detailId = product_details.id " +
                                "Where product_color.detailId = :id")
                        .bind("id", id)
                        .mapToBean(Product_Color.class)
                        .collect(Collectors.toList())
        );
        return listColor;
    }
    public static Product_Color getColorById(int id) {
        Product_Color color=  JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from product_color where id=?")
                        .bind(0,id)
                        .mapToBean(Product_Color.class)
                        .findOne()
                        .orElse(null));
        return color;
    }
    public static Product_Color getColorByName(String name) {
        Product_Color color=  JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from product_color where nameColor=?")
                        .bind(0,name)
                        .mapToBean(Product_Color.class)
                        .findOne()
                        .orElse(null));
        return color;
    }
    public static void main(String[] args) {

//        for (Product_Color color : ColorDAO.getAllColor()) {
//            System.out.println(color.toString());
//        }
        System.out.println(getColorByName("Đen"));
    }
}