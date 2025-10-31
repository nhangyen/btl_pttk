package com.libman.dao;

import com.libman.model.DocumentCopy;
import com.libman.model.BookTitle;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class DocumentDAO {

    public List<DocumentCopy> getDocuments(String keyword) {
        List<DocumentCopy> documents = new ArrayList<>();
        String sql = "SELECT d.ID, d.condition, d.status, d.BookTitleID, " +
                     "bt.ID as bt_id, bt.title, bt.publisher, bt.publicYear, bt.category, bt.language, bt.pageCount " +
                     "FROM tblDocumentCopy d " +
                     "LEFT JOIN tblBookTitle bt ON d.BookTitleID = bt.ID " +
                     "WHERE bt.title LIKE ? OR bt.category LIKE ?";
        try (PreparedStatement ps = DAOFactory.getConnection().prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                DocumentCopy doc = new DocumentCopy();
                doc.setId(rs.getInt("ID"));
                doc.setCondition(rs.getInt("condition"));
                doc.setStatus(rs.getString("status"));
                
                // Tạo BookTitle object
                BookTitle bt = new BookTitle();
                bt.setId(rs.getInt("bt_id"));
                bt.setTitle(rs.getString("title"));
                bt.setPublisher(rs.getString("publisher"));
                
                // Chuyển đổi Date sang int year
                java.sql.Date publicYearDate = rs.getDate("publicYear");
                if (publicYearDate != null) {
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(publicYearDate);
                    bt.setPublicationYear(cal.get(Calendar.YEAR));
                }
                
                bt.setCategory(rs.getString("category"));
                bt.setLanguage(rs.getString("language"));
                bt.setPageCount(rs.getInt("pageCount"));
                
                doc.setBookTitle(bt);
                documents.add(doc);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return documents;
    }

    public DocumentCopy getDocumentById(int id) {
        DocumentCopy doc = null;
        String sql = "SELECT d.ID, d.condition, d.status, d.BookTitleID, " +
                     "bt.ID as bt_id, bt.title, bt.publisher, bt.publicYear, bt.category, bt.language, bt.pageCount " +
                     "FROM tblDocumentCopy d " +
                     "LEFT JOIN tblBookTitle bt ON d.BookTitleID = bt.ID " +
                     "WHERE d.ID = ?";
        try (PreparedStatement ps = DAOFactory.getConnection().prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                doc = new DocumentCopy();
                doc.setId(rs.getInt("ID"));
                doc.setCondition(rs.getInt("condition"));
                doc.setStatus(rs.getString("status"));
                
                // Tạo BookTitle object
                BookTitle bt = new BookTitle();
                bt.setId(rs.getInt("bt_id"));
                bt.setTitle(rs.getString("title"));
                bt.setPublisher(rs.getString("publisher"));
                
                // Chuyển đổi Date sang int year
                java.sql.Date publicYearDate = rs.getDate("publicYear");
                if (publicYearDate != null) {
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(publicYearDate);
                    bt.setPublicationYear(cal.get(Calendar.YEAR));
                }
                
                bt.setCategory(rs.getString("category"));
                bt.setLanguage(rs.getString("language"));
                bt.setPageCount(rs.getInt("pageCount"));
                
                doc.setBookTitle(bt);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return doc;
    }
}
