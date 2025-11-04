package com.libman.dao;

import com.libman.model.User;
import com.libman.model.Librarian;
import com.libman.model.Reader;
import com.libman.model.ReaderCard;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    public User login(String username, String password) {
        User user = null;
        
        // Kiểm tra librarian trước
        String librarianSql = "SELECT u.ID, u.username, u.password, u.name, u.dob, u.gender, u.email, u.phoneNumber, u.address, l.role " +
                              "FROM tblUser u " +
                              "JOIN tblLibrarian l ON u.ID = l.UserID " +
                              "WHERE u.username = ? AND u.password = ?";
        
        try (PreparedStatement ps = DAOFactory.getConnection().prepareStatement(librarianSql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Librarian librarian = new Librarian();
                librarian.setId(rs.getInt("ID"));
                librarian.setUsername(rs.getString("username"));
                librarian.setPassword(rs.getString("password"));
                librarian.setName(rs.getString("name"));
                librarian.setDob(rs.getDate("dob"));
                librarian.setGender(rs.getString("gender"));
                librarian.setEmail(rs.getString("email"));
                librarian.setPhoneNumber(rs.getString("phoneNumber"));
                librarian.setAddress(rs.getString("address"));
                librarian.setRole(rs.getString("role"));
                return librarian;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        // Nếu không phải librarian, kiểm tra reader
    String readerSql = "SELECT u.ID, u.username, u.password, u.name, u.dob, u.gender, u.email, u.phoneNumber, u.address, r.ReaderCount, " +
               "rc.cardID, rc.registrationDate, rc.status AS cardStatus " +
               "FROM tblUser u " +
               "JOIN tblReader r ON u.ID = r.UserID " +
               "LEFT JOIN tblReaderCard rc ON r.UserID = rc.ReaderUserID " +
               "WHERE u.username = ? AND u.password = ?";
        
        try (PreparedStatement ps = DAOFactory.getConnection().prepareStatement(readerSql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Reader reader = new Reader();
                reader.setId(rs.getInt("ID"));
                reader.setUsername(rs.getString("username"));
                reader.setPassword(rs.getString("password"));
                reader.setName(rs.getString("name"));
                reader.setDob(rs.getDate("dob"));
                reader.setGender(rs.getString("gender"));
                reader.setEmail(rs.getString("email"));
                reader.setPhoneNumber(rs.getString("phoneNumber"));
                reader.setAddress(rs.getString("address"));
                reader.setReaderCount(rs.getObject("ReaderCount") != null ? rs.getInt("ReaderCount") : null);

                if (rs.getObject("cardID") != null) {
                    ReaderCard card = new ReaderCard();
                    card.setCardId(rs.getInt("cardID"));
                    card.setRegistrationDate(rs.getDate("registrationDate"));
                    card.setStatus(rs.getString("cardStatus"));
                    card.setReaderUserId(reader.getId());
                    reader.setReaderCard(card);
                }
                return reader;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return user;
    }
}
