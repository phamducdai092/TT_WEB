package dao;

import bean.ImportOrder;
import bean.InventoryQuantity;
import db.JDBIConnector;

import java.util.List;
import java.util.stream.Collectors;

public class InventoryQuantityDAO {
    ProductDAO prDao;
    ColorDAO clDao;
    public List<InventoryQuantity> getAllInventoryQuantity(){
        prDao=new ProductDAO();

        List<InventoryQuantity> InventoryQuantityList= JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from inv_quantity")
                        .mapToBean(InventoryQuantity.class)
                        .collect(Collectors.toList()));
        for (InventoryQuantity i :
                InventoryQuantityList) {
            int id = Integer.parseInt(i.getPr_id());
            i.setPr_id(prDao.getProductById(id).get(0).getName());
            int color=Integer.parseInt(i.getColor_id());
            i.setColor_id(clDao.getColorById(color).getNameColor());
        }
        return InventoryQuantityList;
    }

    public static void main(String[] args) {
        List<InventoryQuantity> importDataList= JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from import_orders")
                        .mapToBean(InventoryQuantity.class)
                        .collect(Collectors.toList()));
        for (InventoryQuantity i:
                importDataList) {
            System.out.println(i.getId());
            System.out.println(i.getPr_id());
            System.out.println(i.getColor_id());
            System.out.println(i.getQuantity());
        }
    }
}
