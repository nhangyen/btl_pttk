package com.libman.dao;

import com.libman.model.LoanDetail;
import com.libman.model.LoanSlip;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class LoanSlipDAO {

    public boolean saveLoan(LoanSlip loanSlip) {
        // Schema mới:
        // tblLoanSlip (ID, status, ReaderUserID, LibrarianUserID, ReturnSlipID)
        // tblLoanDetail (ID, borrowdate, returndate, DocumentCopyID, LoanSlipID, ReturnSlipID, PenaltySlipID)
        
        String sqlLoanSlip = "INSERT INTO tblLoanSlip(status, ReaderUserID, LibrarianUserID) VALUES(?, ?, ?)";
        String sqlLoanDetail = "INSERT INTO tblLoanDetail(borrowdate, returndate, DocumentCopyID, LoanSlipID) VALUES(?, ?, ?, ?)";
        Connection connection = null;
        try {
            connection = DAOFactory.getConnection();
            connection.setAutoCommit(false);

            int loanSlipId;
            try (PreparedStatement psLoanSlip = connection.prepareStatement(sqlLoanSlip, Statement.RETURN_GENERATED_KEYS)) {
                psLoanSlip.setString(1, "Active");
                psLoanSlip.setInt(2, loanSlip.getReader().getId());
                psLoanSlip.setInt(3, loanSlip.getLibrarian().getId());
                psLoanSlip.executeUpdate();

                try (ResultSet generatedKeys = psLoanSlip.getGeneratedKeys()) {
                    if (!generatedKeys.next()) {
                        connection.rollback();
                        return false;
                    }
                    loanSlipId = generatedKeys.getInt(1);
                }
            }

            DocumentDAO documentDAO = new DocumentDAO();
            for (LoanDetail detail : loanSlip.getLoanDetails()) {
                boolean locked = documentDAO.markAsBorrowed(connection, detail.getDocumentCopy());
                if (!locked) {
                    connection.rollback();
                    return false;
                }

                try (PreparedStatement psLoanDetail = connection.prepareStatement(sqlLoanDetail)) {
                    psLoanDetail.setDate(1, new java.sql.Date(loanSlip.getBorrowDate().getTime()));
                    psLoanDetail.setDate(2, new java.sql.Date(detail.getDueDate().getTime()));
                    psLoanDetail.setInt(3, detail.getDocumentCopy().getId());
                    psLoanDetail.setInt(4, loanSlipId);
                    psLoanDetail.executeUpdate();
                }
            }

            connection.commit();
            return true;
        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            if (connection != null) {
                try {
                    connection.setAutoCommit(true);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return false;
    }
}
