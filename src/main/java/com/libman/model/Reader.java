package com.libman.model;

import java.util.Date;

public class Reader extends User {
    private static final long serialVersionUID = 1L;
    
    private String note;
    private ReaderCard readerCard;

    public Reader() {
        super();
    }

    public Reader(int id, String username, String password, String name, Date dob, String gender, 
                  String email, String phoneNumber, String address, String note) {
        super(id, username, password, name, dob, gender, email, phoneNumber, address);
        this.note = note;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public ReaderCard getReaderCard() {
        return readerCard;
    }

    public void setReaderCard(ReaderCard readerCard) {
        this.readerCard = readerCard;
    }
    
    // Helper method để truy cập phone từ User
    public String getPhone() {
        return getPhoneNumber();
    }
}
