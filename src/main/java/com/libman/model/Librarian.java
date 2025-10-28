package com.libman.model;

import java.util.Date;

public class Librarian extends User {
    private static final long serialVersionUID = 1L;
    
    private String role;

    public Librarian() {
        super();
    }

    public Librarian(int id, String username, String password, String name, Date dob, 
                     String gender, String email, String phoneNumber, String address, String role) {
        super(id, username, password, name, dob, gender, email, phoneNumber, address);
        this.role = role;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
