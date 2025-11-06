package com.libman.model;

import java.io.Serializable;
import java.util.Date;

public class ReaderCard implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int cardId;
    private Date registrationDate;
    private String status;
    private int readerUserId;
    private String path;

    public ReaderCard() {
    }

    public ReaderCard(int cardId, Date registrationDate, String status, int readerUserId, String path) {
        this.cardId = cardId;
        this.registrationDate = registrationDate;
        this.status = status;
        this.readerUserId = readerUserId;
        this.path = path;
    }

    public ReaderCard(int cardId, Date registrationDate, String status, int readerUserId) {
        this(cardId, registrationDate, status, readerUserId, null);
    }

    // Getters and Setters
    public int getCardId() {
        return cardId;
    }

    public void setCardId(int cardId) {
        this.cardId = cardId;
    }

    public Date getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(Date registrationDate) {
        this.registrationDate = registrationDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getReaderUserId() {
        return readerUserId;
    }

    public void setReaderUserId(int readerUserId) {
        this.readerUserId = readerUserId;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }
}
