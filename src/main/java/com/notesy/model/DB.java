package com.notesy.model;

import com.notesy.beans.Note;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DB {

    private String url = "jdbc:mysql://localhost:3306/notesy_db";
    private String user = "****";
    private String pass = "****";
    private Connection con;

    
    private void connect() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, user, pass);
    }

    private void close() {
        try { if (con != null) con.close(); } catch (Exception e) {}
    }

    // ================= USER LOGIN =================
    public boolean validateUser(String username, String password) {
        try {
            connect();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM users WHERE username=? AND password=?");
            ps.setString(1, username);
            ps.setString(2, password);
            return ps.executeQuery().next();
        } catch (Exception e) { e.printStackTrace(); }
        finally { close(); }
        return false;
    }
    
 // ================= FEATURED NOTES =================
    public List<Note> getFeaturedNotes() {

        List<Note> list = new ArrayList<>();

        try {
            connect();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM notes ORDER BY id DESC LIMIT 4"
            );
            ResultSet rs = ps.executeQuery();

            while (rs.next()) list.add(mapNote(rs));

        } catch (Exception e) { 
            e.printStackTrace(); 
        }
        finally { 
            close(); 
        }

        return list;
    }

    // ============== EXPLORE NOTE ==================
    public List<Note> getNotesByCategory(String category) {
        List<Note> list = new ArrayList<>();

        try {
        	connect();
            String sql = "SELECT * FROM notes WHERE category = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, category);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Note n = new Note();
                n.setNoteId(rs.getInt("note_id"));
                n.setTitle(rs.getString("title"));
                n.setDescription(rs.getString("description"));
                n.setCategory(rs.getString("category"));
                n.setAuthor(rs.getString("author"));
                n.setPrice(rs.getDouble("price"));
                n.setPaid(rs.getBoolean("is_paid"));
                n.setLikes(rs.getInt("likes"));
                n.setDownloads(rs.getInt("downloads"));
                list.add(n);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }


    // ================= ADD NOTE =================
    public void addNote(Note n) {
        try {
            connect();
            PreparedStatement ps = con.prepareStatement(
            "INSERT INTO notes(title,author,category,description,paid,price,likes,views,downloads,file_path,uploader) " +
            "VALUES (?,?,?,?,?,?,?,?,?,?,?)");

            ps.setString(1, n.getTitle());
            ps.setString(2, n.getAuthor());
            ps.setString(3, n.getCategory());
            ps.setString(4, n.getDescription());
            ps.setBoolean(5, n.isPaid());
            ps.setDouble(6, n.getPrice());
            ps.setInt(7, n.getLikes());
            ps.setInt(9, n.getDownloads());
            ps.setString(10, n.getFilePath());
            ps.setString(11, n.getUploader());

            ps.executeUpdate();

        } catch (Exception e) { e.printStackTrace(); }
        finally { close(); }
    }

    // ================= UPDATE NOTE =================
    public void updateNote(Note n) {
        try {
            connect();
            PreparedStatement ps = con.prepareStatement(
            "UPDATE notes SET title=?,author=?,category=?,description=?,paid=?,price=?,file_path=? " +
            "WHERE id=?");

            ps.setString(1, n.getTitle());
            ps.setString(2, n.getAuthor());
            ps.setString(3, n.getCategory());
            ps.setString(4, n.getDescription());
            ps.setBoolean(5, n.isPaid());
            ps.setDouble(6, n.getPrice());
            ps.setString(7, n.getFilePath());
            ps.setInt(8, n.getNoteId());

            ps.executeUpdate();

        } catch (Exception e) { e.printStackTrace(); }
        finally { close(); }
    }

    // ================= GET NOTE BY ID =================
    public Note getNoteById(int id) {
        Note n = null;
        try {
            connect();
            PreparedStatement ps =
                con.prepareStatement("SELECT * FROM notes WHERE id=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) n = mapNote(rs);

        } catch (Exception e) { e.printStackTrace(); }
        finally { close(); }

        return n;
    }

    // ================= GET MY NOTES =================
    public List<Note> getNotesByUser(String uploader) {

        List<Note> list = new ArrayList<>();

        try {
            connect();
            PreparedStatement ps =
                con.prepareStatement("SELECT * FROM notes WHERE uploader=?");
            ps.setString(1, uploader);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) list.add(mapNote(rs));

        } catch (Exception e) { e.printStackTrace(); }
        finally { close(); }

        return list;
    }

    // ================= EXPLORE (ALL NOTES) =================
    public List<Note> getAllNotes() {

        List<Note> list = new ArrayList<>();

        try {
            connect();
            ResultSet rs = con.createStatement()
                    .executeQuery("SELECT * FROM notes");

            while (rs.next()) list.add(mapNote(rs));

        } catch (Exception e) { e.printStackTrace(); }
        finally { close(); }

        return list;
    }

    // ================= DELETE NOTE =================
    public void deleteNote(int id) {
        try {
            connect();
            PreparedStatement ps =
                con.prepareStatement("DELETE FROM notes WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
        finally { close(); }
    }

    // ================= MAP RESULTSET → NOTE BEAN =================
    private Note mapNote(ResultSet rs) throws Exception {

        Note n = new Note();

        n.setNoteId(rs.getInt("id"));
        n.setTitle(rs.getString("title"));
        n.setAuthor(rs.getString("author"));
        n.setCategory(rs.getString("category"));
        n.setDescription(rs.getString("description"));
        n.setPaid(rs.getBoolean("paid"));
        n.setPrice(rs.getDouble("price"));
        n.setLikes(rs.getInt("likes"));
        n.setDownloads(rs.getInt("downloads"));
        n.setFilePath(rs.getString("file_path"));
        n.setUploader(rs.getString("uploader"));

        return n;
    }
 public void registerUser(String username, String password) {
    try {
        connect();
        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO users (username, password) VALUES (?, ?)"
        );
        ps.setString(1, username);
        ps.setString(2, password);
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        close();
    }
 }// ================= CHECK IF USER PURCHASED NOTE =================
 public boolean hasPurchased(String username, int noteId) {
	    try {
	        connect();
	        PreparedStatement ps = con.prepareStatement(
	            "SELECT * FROM purchases WHERE username=? AND note_id=?"
	        );
	        ps.setString(1, username);
	        ps.setInt(2, noteId);
	        return ps.executeQuery().next();
	    } catch (Exception e) { e.printStackTrace(); }
	    finally { close(); }
	    return false;
	}

	// ================= SAVE PURCHASE =================
	public void purchaseNote(String username, int noteId) {
	    try {
	        connect();
	        PreparedStatement ps = con.prepareStatement(
	            "INSERT INTO purchases(username, note_id) VALUES(?,?)"
	        );
	        ps.setString(1, username);
	        ps.setInt(2, noteId);
	        ps.executeUpdate();
	    } catch (Exception e) { e.printStackTrace(); }
	    finally { close(); }
	}
	public List<Note> searchNotes(String keyword) {
	    List<Note> list = new ArrayList<>();
	    try {
	        connect();
	        PreparedStatement ps = con.prepareStatement(
	            "SELECT * FROM notes WHERE title LIKE ? OR category LIKE ? OR author LIKE ?"
	        );
	        String k = "%" + keyword + "%";
	        ps.setString(1, k);
	        ps.setString(2, k);
	        ps.setString(3, k);

	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) list.add(mapNote(rs));

	    } catch (Exception e) { e.printStackTrace(); }
	    finally { close(); }

	    return list;
	}

}

