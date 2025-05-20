package models;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class PropertyFileManager {
    private static final String PROPERTY_FILE = "properties.txt";

    // Get all properties from the file
    public List<Property> getAllProperties() throws IOException {
        List<Property> properties = new ArrayList<>();
        File file = new File(PROPERTY_FILE);
        if (!file.exists()) {
            file.createNewFile();
        }
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 5) {
                    properties.add(new Property(parts[0], parts[1], parts[2], Double.parseDouble(parts[3]), parts[4]));
                }
            }
        }
        return properties;
    }

    // Update a property in the file
    public void updateProperty(Property updatedProperty) throws IOException {
        List<Property> properties = getAllProperties();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(PROPERTY_FILE))) {
            for (Property property : properties) {
                if (property.getId().equals(updatedProperty.getId())) {
                    writer.write(updatedProperty.getId() + "," + updatedProperty.getTitle() + "," +
                            updatedProperty.getDescription() + "," + updatedProperty.getPrice() + "," +
                            updatedProperty.getStatus());
                } else {
                    writer.write(property.getId() + "," + property.getTitle() + "," +
                            property.getDescription() + "," + property.getPrice() + "," + property.getStatus());
                }
                writer.newLine();
            }
        }
    }

    // Delete a property from the file
    public void deleteProperty(String id) throws IOException {
        List<Property> properties = getAllProperties();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(PROPERTY_FILE))) {
            for (Property property : properties) {
                if (!property.getId().equals(id)) {
                    writer.write(property.getId() + "," + property.getTitle() + "," +
                            property.getDescription() + "," + property.getPrice() + "," + property.getStatus());
                    writer.newLine();
                }
            }
        }
    }
}
