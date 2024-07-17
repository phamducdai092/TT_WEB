package dao;

import bean.Bill;
import bean.Item;
import bean.User;
import db.JDBIConnector;
import org.jdbi.v3.core.Handle;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.stream.Collectors;

public class BillDAO {
    private static BillDAO instance;

    public static BillDAO getInstance() {
        if (instance == null) instance = new BillDAO();
        return instance;
    }

    private BillDAO() {
    }

    public List<Bill> getBillsByUser(User user) {
        try (Handle handle = JDBIConnector.me().open()) {
            return handle.createQuery("SELECT bills.id, bills.createDate, bills.full_name, bills.phone, bills.address, bills.payment_method, bills.`status` FROM bills WHERE userId = :userId")
                    .bind("userId", user.getId())
                    .mapToBean(Bill.class)
                    .list();
        }
    }


    public List<Bill> getBillList() {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from bills")
                        .mapToBean(Bill.class)
                        .collect(Collectors.toList())
        );
    }


    public static Bill adminViewBill(int id) {
        Bill bill = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM bills WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(Bill.class)
                        .findOne()
                        .orElse(null) // Giả sử trả về null nếu không tìm thấy hóa đơn
        );
        return bill;
    }


    public void createOrder(String name, String phone, String address, String payment, HttpServletRequest req) {
        var cart = (List<Item>)req.getSession().getAttribute("cart");
        var user = req.getSession().getAttribute("auth");
        if (cart != null && user != null) {
            var total = 0.0;
            for (var item : cart) {//đkiện
                if(item.getProduct().getQuantity()!=0) {
                    total += item.getPrice();
                }
            }
            var bill = new Bill((User) user, name, phone, address, total, payment);

            JDBIConnector.me().useHandle(handle -> {
                long billId = handle.createUpdate("INSERT INTO bills (userId, full_name, phone, address, totalPrice, payment_method) VALUES (:userId, :name, :phone, :address, :total, :payment)")
                        .bind("userId", bill.getUser().getId())
                        .bind("name", bill.getFullName())
                        .bind("phone", bill.getPhone())
                        .bind("address", bill.getAddress())
                        .bind("total", bill.getTotalPrice())
                        .bind("payment", bill.getPaymentMethod())
                        .executeAndReturnGeneratedKeys()
                        .mapTo(Long.class)
                        .findOnly();
                for (var item : cart) {//đkiện
                    System.out.println(item.getColorName());
                    if (item.getProduct().getQuantity() != 0) {
                        handle.createUpdate("INSERT INTO bill_details (billId, productId, quantity, total_price, product_color) VALUES (:billId, :productId, :quantity, :price, :color)")
                                .bind("billId", billId)
                                .bind("productId", item.getProduct().getId())
                                .bind("quantity", item.getQuantity())
                                .bind("price", item.getPrice())
                                .bind("color", ColorDAO.getColorByName(item.getColorName()).getId())
                                .execute();
                    }
                }
            });
        }
    }

    public Bill getBillById(int id) {
        Bill bill = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT bills.id, bills.status FROM bills WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(Bill.class)
                        .findOne()
                        .orElse(null) // Giả sử trả về null nếu không tìm thấy sản phẩm
        );
        return bill;
    }


    public static void changeInfoBill(int id, String status) {
        JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("UPDATE bills set " +
                                "status = :status" +
                                " where id = :id")
                        .bind("id", id)
                        .bind("status", status)
                        .execute()
        );
        System.out.println("DOne");
    }
    public static void updateQuantityInStock(int id, int quantity) {
        String update = "UPDATE product_details SET quantity = :newQuantity WHERE product_id = :id";
        JDBIConnector.me().withHandle(handle ->
                handle.createUpdate(update)
                        .bind("quantity", quantity)
                        .bind("product_id", id)
                        .execute()
        );
    }
    public void updateProductQuantityInStock(int newQuantity, int id) {
        JDBIConnector.me().useHandle(handle ->
                handle.createUpdate("UPDATE product_details SET quantity = :newQuantity WHERE id = :productId")
                        .bind("newQuantity", newQuantity)
                        .bind("productId", id)
                        .execute()
        );
    }

    public static void main(String[] args) {
    }

}