package dao;

import bean.Discount;
import bean.Image_Product;
import db.JDBIConnector;

import java.util.List;
import java.util.stream.Collectors;

public class DiscountDAO {
    public static double getDiscount(int id) {
        double discount = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("Select amount from discount\n" +
                                "where id = :id")
                        .bind("id", id)
                        .mapTo(double.class)
                        .findOne()
                        .orElse((double) 0)
        );
        return discount;
    }

    public static void changeDiscountDate(int id, String startDate, String endDate) {
        JDBIConnector.me().useHandle(handle ->
                handle.createUpdate("update discount set startDate = :startDate, endDate = :endDate where id = :id")
                        .bind("startDate", startDate)
                        .bind("endDate", endDate)
                        .bind("id", id)
                        .execute()
        );
    }

    public static void main(String[] args) {
        double amount = DiscountDAO.getDiscount(1);
        System.out.println(amount);

    }
}