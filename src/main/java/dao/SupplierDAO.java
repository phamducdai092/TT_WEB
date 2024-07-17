package dao;

import bean.Category;
import bean.Supplier;
import db.JDBIConnector;

import java.util.List;
import java.util.stream.Collectors;

public class SupplierDAO {

    public static List<Supplier> getListSupplier() {
        List<Supplier> supplierList = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select id, name, email, phone, status from suppliers")
                        .mapToBean(Supplier.class)
                        .collect(Collectors.toList())
        );
        return supplierList;
    }

    public static void addNewSupplier(Supplier supplier) {
        JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("insert into suppliers(name, email, phone) values (:name, :email, :phone)")
                        .bind("name", supplier.getName())
                        .bind("email", supplier.getEmail())
                        .bind("phone", supplier.getPhone())
                        .execute()
                );
    }

    public static Supplier getSupplierById(int id) {
      Supplier supplier = JDBIConnector.me().withHandle(handle ->
                    handle.createQuery("select * from suppliers where id = :id")
                            .bind("id", id)
                            .mapTo(Supplier.class)
                            .findOne()
                            .orElse(null)
            );
     return supplier;
    }
    public static void hiddenSupplier(int id) {
        JDBIConnector.me().withHandle(handle -> {
            int currentStatus = handle.createQuery("SELECT status FROM suppliers WHERE id = :id")
                    .bind("id", id)
                    .mapTo(int.class)
                    .one();

            int newStatus = (currentStatus == 1) ? 0 : 1;

            handle.createUpdate("UPDATE suppliers SET status = :newStatus WHERE id = :id")
                    .bind("newStatus", newStatus)
                    .bind("id", id)
                    .execute();

            handle.createUpdate("UPDATE product_details SET statusSupplier = :newStatus WHERE id = :id")
                    .bind("newStatus", newStatus)
                    .bind("id", id)
                    .execute();
            return true;
        });
    }


}
