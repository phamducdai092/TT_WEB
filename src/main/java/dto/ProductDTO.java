package dto;

public class ProductDTO {
    private int id;
    private String name;
    private int saleQuantity;

    public ProductDTO(int id, String name, int saleQuantity) {
        this.id = id;
        this.name = name;
        this.saleQuantity = saleQuantity;
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

    public int getSaleQuantity() {
        return saleQuantity;
    }

    public void setSaleQuantity(int saleQuantity) {
        this.saleQuantity = saleQuantity;
    }

    @Override
    public String toString() {
        return "ProductDTO{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", saleQuantity=" + saleQuantity +
                '}';
    }
}
