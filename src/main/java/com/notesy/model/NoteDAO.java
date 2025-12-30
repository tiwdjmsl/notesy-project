package com.notesy.model;

import com.notesy.beans.Note;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NoteDAO {

    /* -----------------------------
       MAP RESULTSET → NOTE OBJECT
    ------------------------------*/
    private Note mapRow(ResultSet rs) throws SQLException {
        Note n = new Note();

        n.setNoteId(rs.getInt("note_id"));
        n.setTitle(rs.getString("title"));
        n.setDescription(rs.getString("description"));
        n.setFilePath(rs.getString("file_path"));

        n.setPaid(rs.getBoolean("is_paid"));
        n.setPrice(rs.getDouble("price"));

        n.setCategory(rs.getString("category"));
        n.setAuthor(rs.getString("author"));
        n.setUploader(rs.getString("uploader"));

        n.setLikes(rs.getInt("likes"));
        n.setViews(rs.getInt("views"));
        n.setDownloads(rs.getInt("downloads"));

        return n;
    }


    /* -----------------------------
              GET ALL NOTES
    ------------------------------*/
    public List<Note> getAllNotes() throws SQLException {

        List<Note> list = new ArrayList<>();

        String sql = "SELECT * FROM notes ORDER BY note_id DESC";

        try (Connection conn = DB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }

        return list;
    }


    /* -----------------------------
            SEARCH (Explore)
       NULL-SAFE for category/author
    ------------------------------*/
    public List<Note> searchNotes(String keyword, String subject) throws SQLException {

        List<Note> list = new ArrayList<>();

        String sql =
            "SELECT * FROM notes WHERE " +
            "(title LIKE ? OR IFNULL(author,'') LIKE ? OR IFNULL(category,'') LIKE ?) ";

        if (subject != null && !subject.equals("all")) {
            sql += "AND category LIKE ? ";
        }

        sql += "ORDER BY note_id DESC";

        try (Connection conn = DB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String kw = "%" + keyword + "%";

            ps.setString(1, kw);
            ps.setString(2, kw);
            ps.setString(3, kw);

            if (subject != null && !subject.equals("all")) {
                ps.setString(4, "%" + subject + "%");
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }

        return list;
    }

   
    


    /* -----------------------------
           GET NOTES BY USER
         (My Notes feature)
    ------------------------------*/
    public List<Note> getNotesByUser(String uploader) throws SQLException {

        List<Note> list = new ArrayList<>();

        String sql = "SELECT * FROM notes WHERE uploader = ? ORDER BY note_id DESC";

        try (Connection conn = DB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, uploader);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }

        return list;
    }


    /* -----------------------------
              INSERT NOTE
        (Upload notes feature)
    ------------------------------*/
    public boolean insertNote(Note note) throws SQLException {

        String sql =
            "INSERT INTO notes " +
            "(title, description, file_path, is_paid, price, category, author, uploader) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, note.getTitle());
            ps.setString(2, note.getDescription());
            ps.setString(3, note.getFilePath());

            ps.setBoolean(4, note.isPaid());
            ps.setDouble(5, note.getPrice());

            ps.setString(6, note.getCategory() == null ? "" : note.getCategory());
            ps.setString(7, note.getAuthor() == null ? "" : note.getAuthor());
            ps.setString(8, note.getUploader() == null ? "" : note.getUploader());

            return ps.executeUpdate() > 0;
        }
    }
    public Note getNoteById(int id) throws SQLException {

        String sql = "SELECT * FROM notes WHERE note_id = ?";

        try (Connection conn = DB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapRow(rs);
            }
        }
        return null;
    }

}
