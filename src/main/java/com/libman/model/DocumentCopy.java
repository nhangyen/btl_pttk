package com.libman.model;

import java.io.Serializable;

public class DocumentCopy implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int id;
    private int condition;
    private String status;
    private BookTitle bookTitle;

    public DocumentCopy() {
    }

    public DocumentCopy(int id, int condition, String status, BookTitle bookTitle) {
        this.id = id;
        this.condition = condition;
        this.status = status;
        this.bookTitle = bookTitle;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCondition() {
        return condition;
    }

    public void setCondition(int condition) {
        this.condition = condition;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BookTitle getBookTitle() {
        return bookTitle;
    }

    public void setBookTitle(BookTitle bookTitle) {
        this.bookTitle = bookTitle;
    }
    
    // Helper methods để dễ dàng truy cập thông tin từ BookTitle
    public String getTitle() {
        return bookTitle != null ? bookTitle.getTitle() : "";
    }
    
    public String getAuthor() {
        return bookTitle != null ? bookTitle.getAuthor() : "";
    }
    
    public String getPublisher() {
        return bookTitle != null ? bookTitle.getPublisher() : "";
    }
    
    public int getPublicationYear() {
        return bookTitle != null ? bookTitle.getPublicationYear() : 0;
    }
    
    public String getCategory() {
        return bookTitle != null ? bookTitle.getCategory() : "";
    }
    
    public String getLanguage() {
        return bookTitle != null ? bookTitle.getLanguage() : "";
    }
    
    public int getPageCount() {
        return bookTitle != null ? bookTitle.getPageCount() : 0;
    }
    
    public String getDescription() {
        return bookTitle != null ? bookTitle.getDescription() : "";
    }
}
