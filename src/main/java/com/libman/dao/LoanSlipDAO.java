package com.libman.dao;

import com.libman.model.LoanDetail;
import com.libman.model.LoanSlip;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class LoanSlipDAO {

    public boolean saveLoan(LoanSlip loanSlip) {
        // Schema mới:
        // tblLoanSlip (ID, status, ReaderUserID, LibrarianUserID, ReturnSlipID)
        // tblLoanDetail (ID, quantity, borrowdate, returndate, DocumentCopyID, LoanSlipID, ReturnSlipID, PenaltySlipID)
        
        String sqlLoanSlip = "INSERT INTO tblLoanSlip(status, ReaderUserID, LibrarianUserID) VALUES(?, ?, ?)";
        String sqlLoanDetail = "INSERT INTO tblLoanDetail(quantity, borrowdate, returndate, DocumentCopyID, LoanSlipID) VALUES(?, ?, ?, ?, ?)";
        boolean success = false;
        try {
            DAOFactory.getConnection().setAutoCommit(false);
            try (PreparedStatement psLoanSlip = DAOFactory.getConnection().prepareStatement(sqlLoanSlip, Statement.RETURN_GENERATED_KEYS)) {
                psLoanSlip.setString(1, "Active");
                psLoanSlip.setInt(2, loanSlip.getReader().getId());
                psLoanSlip.setInt(3, loanSlip.getLibrarian().getId());
                psLoanSlip.executeUpdate();

                ResultSet generatedKeys = psLoanSlip.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int loanSlipId = generatedKeys.getInt(1);
                    
                    // Insert từng LoanDetail với LoanSlipID
                    for (LoanDetail detail : loanSlip.getLoanDetails()) {
                        try (PreparedStatement psLoanDetail = DAOFactory.getConnection().prepareStatement(sqlLoanDetail)) {
                            psLoanDetail.setInt(1, 1); // quantity = 1
                            psLoanDetail.setDate(2, new java.sql.Date(loanSlip.getLoanDate().getTime())); // borrowdate
                            psLoanDetail.setDate(3, new java.sql.Date(detail.getDueDate().getTime())); // returndate (due date)
                            psLoanDetail.setInt(4, detail.getDocument().getId()); // DocumentCopyID
                            psLoanDetail.setInt(5, loanSlipId); // LoanSlipID
                            psLoanDetail.executeUpdate();
                        }
                    }
                }
            }
            DAOFactory.getConnection().commit();
            success = true;
        } catch (SQLException e) {
            try {
                DAOFactory.getConnection().rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                DAOFactory.getConnection().setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return success;
    }
}
