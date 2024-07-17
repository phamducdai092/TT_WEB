package bean;

public class Log implements IModel {
    private int id;
    private String tables;
    private String role;
    private String action;
    private String actionDetail;
    private String predData;
    private String afterData;
    private String createDate;

    // Getter và Setter cho id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    public String getAction() {
        return action;
    }

    @Override
    public void setAction(String action) {
        this.action = action;
    }

    // Getter và Setter cho table


    public String getTables() {
        return tables;
    }

    public void setTables(String tables) {
        this.tables = tables;
    }

    public String getPredData() {
        return predData;
    }

    public void setPredData(String predData) {
        this.predData = predData;
    }

    // Getter và Setter cho role
    @Override
    public String getRole() {
        return role;
    }

    @Override
    public void setRole(String role) {
        this.role = role;
    }

    // Getter và Setter cho actionDetail
    @Override
    public String getActionDetail() {
        return actionDetail;
    }

    @Override
    public void setActionDetail(String actionDetail) {
        this.actionDetail = actionDetail;
    }

    // Getter và Setter cho predData (beforeData)
    @Override
    public String getBeforeData() {
        return predData;
    }

    @Override
    public void setBeforeData(String predData) {
        this.predData = predData;
    }

    // Getter và Setter cho afterData
    @Override
    public String getAfterData() {
        return afterData;
    }

    @Override
    public void setAfterData(String afterData) {
        this.afterData = afterData;
    }

    // Getter và Setter cho createDate
    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }
}
