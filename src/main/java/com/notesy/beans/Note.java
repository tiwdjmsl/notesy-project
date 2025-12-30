package com.notesy.beans;



public class Note {
    private int noteId;
    private String title;
    private String author;
    private String category;
    private boolean paid;
    private double price;
    private int likes;
    private int views;
    private int downloads;
    private String filePath;
    private String uploader;

    public int getNoteId() { return noteId; }
    public void setNoteId(int noteId) { this.noteId = noteId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public boolean isPaid() { return paid; }
    public void setPaid(boolean paid) { this.paid = paid; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getLikes() { return likes; }
    public void setLikes(int likes) { this.likes = likes; }

    public int getViews() { return views; }
    public void setViews(int views) { this.views = views; }

    public int getDownloads() { return downloads; }
    public void setDownloads(int downloads) { this.downloads = downloads; }

    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }

    public String getUploader() { return uploader; }
    public void setUploader(String uploader) { this.uploader = uploader; }
	public void setDescription(String string) {
		// TODO Auto-generated method stub
		
	}
	public String getDescription() {
		// TODO Auto-generated method stub
		return null;
	}
}
