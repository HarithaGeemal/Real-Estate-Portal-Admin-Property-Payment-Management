package models;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

public class AdminFileManager {
    private static final String ADMIN_FILE = "admins.txt";
    private static final String LOG_FILE = "admin_logs.txt";

    public static class LogEntry {
        private String adminId;
        private String action;
        private long timestamp;

        public LogEntry(String adminId, String action, long timestamp) {
            this.adminId = adminId;
            this.action = action;
            this.timestamp = timestamp;
        }

        public String getAdminId() { return adminId; }
        public String getAction() { return action; }
        public long getTimestamp() { return timestamp; }

        public String getFormattedTimestamp() {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            return sdf.format(new Date(timestamp));
        }
    }

    public void logAction(String adminId, String action) throws IOException {
        System.out.println("Logging action: " + adminId + " - " + action);
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(LOG_FILE, true))) {
            writer.write(adminId + "|" + action + "|" + System.currentTimeMillis());
            writer.newLine();
        }
    }

    public List<LogEntry> getAllLogs() throws IOException {
        List<LogEntry> logs = new ArrayList<>();
        File file = new File(LOG_FILE);
        if (!file.exists()) {
            file.createNewFile();
        }
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|", 3);
                if (parts.length == 3) {
                    try {
                        logs.add(new LogEntry(parts[0], parts[1], Long.parseLong(parts[2])));
                    } catch (NumberFormatException e) {
                        System.out.println("Invalid timestamp in log entry: " + line);
                    }
                } else {
                    System.out.println("Invalid log entry format: " + line);
                }
            }
        }
        System.out.println("Retrieved logs: " + logs.size());
        Collections.reverse(logs); // Reverse the list to show latest action first
        return logs;
    }

    public void saveAdmin(AdminUser admin) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(ADMIN_FILE, true))) {
            writer.write(admin.getId() + "," + admin.getUsername() + "," + admin.getPassword() + "," + admin.getPrivileges());
            writer.newLine();
        }
        logAction(admin.getId(), "Added admin: Username=" + admin.getUsername() + ", Password=" + admin.getPassword() + ", Privileges=" + admin.getPrivileges());
    }

    public List<AdminUser> getAllAdmins() throws IOException {
        List<AdminUser> admins = new ArrayList<>();
        File file = new File(ADMIN_FILE);
        if (!file.exists()) {
            file.createNewFile();
        }
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 4) {
                    admins.add(new AdminUser(parts[0], parts[1], parts[2], parts[3]));
                }
            }
        }
        return admins;
    }

    public AdminUser findAdmin(String searchTerm) throws IOException {
        List<AdminUser> admins = getAllAdmins();
        for (AdminUser admin : admins) {
            if (admin.getId().equals(searchTerm) || admin.getUsername().equals(searchTerm)) {
                return admin;
            }
        }
        return null;
    }

    public void updateAdmin(AdminUser updatedAdmin) throws IOException {
        List<AdminUser> admins = getAllAdmins();
        AdminUser oldAdmin = null;
        for (AdminUser admin : admins) {
            if (admin.getId().equals(updatedAdmin.getId())) {
                oldAdmin = admin;
                break;
            }
        }

        StringBuilder action = new StringBuilder("Admin updated");
        List<String> changes = new ArrayList<>();

        if (oldAdmin != null) {
            if (!oldAdmin.getUsername().equals(updatedAdmin.getUsername())) {
                changes.add("Username changed from " + oldAdmin.getUsername() + " to " + updatedAdmin.getUsername());
            }
            if (!oldAdmin.getPassword().equals(updatedAdmin.getPassword())) {
                changes.add("Password changed from " + oldAdmin.getPassword() + " to " + updatedAdmin.getPassword());
            }
            if (!oldAdmin.getPrivileges().equals(updatedAdmin.getPrivileges())) {
                changes.add("Privileges changed from " + oldAdmin.getPrivileges() + " to " + updatedAdmin.getPrivileges());
            }
        }

        if (!changes.isEmpty()) {
            action.append(": ").append(String.join(", ", changes));
        } else {
            action.append(": No changes made");
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(ADMIN_FILE))) {
            for (AdminUser admin : admins) {
                if (admin.getId().equals(updatedAdmin.getId())) {
                    writer.write(updatedAdmin.getId() + "," + updatedAdmin.getUsername() + "," +
                            updatedAdmin.getPassword() + "," + updatedAdmin.getPrivileges());
                } else {
                    writer.write(admin.getId() + "," + admin.getUsername() + "," +
                            admin.getPassword() + "," + admin.getPrivileges());
                }
                writer.newLine();
            }
        }

        logAction(updatedAdmin.getId(), action.toString());
    }

    public void deleteAdmin(String id) throws IOException {
        List<AdminUser> admins = getAllAdmins();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(ADMIN_FILE))) {
            boolean deleted = false;
            for (AdminUser admin : admins) {
                if (!admin.getId().equals(id)) {
                    writer.write(admin.getId() + "," + admin.getUsername() + "," +
                            admin.getPassword() + "," + admin.getPrivileges());
                    writer.newLine();
                } else {
                    deleted = true;
                }
            }
            if (deleted) {
                logAction(id, "Deleted admin: ID=" + id);
            } else {
                System.out.println("No admin found with ID: " + id);
            }
        }
    }
}