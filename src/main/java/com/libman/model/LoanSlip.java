package com.libman.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class LoanSlip implements Serializable {
    private static final long serialVersionUID = 1L;
    private int id;
    private Date loanDate;
    private Reader reader;
    private Librarian librarian;
    private List<LoanDetail> loanDetails;

    public LoanSlip() {
    }

    public LoanSlip(int id, Date loanDate, Reader reader, Librarian librarian, List<LoanDetail> loanDetails) {
        this.id = id;
        this.loanDate = loanDate;
        this.reader = reader;
        this.librarian = librarian;
        this.loanDetails = loanDetails;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getLoanDate() {
        return loanDate;
    }

    public void setLoanDate(Date loanDate) {
        this.loanDate = loanDate;
    }

    public Reader getReader() {
        return reader;
    }

    public void setReader(Reader reader) {
        this.reader = reader;
    }

    public Librarian getLibrarian() {
        return librarian;
    }

    public void setLibrarian(Librarian librarian) {
        this.librarian = librarian;
    }

    public List<LoanDetail> getLoanDetails() {
        return loanDetails;
    }

    public void setLoanDetails(List<LoanDetail> loanDetails) {
        this.loanDetails = loanDetails;
    }
}
