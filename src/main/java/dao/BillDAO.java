package dao;

import bean.Bill;
import bean.Item;
import bean.User;
import db.JDBIConnector;
import mapper.BillMapper;
import org.jdbi.v3.core.Handle;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
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
            return handle.createQuery("SELECT b.*, pd.name, bd.quantity, bd.product_color \n" +
                            "FROM bills AS b JOIN bill_details AS bd ON b.id = bd.billId\n" +
                            "JOIN product_details AS pd ON bd.productId = pd.id\n" +
                            "WHERE b.userId = :userId\n")
                    .bind("userId", user.getId())
                    .map(new BillMapper())
                    .list();
        }
    }


    public List<Bill> getBillList() {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT b.*, pd.name, bd.id, bd.quantity, bd.product_color \n" +
                                "FROM bills AS b JOIN bill_details AS bd ON b.id = bd.billId\n" +
                                "JOIN product_details AS pd ON bd.productId = pd.id")
                        .map(new BillMapper())
                        .collect(Collectors.toList())
        );
    }
    public static Bill getBillByIdBillDetail(int IdBillDetail) {
        Bill bill = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT b.*, pd.name, bd.id, bd.quantity, bd.product_color \n" +
                                "FROM bills AS b JOIN bill_details AS bd ON b.id = bd.billId\n" +
                                "JOIN product_details AS pd ON bd.productId = pd.id\n"  +
                                "WHERE bd.id = :IdBillDetail\n")
                        .bind("IdBillDetail", IdBillDetail)
                        .map(new BillMapper())
                        .findOne()
                        .orElse(null)
        );
        return bill;
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
                if(item.checkQuantity()) {
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
                    System.out.println(item.checkQuantity());
                    if (item.checkQuantity()) {
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
    User user = new User(1, "0", "123", "123", "123", 0, "123", "123", "0", "0", 1, 1);
    Bill bill = BillDAO.getInstance().getBillByIdBillDetail(8);
        System.out.println(bill);


    }

}