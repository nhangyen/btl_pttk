package com.libman.control;

import com.libman.dao.DocumentDAO;
import com.libman.dao.LoanSlipDAO;
import com.libman.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/lending")
public class LoanSlipServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private LoanSlipDAO loanSlipDAO;

    public void init() {
        loanSlipDAO = new LoanSlipDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if ("addDocument".equals(action)) {
            addDocumentToLoan(request, response, session);
        } else if ("saveLoan".equals(action)) {
            saveLoan(request, response, session);
        }
    }

    private void addDocumentToLoan(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
        int docId = Integer.parseInt(request.getParameter("docId"));
        String dueDateStr = request.getParameter("dueDate");

        Document doc = new DocumentDAO().getDocumentById(docId);
        Date dueDate = null;
        try {
            dueDate = new SimpleDateFormat("yyyy-MM-dd").parse(dueDateStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        LoanDetail loanDetail = new LoanDetail();
        loanDetail.setDocument(doc);
        loanDetail.setDueDate(dueDate);

        @SuppressWarnings("unchecked")
        List<LoanDetail> currentLoanDetails = (List<LoanDetail>) session.getAttribute("currentLoanDetails");
        if (currentLoanDetails == null) {
            currentLoanDetails = new ArrayList<>();
        }
        currentLoanDetails.add(loanDetail);
        session.setAttribute("currentLoanDetails", currentLoanDetails);

        response.sendRedirect("view/ManageLendingDocument.jsp");
    }

    private void saveLoan(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException, ServletException {
        Reader reader = (Reader) session.getAttribute("selectedReader");
        Librarian librarian = (Librarian) session.getAttribute("loggedInLibrarian"); // Assuming librarian is in session
        @SuppressWarnings("unchecked")
        List<LoanDetail> loanDetails = (List<LoanDetail>) session.getAttribute("currentLoanDetails");

        if (reader != null && librarian != null && loanDetails != null && !loanDetails.isEmpty()) {
            LoanSlip loanSlip = new LoanSlip();
            loanSlip.setLoanDate(new Date());
            loanSlip.setReader(reader);
            loanSlip.setLibrarian(librarian);
            loanSlip.setLoanDetails(loanDetails);

            boolean isSaved = loanSlipDAO.saveLoan(loanSlip);

            if (isSaved) {
                session.removeAttribute("selectedReader");
                session.removeAttribute("currentLoanDetails");
                request.setAttribute("message", "Phiếu mượn đã được lưu thành công!");
                request.getRequestDispatcher("view/PrintLoanSlip.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Lỗi khi lưu phiếu mượn.");
                request.getRequestDispatcher("view/ManageLendingDocument.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Thông tin mượn không đầy đủ.");
            request.getRequestDispatcher("view/ManageLendingDocument.jsp").forward(request, response);
        }
    }
}
