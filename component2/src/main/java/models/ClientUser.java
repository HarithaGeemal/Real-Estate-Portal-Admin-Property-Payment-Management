package models;

public class ClientUser extends User {
    private String name;
    private String contact;

    public ClientUser(String id, String username, String password, String name, String contact) {
        super(id, username, password);
        this.name = name;
        this.contact = contact;
    }

    public String getName() { return name; }
    public String getContact() { return contact; }

    @Override
    public String getRole() { return "Client"; }
}
