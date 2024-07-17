package dao;

import bean.Product;
import db.JDBIConnector;

import java.util.List;

public class StatisticsDAO {
    public static int getProductGrowth() {
        String sql = "";

        return 0;
    }

    public static List<Product> getTopSellingProducts() {
        String sql = "SELECT product_details.*, SUM(bill_details.quantity) AS Total_quantity \n" +
                "FROM  product_details JOIN bill_details ON product_details.id = bill_details.productId \n" +
                "GROUP BY product_details.id ORDER BY Total_quantity DESC LIMIT 10\n";

        List<Product> productList = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(sql)
                        .mapToBean(Product.class)
                        .list()
                );
        return productList;
    }

    public static List<Product> getOutOfStockProducts() {
        String sql = "SELECT * FROM product_details WHERE quantity < 10";
        List<Product> productList = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(sql)
                        .mapToBean(Product.class)
                        .list()
        );
        return productList;
    }

    public static int getProductsSoldLast7Days() {
        String sql = "SELECT SUM(bill.quantity) FROM bill WHERE bill.createDate > DATE_SUB(NOW(), INTERVAL 7 DAY)";
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery(sql)
                        .mapTo(Integer.class)
                        .findOne()
                        .orElse(0)
        );
    }

    public static int getProductsSoldLast1Month() {
        String sql = "SELECT SUM(bill.quantity) FROM bill WHERE bill.createDate > DATE_SUB(NOW(), INTERVAL 1 MONTH)";
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery(sql)
                        .mapTo(Integer.class)
                        .findOne()
                        .orElse(0)
        );
    }

    public static int getProductsSoldLast3Months() {
        String sql = "SELECT SUM(bill.quantity) FROM bill WHERE bill.createDate > DATE_SUB(NOW(), INTERVAL 3 MONTH)";
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery(sql)
                        .mapTo(Integer.class)
                        .findOne()
                        .orElse(0)
        );
    }

    public static void main(String[] args) {
//        System.out.println(getTopSellingProducts());
        System.out.println(getOutOfStockProducts());
    }

}
