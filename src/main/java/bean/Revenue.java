package bean;

public class Revenue {
    private int id;
    private String name;
    private double totalPrice;
    private int saleQuantity;
    private double revenue;

    public Revenue(int id, String name, double totalPrice, int saleQuantity, double revenue) {
        this.id = id;
        this.name = name;
        this.totalPrice = totalPrice;
        this.saleQuantity = saleQuantity;
        this.revenue = revenue;
    }

    public Revenue() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getSaleQuantity() {
        return saleQuantity;
    }

    public void setSaleQuantity(int saleQuantity) {
        this.saleQuantity = saleQuantity;
    }

    public double getRevenue() {
        return revenue;
    }

    public void setRevenue(double revenue) {
        this.revenue = revenue;
    }

    @Override
    public String toString() {
        return "Revenue{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", totalPrice=" + totalPrice +
                ", saleQuantity=" + saleQuantity +
                ", revenue=" + revenue +
                '}';
    }
}
