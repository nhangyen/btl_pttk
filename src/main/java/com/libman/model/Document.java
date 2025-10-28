package com.libman.model;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;

public class Document implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int id;
    private int condition;
    private String status;
    private int bookTitleId;
    
    // Thông tin từ BookTitle (để hiển thị)
    private BookTitle bookTitle;

    public Document() {
    }

    public Document(int id, int condition, String status, int bookTitleId) {
        this.id = id;
        this.condition = condition;
        this.status = status;
        this.bookTitleId = bookTitleId;
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

    public int getBookTitleId() {
        return bookTitleId;
    }

    public void setBookTitleId(int bookTitleId) {
        this.bookTitleId = bookTitleId;
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
    
    public String getPublisher() {
        return bookTitle != null ? bookTitle.getPublisher() : "";
    }
    
    public String getCategory() {
        return bookTitle != null ? bookTitle.getCategory() : "";
    }
    
    public String getLanguage() {
        return bookTitle != null ? bookTitle.getLanguage() : "";
    }
    
    // Compatibility method - trả về publisher vì schema không có author
    public String getAuthor() {
        return getPublisher();
    }
    
    public int getPageCount() {
        return bookTitle != null ? bookTitle.getPageCount() : 0;
    }
    
    public Date getPublicYear() {
        return bookTitle != null ? bookTitle.getPublicYear() : null;
    }
    
    // Compatibility method cho publicationYear
    public int getPublicationYear() {
        Date year = getPublicYear();
        if (year != null) {
            Calendar cal = Calendar.getInstance();
            cal.setTime(year);
            return cal.get(Calendar.YEAR);
        }
        return 0;
    }
    
    public String getDescription() {
        return bookTitle != null ? bookTitle.getDescription() : "";
    }
    
    // Quantity - trong schema không có quantity cho document
    // Mỗi document là 1 bản vật lý, nên quantity luôn là 1 nếu Available
    public int getQuantity() {
        return "Available".equalsIgnoreCase(status) ? 1 : 0;
    }
}
