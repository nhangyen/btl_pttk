package com.libman.control;

import com.libman.dao.DocumentDAO;
import com.libman.model.Document;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/searchDocument")
public class DocumentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DocumentDAO documentDAO;

    public void init() {
        documentDAO = new DocumentDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "search";
        }

        switch (action) {
            case "detail":
                showDocumentDetail(request, response);
                break;
            default:
                searchDocument(request, response);
                break;
        }
    }

    private void searchDocument(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Document> documents = documentDAO.getDocuments(keyword);
        request.setAttribute("documents", documents);
        request.getRequestDispatcher("view/SearchDocumentView.jsp").forward(request, response);
    }

    private void showDocumentDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Document document = documentDAO.getDocumentById(id);
        request.setAttribute("document", document);
        request.getRequestDispatcher("view/DocumentDetailView.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
