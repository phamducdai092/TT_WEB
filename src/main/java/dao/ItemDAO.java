package dao;

import bean.Item;
import db.JDBIConnector;

import java.util.List;
import java.util.stream.Collectors;

public class ItemDAO {
    public static List<Item> getAllList(){
        List<Item> itemList = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT product_details.id, product_details.name, image_products.link, product_details.totalPrice\n" +
                                " FROM product_details\n" +
                                " Join image_products on image_products.detailId = product_details.id\n" +
                                " WHERE product_details.id = id")
                        .mapTo(Item.class)
                        .collect(Collectors.toList())
        );
        return itemList;
    }

    public static Item getItemById(int id) {
        Item item = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT product_details.id, product_details.name, image_products.link, product_details.totalPrice\n" +
                                " FROM product_details\n" +
                                " Join image_products on image_products.detailId = product_details.id\n" +
                                " WHERE product_details.id = id")
                        .bind("id", id)
                        .mapTo(Item.class)
                        .findOne()
                        .orElse(null) // Giả sử trả về null nếu không tìm thấy sản phẩm
        );
        return item;
    }
    public static boolean checkQuantity(Item item){
        int pr_id= item.getProduct().getId();
        int color_id=ColorDAO.getColorByName(item.getColorName()).getId();
        Integer quantity= JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select quantity from inv_quantity where pr_id =:pr_id and color_id=:color_id")
                        .bind("pr_id",pr_id)
                        .bind("color_id",color_id)
                        .mapTo(Integer.class)
                        .findOne()
                        .orElse(0)
        );
        return quantity!=0;
    }

    public static void main(String[] args) {
//        System.out.println(checkQuantity(getItemById(1)));;
    }
}
