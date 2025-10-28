package com.libman.model;

import java.util.Date;

public class Reader extends User {
    private static final long serialVersionUID = 1L;
    
    private Integer readerCount;
    private ReaderCard readerCard;

    public Reader() {
        super();
    }

    public Reader(int id, String username, String password, String name, Date dob, String gender, 
                  String email, String phoneNumber, String address, Integer readerCount) {
        super(id, username, password, name, dob, gender, email, phoneNumber, address);
        this.readerCount = readerCount;
    }

    public Integer getReaderCount() {
        return readerCount;
    }

    public void setReaderCount(Integer readerCount) {
        this.readerCount = readerCount;
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
