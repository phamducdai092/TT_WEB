package dao;

import bean.Product;
import bean.Revenue;
import db.JDBIConnector;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

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

    public static List<Revenue> getCurrentProductRevenue() {
        String sql = "SELECT pd.id, pd.name, pd.totalPrice, SUM(bd.quantity) AS sale_quantity\n" +
                "FROM bills AS b \n" +
                "JOIN bill_details AS bd ON b.id = bd.billId\n" +
                "JOIN product_details AS pd ON bd.productId = pd.id\n" +
                "WHERE DATE(b.createDate) = CURDATE()\n" +
                "GROUP BY pd.id;\n";
        List<Revenue> revenue = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(sql)
                        .mapToBean(Revenue.class)
                        .collect(Collectors.toList()
        ));
        return revenue;
    }

    public static List<Revenue> get7DaysRevenue() {
        String sql = "SELECT pd.id, pd.name, pd.totalPrice, SUM(bd.quantity) AS sale_quantity\n" +
                "FROM bills AS b \n" +
                "JOIN bill_details AS bd ON b.id = bd.billId\n" +
                "JOIN product_details AS pd ON bd.productId = pd.id\n" +
                "WHERE DATE(b.createDate) BETWEEN CURDATE() - INTERVAL 7 DAY AND CURDATE()\n" +
                "GROUP BY pd.id;\n";
        List<Revenue> revenue = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(sql)
                        .mapToBean(Revenue.class)
                        .collect(Collectors.toList()
                        ));
        return revenue;
    }

    public static List<Revenue> get30DaysRevenue() {
        String sql = "SELECT pd.id, pd.name, pd.totalPrice, SUM(bd.quantity) AS sale_quantity\n" +
                "FROM bills AS b \n" +
                "JOIN bill_details AS bd ON b.id = bd.billId\n" +
                "JOIN product_details AS pd ON bd.productId = pd.id\n" +
                "WHERE DATE(b.createDate) BETWEEN CURDATE() - INTERVAL 30 DAY AND CURDATE()\n" +
                "GROUP BY pd.id;\n";
        List<Revenue> revenue = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(sql)
                        .mapToBean(Revenue.class)
                        .collect(Collectors.toList()
                        ));
        return revenue;
    }

    public static void main(String[] args) {
//        System.out.println(getTopSellingProducts());
//        System.out.println(getOutOfStockProducts());
        for (Revenue revenue : getCurrentProductRevenue()) {
//            revenue.setRevenue(revenue.getTotalPrice() * revenue.getSaleQuantity());
            System.out.println(revenue.toString());
        }
//        System.out.println(getTodayRevenue());
    }

}
