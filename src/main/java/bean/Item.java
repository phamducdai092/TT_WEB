package bean;

import dao.ColorDAO;
import dao.ProductDAO;
import dao.ReviewDAO;
import db.JDBIConnector;

import java.io.Serializable;

public class Item implements Serializable {
    private int id;
    private Product product;
    private int quantity;
    private double price;
    private String colorName;

    public Item(Product product, int quantity, String colorName) {
        this.product = product;
        this.quantity = quantity;
        this.colorName = colorName;
        this.price = product.getTotalPrice();
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public void setColorName(String colorName) {
        this.colorName = colorName;
    }

    public String getColorName() {
        return colorName;
    }

    @Override
    public String toString() {
        return "Item{" +
                "id=" + id +
                ", product=" + product +
                ", quantity=" + quantity +
                ", price=" + price +
                '}';
    }
    public boolean checkQuantity(){
        int pr_id= this.getProduct().getId();
        String colorName=this.getColorName();
        System.out.println(colorName);
        int color_id=ColorDAO.getColorByName(colorName).getId();
        Integer quantity= JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select quantity from inv_quantity where pr_id =:pr_id and color_id=:color_id")
                        .bind("pr_id",pr_id)
                        .bind("color_id",color_id)
                        .mapTo(Integer.class)
                        .findOne()
                        .orElse(0)
        );
        System.out.println(quantity);
        return quantity!=0;
    }

    public static void main(String[] args) {
        Item i= new Item(ReviewDAO.getProductById(64), 2, "trắng");
        System.out.println(i.checkQuantity());;
    }
}