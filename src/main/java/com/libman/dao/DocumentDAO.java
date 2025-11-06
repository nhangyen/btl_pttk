package com.libman.dao;

import com.libman.model.DocumentCopy;
import com.libman.model.BookTitle;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
                }

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
                     "bt.ID AS bt_id, bt.title, bt.publisher, bt.publicYear, bt.category, bt.language, bt.pageCount " +
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
                }

                doc.setBookTitle(bt);
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
                }

                doc.setBookTitle(bt);
                copies.add(doc);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return copies;
    }

    public boolean markAsBorrowed(Connection connection, DocumentCopy documentCopy) {
        if (connection == null || documentCopy == null) {
            return false;
        }

        String sql = "UPDATE tblDocumentCopy SET status = 'Borrowed' WHERE ID = ? AND status = 'Available'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, documentCopy.getId());
            int updated = ps.executeUpdate();
            if (updated > 0) {
                documentCopy.setStatus("Borrowed");
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean markAsAvailable(Connection connection, DocumentCopy documentCopy) {
        if (connection == null || documentCopy == null) {
            return false;
        }

        String sql = "UPDATE tblDocumentCopy SET status = 'Available' WHERE ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, documentCopy.getId());
            int updated = ps.executeUpdate();
            if (updated > 0) {
                documentCopy.setStatus("Available");
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
