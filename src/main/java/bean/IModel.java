package bean;

public interface IModel {
    // Getter và Setter cho table
    public void setTables(String data);
    public String getTables();

    public void setAction(String data);
    public String getAction();

    // Getter và Setter cho role
    public void setRole(String data);
    public String getRole();

    // Getter và Setter cho actionDetail
    public void setActionDetail(String data);
    public String getActionDetail();

    // Getter và Setter cho predData (beforeData)
    public void setBeforeData(String data);
    public String getBeforeData();

    // Getter và Setter cho afterData
    public void setAfterData(String data);
    public String getAfterData();

    // Getter và Setter cho id
    public int getId();
    public void setId(int id);

    // Getter và Setter cho createDate
    public String getCreateDate();
    public void setCreateDate(String createDate);
}
