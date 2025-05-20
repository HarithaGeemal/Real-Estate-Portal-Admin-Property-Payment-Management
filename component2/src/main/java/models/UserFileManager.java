package models;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class UserFileManager {
    private static final String USER_FILE = "users.txt";

    // Get all users from the file
    public List<ClientUser> getAllUsers() throws IOException {
        List<ClientUser> users = new ArrayList<>();
        File file = new File(USER_FILE);
        if (!file.exists()) {
            file.createNewFile();
        }
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 5) {
                    users.add(new ClientUser(parts[0], parts[1], parts[2], parts[3], parts[4]));
                }
            }
        }
        return users;
    }

    // Update a user in the file
    public void updateUser(ClientUser updatedUser) throws IOException {
        List<ClientUser> users = getAllUsers();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(USER_FILE))) {
            for (ClientUser user : users) {
                if (user.getId().equals(updatedUser.getId())) {
                    writer.write(updatedUser.getId() + "," + updatedUser.getUsername() + "," +
                            updatedUser.getPassword() + "," + updatedUser.getName() + "," +
                            updatedUser.getContact());
                } else {
                    writer.write(user.getId() + "," + user.getUsername() + "," +
                            user.getPassword() + "," + user.getName() + "," + user.getContact());
                }
                writer.newLine();
            }
        }
    }

    // Delete a user from the file
    public void deleteUser(String id) throws IOException {
        List<ClientUser> users = getAllUsers();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(USER_FILE))) {
            for (ClientUser user : users) {
                if (!user.getId().equals(id)) {
                    writer.write(user.getId() + "," + user.getUsername() + "," +
                            user.getPassword() + "," + user.getName() + "," + user.getContact());
                    writer.newLine();
                }
            }
        }
    }
}