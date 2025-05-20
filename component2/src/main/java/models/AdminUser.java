package models;

public class AdminUser extends User {
    private String privileges;

    public AdminUser(String id, String username, String password, String privileges) {
        super(id, username, password);
        this.privileges = privileges;
    }

    public String getPrivileges() { return privileges; }
    public void setPrivileges(String privileges) { this.privileges = privileges; }

    @Override
    public String getRole() {
        return "Admin";
    }
}
