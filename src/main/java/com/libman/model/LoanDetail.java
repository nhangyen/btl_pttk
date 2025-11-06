package com.libman.model;

import java.io.Serializable;
import java.util.Date;

public class LoanDetail implements Serializable {
    private static final long serialVersionUID = 1L;
    private int id;
    private Date borrowDate;
    private Date returnDate;
    private Date dueDate;
    private DocumentCopy documentCopy;

    public LoanDetail() {
    }

    public LoanDetail(int id, Date borrowDate, Date returnDate, Date dueDate, DocumentCopy documentCopy) {
        this.id = id;
        this.borrowDate = borrowDate;
        this.returnDate = returnDate;
        this.dueDate = dueDate;
        this.documentCopy = documentCopy;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(Date borrowDate) {
        this.borrowDate = borrowDate;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public DocumentCopy getDocumentCopy() {
        return documentCopy;
    }

    public void setDocumentCopy(DocumentCopy documentCopy) {
        this.documentCopy = documentCopy;
    }
    
    // Compatibility method for backward compatibility
    @Deprecated
    public DocumentCopy getDocument() {
        return documentCopy;
    }
    
    @Deprecated
    public void setDocument(DocumentCopy documentCopy) {
        this.documentCopy = documentCopy;
    }
}
