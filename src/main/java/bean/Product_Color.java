package bean;

public class Product_Color {
    private int id;
    private String nameColor;
    private String codeColor;

    public Product_Color() {
    }

    public String getCodeColor() {
        return codeColor;
    }

    public void setCodeColor(String codeColor) {
        this.codeColor = codeColor;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNameColor() {
        return nameColor;
    }

    public void setNameColor(String nameColor) {
        this.nameColor = nameColor;
    }

    @Override
    public String toString() {
        return "Product_Color{" +
                "id=" + id +
                ", nameColor='" + nameColor + '\'' +
                ", codeColor='" + codeColor + '\'' +
                '}';
    }
}