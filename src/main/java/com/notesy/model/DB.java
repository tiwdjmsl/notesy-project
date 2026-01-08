package com.notesy.model;

import com.notesy.beans.Note;
import com.notesy.beans.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DB {

    private String url = "jdbc:mysql://localhost:3306/notesydb?useSSL=false&serverTimezone=Asia/Kuala_Lumpur&allowPublicKeyRetrieval=true";
    private String user = "root";
    private String pass = "root";
    private Connection con;

    private boolean DEBUG = true;
    
    // ================= DEBUG LOGGING =================
    private void debug(String message) {
        if (DEBUG) {
            System.out.println("[DB DEBUG] " + message);
        }
    }
    
    private void error(String message, Exception e) {
        System.err.println("[DB ERROR] " + message);
        if (DEBUG && e != null) {
            e.printStackTrace();
        }
    }
    
    // ================= DATABASE CONNECTION =================
    private void connect() throws Exception {
        debug("Connecting to database...");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, pass);
            debug("✓ Connected to database: " + url);
        } catch (Exception e) {
            error("✗ Failed to connect to database", e);
            throw e;
        }
    }

    private void close() {
        try { 
            if (con != null && !con.isClosed()) {
                con.close();
                debug("Connection closed");
            }
        } catch (Exception e) {
            error("Error closing connection", null);
        }
    }

    private void closeResources(ResultSet rs, PreparedStatement ps) {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
    }
    
    // ================= TEST CONNECTION =================
    public boolean testConnection() {
        debug("Testing database connection...");
        try {
            connect();
            if (con != null && !con.isClosed()) {
                debug("✓ Database connection SUCCESSFUL!");
                
                // Test with a simple query
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT 1 as test");
                if (rs.next()) {
                    debug("✓ Database query test PASSED");
                }
                rs.close();
                stmt.close();
                close();
                return true;
            }
        } catch (Exception e) {
            error("✗ Database connection FAILED", e);
            return false;
        }
        return false;
    }
    
    // ================= CHECK DATABASE =================
    public void checkDatabaseStatus() {
        debug("========== DATABASE STATUS CHECK ==========");
        
        try {
            connect();
            
            // Check notes table
            debug("Checking 'notes' table...");
            Statement stmt = con.createStatement();
            
            // Count total notes
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as total FROM notes");
            if (rs.next()) {
                int totalNotes = rs.getInt("total");
                debug("Total notes in database: " + totalNotes);
                
                if (totalNotes == 0) {
                    debug("WARNING: Database is EMPTY!");
                }
            }
            rs.close();
            
            // Show sample notes
            debug("\nSample of notes in database:");
            rs = stmt.executeQuery("SELECT note_id, title, author, is_paid, price FROM notes LIMIT 10");
            while (rs.next()) {
                debug("ID: " + rs.getInt("note_id") + 
                      " | Title: " + rs.getString("title") + 
                      " | Author: " + rs.getString("author") + 
                      " | Paid: " + rs.getBoolean("is_paid") + 
                      " | Price: " + rs.getDouble("price"));
            }
            rs.close();
            
            // Check table structure
            debug("\nNotes table structure:");
            rs = stmt.executeQuery("DESCRIBE notes");
            while (rs.next()) {
                debug("Column: " + rs.getString("Field") + 
                      " | Type: " + rs.getString("Type"));
            }
            
            stmt.close();
            debug("========== END DATABASE CHECK ==========");
            
        } catch (Exception e) {
            error("Error checking database", e);
        } finally {
            close();
        }
    }

    // ================= USER LOGIN =================
    public boolean validateUser(String username, String password) {
        debug("Validating user: " + username);
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            connect();
            ps = con.prepareStatement(
                "SELECT * FROM users WHERE username=? AND password=?");
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            boolean isValid = rs.next();
            debug("User validation result: " + isValid);
            return isValid;
        } catch (Exception e) { 
            error("Error validating user", e);
            return false;
        } finally { 
            closeResources(rs, ps);
            close(); 
        }
    }
    
    // ================= FEATURED NOTES =================
    public List<Note> getFeaturedNotes() {
        debug("Getting featured notes...");
        List<Note> list = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connect();
            ps = con.prepareStatement("SELECT * FROM notes ORDER BY note_id DESC LIMIT 4");
            rs = ps.executeQuery();

            int count = 0;
            while (rs.next()) {
                count++;
                Note note = mapNote(rs);
                debug("Featured note #" + count + ": " + note.getTitle());
                list.add(note);
            }
            debug("Total featured notes found: " + count);

        } catch (Exception e) { 
            error("Error getting featured notes", e);
        } finally { 
            closeResources(rs, ps);
            close(); 
        }

        return list;
    }
    
    // ================= GET USER =================
    public User getUserByUsername(String username) {
        debug("Getting user: " + username);

        String sql = "SELECT user_id, username, email, phone_num, password " +
                     "FROM users WHERE username=?";

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connect();
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();

            if (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setPhoneNum(rs.getString("phone_num"));
                u.setPassword(rs.getString("password"));

                debug("User found: " + username);
                return u;
            } else {
                debug("User NOT found: " + username);
            }

        } catch (Exception e) {
            error("Error getting user", e);
        } finally {
            closeResources(rs, ps);
            close();
        }

        return null;
    }


    // ================= NOTES BY CATEGORY =================
    public List<Note> getNotesByCategory(String category) {
        debug("Getting notes by category: " + category);
        List<Note> list = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connect();
            String sql = "SELECT * FROM notes WHERE category = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, category);
            rs = ps.executeQuery();
            
            int count = 0;
            while (rs.next()) {
                count++;
                Note n = mapNote(rs);
                list.add(n);
            }
            debug("Found " + count + " notes in category: " + category);
        } catch (Exception e) {
            error("Error getting notes by category", e);
        } finally {
            closeResources(rs, ps);
            close();
        }

        return list;
    }

    // ================= ADD NOTE =================
    public void addNote(Note n) {
        debug("Adding note: " + n.getTitle());
        PreparedStatement ps = null;

        try {
            connect();

            String sql =
                "INSERT INTO notes (user_id, title, description, category, likes, price, picture, file_path) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            ps = con.prepareStatement(sql);

            ps.setInt(1, n.getUserId());
            ps.setString(2, n.getTitle());
            ps.setString(3, n.getDescription());
            ps.setString(4, n.getCategory());
            ps.setInt(5, n.getLikes());
            ps.setDouble(6, n.getPrice());
            ps.setString(7, n.getPicture());
            ps.setString(8, n.getFilePath());

            int rows = ps.executeUpdate();
            debug("Note added. Rows affected: " + rows);

        } catch (Exception e) {
            error("Error adding note", e);
        } finally {
            closeResources(null, ps);
            close();
        }
    }


    public void updateNote(Note n) {
        debug("Updating note ID: " + n.getNoteId());
        PreparedStatement ps = null;

        try {
            connect();

            String sql = "UPDATE notes SET title=?, description=?, category=?, price=?, picture=?, file_path=?, likes=? " +
                         "WHERE note_id=?";

            ps = con.prepareStatement(sql);
            ps.setString(1, n.getTitle());
            ps.setString(2, n.getDescription());
            ps.setString(3, n.getCategory());
            ps.setDouble(4, n.getPrice());
            ps.setString(5, n.getPicture());
            ps.setString(6, n.getFilePath());
            ps.setInt(7, n.getLikes());
            ps.setInt(8, n.getNoteId());

            int rows = ps.executeUpdate();
            debug("Note updated. Rows affected: " + rows);

        } catch (Exception e) {
            error("Error updating note", e);
        } finally {
            closeResources(null, ps);
            close();
        }
    }


    // ================= GET NOTE BY ID =================
    public Note getNoteById(int id) {
        debug("Getting note by ID: " + id);
        Note n = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            connect();
            ps = con.prepareStatement("SELECT * FROM notes WHERE note_id=?");
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                n = mapNote(rs);
                debug("Note found: " + n.getTitle());
            } else {
                debug("Note NOT found with ID: " + id);
            }

        } catch (Exception e) { 
            error("Error getting note by ID", e);
        } finally { 
            closeResources(rs, ps);
            close(); 
        }

        return n;
    }

    // ================= GET NOTES BY USER =================
    public List<Note> getNotesByUser(String uploader) {
        debug("Getting notes for user: " + uploader);
        List<Note> list = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connect();
            // Note: Your table doesn't have 'uploader' column, using 'author' instead
            ps = con.prepareStatement("SELECT * FROM notes WHERE author=?");
            ps.setString(1, uploader);
            rs = ps.executeQuery();

            int count = 0;
            while (rs.next()) {
                count++;
                list.add(mapNote(rs));
            }
            debug("Found " + count + " notes for user: " + uploader);

        } catch (Exception e) { 
            error("Error getting notes by user", e);
        } finally { 
            closeResources(rs, ps);
            close(); 
        }

        return list;
    }

    // ================= GET ALL NOTES =================
    public List<Note> getAllNotes() {
        debug("Getting all notes...");
        List<Note> list = new ArrayList<>();
        Statement stmt = null;
        ResultSet rs = null;

        try {
            connect();
            stmt = con.createStatement();
            rs = stmt.executeQuery("SELECT * FROM notes");

            int count = 0;
            while (rs.next()) {
                count++;
                list.add(mapNote(rs));
            }
            debug("Total notes found: " + count);

        } catch (Exception e) { 
            error("Error getting all notes", e);
        } finally { 
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            close(); 
        }

        return list;
    }

    // ================= DELETE NOTE =================
    public void deleteNote(int id) {
        debug("Deleting note ID: " + id);
        PreparedStatement ps = null;
        try {
            connect();
            ps = con.prepareStatement("DELETE FROM notes WHERE note_id=?");
            ps.setInt(1, id);
            int rows = ps.executeUpdate();
            debug("Note deleted. Rows affected: " + rows);
        } catch (Exception e) { 
            error("Error deleting note", e);
        } finally { 
            closeResources(null, ps);
            close(); 
        }
    }

    private Note mapNote(ResultSet rs) throws Exception {
        Note n = new Note();

        n.setNoteId(rs.getInt("note_id"));
        n.setUserId(rs.getInt("user_id"));
        n.setTitle(rs.getString("title"));
        n.setDescription(rs.getString("description"));
        n.setCategory(rs.getString("category"));
        n.setLikes(rs.getInt("likes"));
        n.setPrice(rs.getDouble("price"));
        n.setPicture(rs.getString("picture"));
        n.setFilePath(rs.getString("file_path"));

        debug("Mapped note: " + n.getTitle());
        return n;
    }

    
    // ================= REGISTER USER =================
    public boolean registerUser(String username, String email, String password) {
        debug("Registering user: " + username);
        String sql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
        PreparedStatement ps = null;

        try {
            connect();
            ps = con.prepareStatement(sql);

            ps.setString(1, username.trim());
            ps.setString(2, email.trim());
            ps.setString(3, password.trim());

            debug("Inserting user: " + username);
            boolean ok = ps.executeUpdate() == 1;
            debug("Registration result: " + ok);
            return ok;

        } catch (Exception e) {
            error("Error registering user", e);
            return false;
        } finally {
            closeResources(null, ps);
            close();
        }
    }

    // ================= CHECK PURCHASE =================
    public boolean hasPurchased(String username, int noteId) {
        debug("Checking purchase - User: " + username + ", Note: " + noteId);
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            connect();
            ps = con.prepareStatement("SELECT * FROM purchases WHERE username=? AND note_id=?");
            ps.setString(1, username);
            ps.setInt(2, noteId);
            rs = ps.executeQuery();
            boolean hasPurchased = rs.next();
            debug("Purchase check result: " + hasPurchased);
            return hasPurchased;
        } catch (Exception e) { 
            error("Error checking purchase", e);
            return false;
        } finally { 
            closeResources(rs, ps);
            close(); 
        }
    }

    // ================= RECORD PURCHASE =================
    public void recordPurchase(int userId, int noteId) {
        debug("Recording purchase: user=" + userId + " note=" + noteId);

        PreparedStatement ps = null;

        try {
            connect();
            String sql = "INSERT INTO purchases (user_id, note_id, purchase_date) VALUES (?, ?, NOW())";
            ps = con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, noteId);

            ps.executeUpdate();
            debug("Purchase saved");
        }
        catch (Exception e) {
            error("Error recording purchase", e);
        }
        finally {
            closeResources(null, ps);
            close();
        }
    }
 // ================= PURCHASE NOTE (safe — avoids duplicates) =================
    public boolean purchaseNote(int userId, int noteId) {
        debug("Purchasing note: user=" + userId + " note=" + noteId);

        PreparedStatement ps = null;

        try {
            connect();

            // Prevent duplicate purchase
            String sql =
                "INSERT IGNORE INTO purchases(user_id, note_id, purchase_date) " +
                "VALUES (?, ?, NOW())";

            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, noteId);

            int rows = ps.executeUpdate();

            debug("Purchase result -> " + rows);
            return rows > 0;   // true = newly purchased, false = already owned
        }
        catch (Exception e) {
            error("Error purchasing note", e);
            return false;
        }
        finally {
            closeResources(null, ps);
            close();
        }
    }


    // ================= SEARCH NOTES =================
    public List<Note> searchNotes(String keyword) {
        debug("Searching notes: " + keyword);
        List<Note> list = new ArrayList<>();

        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllNotes();
        }

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connect();

            String sql = "SELECT * FROM notes " +
                         "WHERE LOWER(title) LIKE ? " +
                         "OR LOWER(description) LIKE ? " +
                         "OR LOWER(category) LIKE ? " +
                         "ORDER BY note_id DESC";

            ps = con.prepareStatement(sql);

            String pattern = "%" + keyword.trim().toLowerCase() + "%";
            ps.setString(1, pattern);
            ps.setString(2, pattern);
            ps.setString(3, pattern);

            rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapNote(rs));
            }

        } catch (Exception e) {
            error("Search failed", e);
        } finally {
            closeResources(rs, ps);
            close();
        }

        return list;
    }
    public List<Note> getNotesByUser(int userId) {
        debug("Getting notes uploaded by user_id = " + userId);
        List<Note> list = new ArrayList<>();

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connect();

            String sql = "SELECT * FROM notes WHERE user_id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapNote(rs));
            }

            debug("Notes found for user: " + list.size());

        } catch (Exception e) {
            error("Error getting user notes", e);
        } finally {
            closeResources(rs, ps);
            close();
        }

        return list;
    }
    public List<Note> getPurchasedNotes(int userId) {
        debug("Getting purchased notes for user_id = " + userId);
        List<Note> list = new ArrayList<>();

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connect();

            String sql =
                "SELECT n.* FROM notes n " +
                "JOIN purchases p ON n.note_id = p.note_id " +
                "WHERE p.user_id = ?";

            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapNote(rs));
            }

            debug("Purchased notes found: " + list.size());

        } catch (Exception e) {
            error("Error getting purchased notes", e);
        } finally {
            closeResources(rs, ps);
            close();
        }

        return list;
    }
    public List<Note> getFavoriteNotes(int userId) {
        debug("Getting favorite notes for user_id = " + userId);
        List<Note> list = new ArrayList<>();

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connect();

            String sql =
                "SELECT n.* FROM notes n " +
                "JOIN likes l ON n.note_id = l.note_id " +
                "WHERE l.user_id = ?";

            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapNote(rs));
            }

        } catch (Exception e) {
            error("Error getting favorite notes", e);
        } finally {
            closeResources(rs, ps);
            close();
        }

        return list;
    }
    public int countUserNotes(int userId) {
        int total = 0;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connect();
            String sql = "SELECT COUNT(*) FROM notes WHERE user_id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            rs = ps.executeQuery();
            if (rs.next()) total = rs.getInt(1);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        finally {
            closeResources(rs, ps);
            close();
        }

        return total;
    }
    public double getTotalSales(int userId) {
        double total = 0.0;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connect();

            String sql =
                "SELECT SUM(n.price) FROM purchases p " +
                "JOIN notes n ON p.note_id = n.note_id " +
                "WHERE n.user_id = ?";

            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            rs = ps.executeQuery();
            if (rs.next()) total = rs.getDouble(1);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        finally {
            closeResources(rs, ps);
            close();
        }

        return total;
    }
    public void addToCart(int userId, int noteId) {
        try {
            connect();

            String sql =
                "INSERT INTO cart(user_id, note_id) " +
                "SELECT ?, ? FROM DUAL " +
                "WHERE NOT EXISTS (SELECT 1 FROM cart WHERE user_id=? AND note_id=?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, noteId);
            ps.setInt(3, userId);
            ps.setInt(4, noteId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
    }
    public void addFavorite(int userId, int noteId) {
        try {
            connect();

            String sql =
                "INSERT INTO favorites(user_id, note_id) " +
                "SELECT ?, ? FROM DUAL " +
                "WHERE NOT EXISTS (SELECT 1 FROM favorites WHERE user_id=? AND note_id=?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, noteId);
            ps.setInt(3, userId);
            ps.setInt(4, noteId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
    }
    public List<Note> getCartItems(int userId) {
        List<Note> list = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connect();

            String sql =
                "SELECT n.* FROM cart c " +
                "JOIN notes n ON c.note_id = n.note_id " +
                "WHERE c.user_id = ?";

            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            while (rs.next()) list.add(mapNote(rs));
        }
        catch(Exception e){ e.printStackTrace(); }
        finally { closeResources(rs, ps); close(); }

        return list;
    }
    public void removeFromCart(int userId, int noteId) {
        try {
            connect();
            PreparedStatement ps =
                con.prepareStatement("DELETE FROM cart WHERE user_id=? AND note_id=?");
            ps.setInt(1, userId);
            ps.setInt(2, noteId);
            ps.executeUpdate();
        } catch(Exception e){ e.printStackTrace(); }
        finally { close(); }
    }
    public void checkoutCart(int userId) {
        try {
            connect();

            // Move to purchases table
            String insert =
                "INSERT INTO purchases(user_id, note_id, purchase_date) " +
                "SELECT user_id, note_id, NOW() FROM cart WHERE user_id=?";
            PreparedStatement ps1 = con.prepareStatement(insert);
            ps1.setInt(1, userId);
            ps1.executeUpdate();

            // Clear cart
            String clear = "DELETE FROM cart WHERE user_id=?";
            PreparedStatement ps2 = con.prepareStatement(clear);
            ps2.setInt(1, userId);
            ps2.executeUpdate();

        } catch(Exception e){ e.printStackTrace(); }
        finally { close(); }
    }
    public int getCartCount(int userId) {
        int count = 0;
        try {
            connect();
            PreparedStatement ps =
                con.prepareStatement("SELECT COUNT(*) FROM cart WHERE user_id=?");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) count = rs.getInt(1);
        } catch(Exception e){ e.printStackTrace(); }
        finally { close(); }
        return count;
    }

}