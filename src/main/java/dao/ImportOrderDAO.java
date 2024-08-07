package dao;

import bean.ImportOrder;
import db.JDBIConnector;


import java.util.List;
import java.util.stream.Collectors;

public class ImportOrderDAO {
    ProductDAO prDao;
    ColorDAO clDao;
    public List<ImportOrder> selectAllImportData(){
        prDao=new ProductDAO();

        List<ImportOrder> importDataList= JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from import_orders")
                        .mapToBean(ImportOrder.class)
                        .collect(Collectors.toList()));
        for (ImportOrder i :
                importDataList) {
            int id = Integer.parseInt(i.getPr_id());
            i.setPr_id(prDao.getProductById(id).get(0).getName());
            int color=Integer.parseInt(i.getColor_id());
            i.setColor_id(clDao.getColorById(color).getNameColor());
        }
        return importDataList;
    }
    public static void addImportOrder(String pr_id,String color_id, int quantity, String timeSet){
        JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("insert into import_orders(pr_id, color_id, quantity, timeSet) " +
                                "values (:pr_id, :color_id, :quantity, :timeSet)")
                        .bind("pr_id", pr_id)
                        .bind("color_id", color_id)
                        .bind("quantity", quantity)
                        .bind("timeSet", timeSet)
                        .execute() > 0);
    }

    public static void main(String[] args) {
        List<ImportOrder> importDataList= JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from import_orders")
                        .mapToBean(ImportOrder.class)
                        .collect(Collectors.toList()));
        for (ImportOrder i:
             importDataList) {
            System.out.println(i.getId());
            System.out.println(i.getPr_id());
            System.out.println(i.getColor_id());
            System.out.println(i.getQuantity());
            System.out.println(i.getTimeSet());
        }
    }
}
