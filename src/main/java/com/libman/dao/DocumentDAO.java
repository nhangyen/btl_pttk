package com.libman.dao;

import com.libman.model.DocumentCopy;
import com.libman.model.BookTitle;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DocumentDAO {

    public List<DocumentCopy> getDocuments(String keyword) {
        List<DocumentCopy> documents = new ArrayList<>();
        String sql = "SELECT d.ID, d.condition, d.status, d.BookTitleID, " +
                     "bt.ID AS bt_id, bt.title, bt.publisher, bt.publicYear, bt.category, bt.language, bt.pageCount " +
                     "FROM tblDocumentCopy d " +
                     "LEFT JOIN tblBookTitle bt ON d.BookTitleID = bt.ID " +
                     "WHERE bt.title LIKE ? OR bt.category LIKE ?";
        try (PreparedStatement ps = DAOFactory.getConnection().prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                documents.add(mapToDocumentCopy(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return documents;
    }

    public DocumentCopy getDocumentById(int id) {
        DocumentCopy doc = null;
        String sql = "SELECT d.ID, d.condition, d.status, d.BookTitleID, " +
                     "bt.ID AS bt_id, bt.title, bt.publisher, bt.publicYear, bt.category, bt.language, bt.pageCount " +
                     "FROM tblDocumentCopy d " +
                     "LEFT JOIN tblBookTitle bt ON d.BookTitleID = bt.ID " +
                     "WHERE d.ID = ?";
        try (PreparedStatement ps = DAOFactory.getConnection().prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                doc = mapToDocumentCopy(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return doc;
    }

    public List<DocumentCopy> getDocumentCopiesByBookTitle(int bookTitleId) {
        List<DocumentCopy> copies = new ArrayList<>();
        String sql = "SELECT d.ID, d.condition, d.status, d.BookTitleID, "
                   + "bt.ID AS bt_id, bt.title, bt.publisher, bt.publicYear, bt.category, bt.language, bt.pageCount "
                   + "FROM tblDocumentCopy d "
                   + "LEFT JOIN tblBookTitle bt ON d.BookTitleID = bt.ID "
                   + "WHERE d.BookTitleID = ? ORDER BY d.ID";

        try (PreparedStatement ps = DAOFactory.getConnection().prepareStatement(sql)) {
            ps.setInt(1, bookTitleId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                copies.add(mapToDocumentCopy(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return copies;
    }

    private DocumentCopy mapToDocumentCopy(ResultSet rs) throws SQLException {
        DocumentCopy doc = new DocumentCopy();
        doc.setId(rs.getInt("ID"));
        doc.setCondition(rs.getInt("condition"));
        doc.setStatus(rs.getString("status"));

        BookTitle bt = new BookTitle();
        try {
            bt.setId(rs.getInt("bt_id"));
        } catch (SQLException ignored) {
            bt.setId(rs.getInt("BookTitleID"));
        }
        bt.setTitle(rs.getString("title"));
        bt.setPublisher(rs.getString("publisher"));
        bt.setCategory(rs.getString("category"));
        bt.setLanguage(rs.getString("language"));
        bt.setPageCount(rs.getInt("pageCount"));

        try {
            String yearString = rs.getString("publicYear");
            if (yearString != null && !yearString.isEmpty()) {
                bt.setPublicationYear(Integer.parseInt(yearString));
            }
        } catch (SQLException | NumberFormatException ignored) {
            // Bỏ qua nếu không lấy được năm xuất bản
        }

        if (hasColumn(rs, "author")) {
            bt.setAuthor(rs.getString("author"));
        }
        if (hasColumn(rs, "description")) {
            bt.setDescription(rs.getString("description"));
        }

        doc.setBookTitle(bt);
        return doc;
    }

    private boolean hasColumn(ResultSet rs, String column) throws SQLException {
        ResultSetMetaData metaData = rs.getMetaData();
        for (int i = 1; i <= metaData.getColumnCount(); i++) {
            if (column.equalsIgnoreCase(metaData.getColumnLabel(i))) {
                return true;
            }
        }
        return false;
    }
}
