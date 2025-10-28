package com.libman.control;

import com.libman.dao.ReaderDAO;
import com.libman.model.Reader;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/scanReader")
public class ReaderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReaderDAO readerDAO;

    public void init() {
        readerDAO = new ReaderDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        Reader reader = readerDAO.getReader(keyword);
        request.setAttribute("reader", reader);
        request.getRequestDispatcher("view/ScanReaderCard.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
