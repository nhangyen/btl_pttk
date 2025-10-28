package com.libman.model;

import java.io.Serializable;
import java.util.Date;

public class LoanDetail implements Serializable {
    private static final long serialVersionUID = 1L;
    private int id;
    private Date dueDate;
    private Document document;

    public LoanDetail() {
    }

    public LoanDetail(int id, Date dueDate, Document document) {
        this.id = id;
        this.dueDate = dueDate;
        this.document = document;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public Document getDocument() {
        return document;
    }

    public void setDocument(Document document) {
        this.document = document;
    }
}
