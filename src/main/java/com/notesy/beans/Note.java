package com.notesy.beans;



public class Note {

    private int noteId;        // note_id
    private int userId;        // FK -> users.user_id
    private String title;
    private String description;
    private String category;
    private int likes;
    private double price;
    private String picture;
    private String filePath;

    // --- Getters & Setters ---

    public int getNoteId() { return noteId; }
    public void setNoteId(int noteId) { this.noteId = noteId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public int getLikes() { return likes; }
    public void setLikes(int likes) { this.likes = likes; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getPicture() { return picture; }
    public void setPicture(String picture) { this.picture = picture; }

    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }
    
    private String username;
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

}
