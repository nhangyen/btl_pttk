package com.libman.dao;

import com.libman.model.BookTitle;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookTitleDAO {

    public List<BookTitle> searchBookTitles(String keyword) {
        List<BookTitle> results = new ArrayList<>();
        String searchKey = keyword == null ? "" : keyword.trim();
        String sql = "SELECT ID, title, publisher, publicYear, category, language, pageCount FROM tblBookTitle "
                   + "WHERE title LIKE ? OR category LIKE ? OR publisher LIKE ? ORDER BY title";

        try (PreparedStatement ps = DAOFactory.getConnection().prepareStatement(sql)) {
            String pattern = "%" + searchKey + "%";
            ps.setString(1, pattern);
            ps.setString(2, pattern);
            ps.setString(3, pattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                results.add(mapToBookTitle(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return results;
    }

    public BookTitle getBookTitleById(int id) {
        BookTitle bookTitle = null;
        String sql = "SELECT ID, title, publisher, publicYear, category, language, pageCount FROM tblBookTitle WHERE ID = ?";

        try (PreparedStatement ps = DAOFactory.getConnection().prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                bookTitle = mapToBookTitle(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookTitle;
    }

    private BookTitle mapToBookTitle(ResultSet rs) throws SQLException {
        BookTitle bt = new BookTitle();
        bt.setId(rs.getInt("ID"));
        bt.setTitle(rs.getString("title"));
        bt.setPublisher(rs.getString("publisher"));
        bt.setCategory(rs.getString("category"));
        bt.setLanguage(rs.getString("language"));
        bt.setPageCount(rs.getInt("pageCount"));

        // YEAR có thể trả về dạng chuỗi hoặc số, xử lý an toàn
        try {
            String yearString = rs.getString("publicYear");
            if (yearString != null && !yearString.isEmpty()) {
                bt.setPublicationYear(Integer.parseInt(yearString));
            }
        } catch (SQLException | NumberFormatException ignored) {
            // Bỏ qua nếu cột không tồn tại hoặc không parse được
        }

        // Một số cơ sở dữ liệu có thể có thêm cột author/description, cố gắng đọc nếu có
        if (hasColumn(rs, "author")) {
            bt.setAuthor(rs.getString("author"));
        }
        if (hasColumn(rs, "description")) {
            bt.setDescription(rs.getString("description"));
        }
        return bt;
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
