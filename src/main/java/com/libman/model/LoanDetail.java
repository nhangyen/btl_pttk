package com.libman.model;

import java.io.Serializable;
import java.util.Date;

public class LoanDetail implements Serializable {
    private static final long serialVersionUID = 1L;
    private int id;
    private Date dueDate;
    private DocumentCopy documentCopy;

    public LoanDetail() {
    }

    public LoanDetail(int id, Date dueDate, DocumentCopy documentCopy) {
        this.id = id;
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
