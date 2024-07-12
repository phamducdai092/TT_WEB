package bean;

public class Category {
    private int id;
    private String name;
    private int status;

    public Category(int id, String name) {
        this.id = id;
        this.name = name;
    }
    public Category(int id, String name, int status) {
        this.id = id;
        this.name = name;
        this.status = status;
    }


    public Category() {
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

    public int getStatus(){return status;}


    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", name='" + name + '\'' +
                "}\n";
    }
}
