package bean;

import java.util.Date;
import java.util.List;

public class ImportOrder {
    int id;
    List<Item> items;
    Date date;

    public ImportOrder(int id, List<Item> items, Date date) {
        this.id = id;
        this.items = items;
        this.date = date;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public List<Item> getItems() {
        return items;
    }

    public void setItems(List<Item> items) {
        this.items = items;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}


