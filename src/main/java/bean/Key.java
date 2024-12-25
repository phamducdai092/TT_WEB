package bean;

public class Key {
    private int id;
    private String publicKey;
    private String createDate;
    private String expireDate;
    private int userId;

    public Key() {
    }

    public Key(int id, String publicKey, String createDate, String expireDate, int userId) {
        this.id = id;
        this.publicKey = publicKey;
        this.createDate = new java.util.Date().toString();
        this.expireDate =  new java.util.Date().toString();
        this.userId = userId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPublicKey() {
        return publicKey;
    }

    public void setPublicKey(String publicKey) {
        this.publicKey = publicKey;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getExpireDate() {
        return expireDate;
    }

    public void setExpireDate(String expireDate) {
        this.expireDate = expireDate;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
