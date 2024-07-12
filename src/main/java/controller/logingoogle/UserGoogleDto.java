package controller.logingoogle;

public class UserGoogleDto {
    private String id;
    private String mail;
    private boolean veryfied_mail;
    private String name;
    private String given_name;
    private String family_name;
    private String picture;

    public UserGoogleDto(String id, String mail, boolean veryfied_mail, String name,
                         String given_name, String family_name, String picture) {
        this.id = id;
        this.mail = mail;
        this.veryfied_mail = veryfied_mail;
        this.name = name;
        this.given_name = given_name;
        this.family_name = family_name;
        this.picture = picture;
    }
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }
    public boolean isVeryfied_mail() {
        return veryfied_mail;
    }

    public void setVeryfied_mail(boolean veryfied_mail) {
        this.veryfied_mail = veryfied_mail;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    public String getGiven_name() {
        return given_name;
    }

    public void setGiven_name(String given_name) {
        this.given_name = given_name;
    }


    public String getFamily_name() {
        return family_name;
    }

    public void setFamily_name(String family_name) {
        this.family_name = family_name;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    @Override
    public String toString() {
        return "UserGGDto{" +
                "id='" + id + '\'' +
                ", mail='" + mail + '\'' +
                ", veryfied_mail=" + veryfied_mail +
                ", name='" + name + '\'' +
                ", given_name='" + given_name + '\'' +
                ", family_name='" + family_name + '\'' +
                ", picture='" + picture + '\'' +
                '}';
    }
}
