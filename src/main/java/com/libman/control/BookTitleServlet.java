package com.libman.control;

import com.libman.dao.BookTitleDAO;
import com.libman.model.BookTitle;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/searchBookTitle")
public class BookTitleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookTitleDAO bookTitleDAO;

    public void init() {
        bookTitleDAO = new BookTitleDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        searchBookTitle(request, response);
    }

    private void searchBookTitle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        if (keyword == null) {
            keyword = "";
        }

        List<BookTitle> bookTitles = bookTitleDAO.searchBookTitles(keyword);
        request.setAttribute("bookTitles", bookTitles);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("view/SearchDocumentView.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
