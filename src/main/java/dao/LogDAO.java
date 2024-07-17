package dao;

import bean.Log;
import db.JDBIConnector;
import bean.IModel;

import java.util.List;

public class LogDAO {
    public static void update(IModel model){
        JDBIConnector.me().withHandle(handle -> {
            return handle.createUpdate("INSERT into log (tables, role, action, action_detail, afterData, beforeData, createDate)  VALUES (:tables, :role, :action, :actionDetail, :afterData, :beforeData, NOW())")
                    .bind("tables", model.getTables())
                    .bind("role", model.getRole())
                    .bind("action", "update")
                    .bind("actionDetail", model.getActionDetail())
                    .bind("afterData", model.getAfterData())
                    .bind("beforeData", model.getBeforeData())
                    .execute();
        });
    }
    public static void insert(IModel model){
        JDBIConnector.me().withHandle(handle -> {
            return handle.createUpdate("INSERT into log (tables, role, action, action_detail, afterData, beforeData, createDate)  VALUES (:tables, :role, :action, :actionDetail, :afterData, :beforeData, NOW())")
                    .bind("tables", model.getTables())
                    .bind("role", model.getRole())
                    .bind("action", "insert")
                    .bind("actionDetail", model.getActionDetail())
                    .bind("afterData", model.getAfterData())
                    .bind("beforeData", model.getBeforeData())
                    .execute();
        });
    }
        public static List<Log> getAllLogs() {
            return JDBIConnector.me().withHandle(handle ->
                    handle.createQuery("SELECT * FROM log")
                            .mapToBean(Log.class)
                            .list()
            );
        }

    public static void main(String[] args) {
        List<Log> list= getAllLogs();
        for (Log l:
             list) {
            System.out.println(l.getTables());;
        }
        }
}
