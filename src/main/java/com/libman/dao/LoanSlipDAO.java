package com.libman.dao;

import com.libman.model.LoanDetail;
import com.libman.model.LoanSlip;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class LoanSlipDAO {

    public boolean saveLoan(LoanSlip loanSlip) {
        String sqlLoanSlip = "INSERT INTO tblloanslip(loanDate, readerId, librarianId) VALUES(?, ?, ?)";
        String sqlLoanDetail = "INSERT INTO tblloandetail(dueDate, documentId, loanSlipId) VALUES(?, ?, ?)";
        boolean success = false;
        try {
            DAOFactory.getConnection().setAutoCommit(false);
            try (PreparedStatement psLoanSlip = DAOFactory.getConnection().prepareStatement(sqlLoanSlip, Statement.RETURN_GENERATED_KEYS)) {
                psLoanSlip.setDate(1, new java.sql.Date(loanSlip.getLoanDate().getTime()));
                psLoanSlip.setInt(2, loanSlip.getReader().getId());
                psLoanSlip.setInt(3, loanSlip.getLibrarian().getId());
                psLoanSlip.executeUpdate();

                ResultSet generatedKeys = psLoanSlip.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int loanSlipId = generatedKeys.getInt(1);
                    for (LoanDetail detail : loanSlip.getLoanDetails()) {
                        try (PreparedStatement psLoanDetail = DAOFactory.getConnection().prepareStatement(sqlLoanDetail)) {
                            psLoanDetail.setDate(1, new java.sql.Date(detail.getDueDate().getTime()));
                            psLoanDetail.setInt(2, detail.getDocument().getId());
                            psLoanDetail.setInt(3, loanSlipId);
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
