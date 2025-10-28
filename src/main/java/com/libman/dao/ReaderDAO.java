package com.libman.dao;

import com.libman.model.Reader;
import com.libman.model.ReaderCard;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ReaderDAO {

    public Reader getReader(String keyword) {
        Reader reader = null;
        String sql = "SELECT u.ID, u.username, u.password, u.name, u.dob, u.gender, u.email, u.phoneNumber, u.address, " +
                     "r.ReaderCount, rc.cardID, rc.registrationDate, rc.status as cardStatus " +
                     "FROM tblUser u " +
                     "JOIN tblReader r ON u.ID = r.UserID " +
                     "LEFT JOIN tblReaderCard rc ON r.UserID = rc.ReaderUserID " +
                     "WHERE u.username = ? OR u.name LIKE ?";
        try (PreparedStatement ps = DAOFactory.getConnection().prepareStatement(sql)) {
            ps.setString(1, keyword);
            ps.setString(2, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                reader = new Reader();
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
                
                // Tạo ReaderCard nếu có
                if (rs.getObject("cardID") != null) {
                    ReaderCard card = new ReaderCard();
                    card.setCardId(rs.getInt("cardID"));
                    card.setRegistrationDate(rs.getDate("registrationDate"));
                    card.setStatus(rs.getString("cardStatus"));
                    card.setReaderUserId(reader.getId());
                    reader.setReaderCard(card);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reader;
    }
}
