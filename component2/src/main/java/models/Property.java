package models;

public class Property {
    private String id;
    private String title;
    private String description;
    private double price;
    private String status; // e.g., "pending", "approved", "rejected"

    public Property(String id, String title, String description, double price, String status) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.price = price;
        this.status = status;
    }

    public String getId() { return id; }
    public String getTitle() { return title; }
    public String getDescription() { return description; }
    public double getPrice() { return price; }
    public String getStatus() { return status; }

    public void setStatus(String status) { this.status = status; }
    public void setTitle(String title) { this.title = title; }
    public void setDescription(String description) { this.description = description; }
    public void setPrice(double price) { this.price = price; }
}
