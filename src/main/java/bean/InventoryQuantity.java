package bean;

public class InventoryQuantity {
    int id;
    String pr_id;
    String color_id;
    int quantity;

    public InventoryQuantity() {
    }

    public InventoryQuantity(int id, String pr_id, String color_id, int quantity) {
        this.id = id;
        this.pr_id = pr_id;
        this.color_id = color_id;
        this.quantity = quantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPr_id() {
        return pr_id;
    }

    public void setPr_id(String pr_id) {
        this.pr_id = pr_id;
    }

    public String getColor_id() {
        return color_id;
    }

    public void setColor_id(String color_id) {
        this.color_id = color_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
