package com.notesy.service;

import com.notesy.model.NoteDAO;
import com.notesy.beans.Note;
import java.util.*;

public class NoteService {

    private final NoteDAO dao = new NoteDAO();

    public List<Note> getExploreNotes() {
        try {
            return dao.getAllNotes();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    public List<Note> getUserNotes(String username) {
        try {
            return dao.getNotesByUser(username);
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }
    public List<Note> searchExploreNotes(String keyword, String subject) {
        try {
            return dao.searchNotes(
                keyword == null ? "" : keyword.trim(),
                subject == null ? "all" : subject.trim()
            );
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }
    public boolean uploadNote(Note note) {
        try {
            return dao.insertNote(note);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
