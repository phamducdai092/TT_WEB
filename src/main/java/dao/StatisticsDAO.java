package dao;

import bean.InventoryQuantity;
import bean.Product;
import bean.Revenue;
import db.JDBIConnector;
import dto.ProductDTO;
import mapper.ProductMapper;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class StatisticsDAO {
    public static int getProductGrowth() {
        String sql = "";

        return 0;
    }

    public static List<ProductDTO> getTopSellingProducts() {
        String sql = "SELECT product_details.id, product_details.name, SUM(bill_details.quantity) AS saleQuantity " +
                "FROM product_details JOIN bill_details ON product_details.id = bill_details.productId " +
                "GROUP BY product_details.id ORDER BY saleQuantity DESC LIMIT 10";

        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery(sql)
                        .map(new ProductMapper())
                        .list()
        );
    }


    public static List<InventoryQuantity> getOutOfStockProducts() {
        String sql = "SELECT * FROM inv_quantity WHERE quantity < 10";
        List<InventoryQuantity> productList = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(sql)
                        .mapToBean(InventoryQuantity.class)
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
//        for (ProductDTO product : getTopSellingProducts()) {
//            System.out.println(product.toString());
//        }
        System.out.println(getOutOfStockProducts());
//        for (Revenue revenue : getCurrentProductRevenue()) {
//            revenue.setRevenue(revenue.getTotalPrice() * revenue.getSaleQuantity());
//            System.out.println(revenue.toString());
//        }
    }

}
