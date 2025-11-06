package com.libman.control;

import com.libman.dao.BookTitleDAO;
import com.libman.dao.DocumentCopyDAO;
import com.libman.model.BookTitle;
import com.libman.model.DocumentCopy;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet("/documentDetail")
public class DocumentCopyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DocumentCopyDAO documentDAO;
    private BookTitleDAO bookTitleDAO;

    public void init() {
        documentDAO = new DocumentCopyDAO();
        bookTitleDAO = new BookTitleDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        showDocumentDetail(request, response);
    }

    private void showDocumentDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String keyword = request.getParameter("keyword");
        if (keyword == null) {
            keyword = "";
        }

        BookTitle bookTitle = bookTitleDAO.getBookTitleById(id);
        if (bookTitle == null) {
            String encodedKeyword = URLEncoder.encode(keyword, StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/searchBookTitle?keyword=" + encodedKeyword);
            return;
        }

        List<BookTitle> bookTitles = bookTitleDAO.searchBookTitles(keyword);
        List<DocumentCopy> documentCopies = documentDAO.getDocumentCopiesByBookTitle(id);

        request.setAttribute("bookTitle", bookTitle);
        request.setAttribute("bookTitles", bookTitles);
        request.setAttribute("documentCopies", documentCopies);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("view/SearchDocumentView.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
