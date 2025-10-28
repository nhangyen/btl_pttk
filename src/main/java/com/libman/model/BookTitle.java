package com.libman.model;

import java.io.Serializable;
import java.util.Date;

public class BookTitle implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int id;
    private String title;
    private String publisher;
    private Date publicYear;
    private String category;
    private String language;
    private int pageCount;
    private String description;

    public BookTitle() {
    }

    public BookTitle(int id, String title, String publisher, Date publicYear, String category, String language, int pageCount) {
        this.id = id;
        this.title = title;
        this.publisher = publisher;
        this.publicYear = publicYear;
        this.category = category;
        this.language = language;
        this.pageCount = pageCount;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public Date getPublicYear() {
        return publicYear;
    }

    public void setPublicYear(Date publicYear) {
        this.publicYear = publicYear;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public int getPageCount() {
        return pageCount;
    }

    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
