package dao;

import bean.Category;
import db.JDBIConnector;

import java.util.List;
import java.util.stream.Collectors;

public class CategoryDAO {

    public static List<Category> getAllCategory() {
        List<Category> categoryList = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select id, name, status from categories")
                        .mapToBean(Category.class)
                        .collect(Collectors.toList())
        );
        return categoryList;
    }

    public static String getCategoryName(int id) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT name FROM categories WHERE id = :id")
                        .bind("id", id)
                        .mapTo(String.class)
                        .findOne()
                        .orElse(null)
        );
    }
    public static Category getCategoryById(int id) {
        Category category = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM categories WHERE id = :id")
                        .bind("id", id)
                        .mapTo(Category.class)
                        .findOne()
                        .orElse(null)
        );
        return category;
    }
    public static int getCategoryByName(String name) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT id FROM categories WHERE name = :name")
                        .bind("name", name)
                        .mapTo(Integer .class)
                        .findOne()
                        .orElse(null)
        );
    }


    public static String getSupplierName(int id) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT name FROM suppliers WHERE id = :id")
                        .bind("id", id)
                        .mapTo(String.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public static boolean addNewCategory(String newCategory) {
        try {
            return JDBIConnector.me().withHandle(handle ->
                    handle.createUpdate("INSERT INTO categories(name) VALUES (:name)")
                            .bind("name", newCategory)
                            .execute() > 0);
        } catch (Exception e) {
            System.out.println("Không thể thêm");
            return false;
        }
    }

    public static boolean removeCategory(int id) {
        try {
            return JDBIConnector.me().withHandle(handle ->
                    handle.createUpdate("delete from categories where id = :id")
                            .bind("id", id)
                            .execute() > 0
            );
        } catch (Exception e) {
            return false;
        }
    }

    public static void hiddenCategory(String categoryId) {
        JDBIConnector.me().withHandle(handle -> {
            int currentStatus = handle.createQuery("SELECT status FROM categories WHERE id = :categoryId")
                    .bind("categoryId", categoryId)
                    .mapTo(int.class)
                    .one();

            int newStatus = (currentStatus == 1) ? 0 : 1;

            handle.createUpdate("UPDATE categories SET status = :newStatus WHERE id = :categoryId")
                    .bind("newStatus", newStatus)
                    .bind("categoryId", categoryId)
                    .execute();

            handle.createUpdate("UPDATE product_details SET statusCategory = :newStatus WHERE categoryId = :categoryId")
                    .bind("newStatus", newStatus)
                    .bind("categoryId", categoryId)
                    .execute();
            return true;
        });
    }

    public static void main(String[] args) {
//        Product product = ProductDAO.getProductById(4).get(0);
//        System.out.println(product.toString());
//        System.out.println(getDiscountAmount(product.getDiscountId()));
        CategoryDAO.hiddenCategory("1");
    }
}
