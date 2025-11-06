package com.libman.dao;

import com.libman.model.BookTitle;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookTitleDAO {

    public List<BookTitle> searchBookTitles(String keyword) {
        List<BookTitle> results = new ArrayList<>();
        String searchKey = keyword == null ? "" : keyword.trim();
        String sql = "SELECT ID, title, author, publisher, publicYear, category, language, pageCount FROM tblBookTitle "
                   + "WHERE title LIKE ? OR category LIKE ? OR publisher LIKE ? OR author LIKE ? ORDER BY title";

        try (PreparedStatement ps = DAOFactory.getConnection().prepareStatement(sql)) {
            String pattern = "%" + searchKey + "%";
            ps.setString(1, pattern);
            ps.setString(2, pattern);
            ps.setString(3, pattern);
            ps.setString(4, pattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BookTitle bt = new BookTitle();
                bt.setId(rs.getInt("ID"));
                bt.setTitle(rs.getString("title"));
                bt.setAuthor(rs.getString("author"));
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

                results.add(bt);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return results;
    }

    public BookTitle getBookTitleById(int id) {
        BookTitle bookTitle = null;
        String sql = "SELECT ID, title, author, publisher, publicYear, category, language, pageCount FROM tblBookTitle WHERE ID = ?";

        try (PreparedStatement ps = DAOFactory.getConnection().prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                bookTitle = new BookTitle();
                bookTitle.setId(rs.getInt("ID"));
                bookTitle.setTitle(rs.getString("title"));
                bookTitle.setAuthor(rs.getString("author"));
                bookTitle.setPublisher(rs.getString("publisher"));
                bookTitle.setCategory(rs.getString("category"));
                bookTitle.setLanguage(rs.getString("language"));
                bookTitle.setPageCount(rs.getInt("pageCount"));

                try {
                    String yearString = rs.getString("publicYear");
                    if (yearString != null && !yearString.isEmpty()) {
                        bookTitle.setPublicationYear(Integer.parseInt(yearString));
                    }
                } catch (SQLException | NumberFormatException ignored) {
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookTitle;
    }
}
