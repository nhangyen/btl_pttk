-- ========= TẠO BẢNG =========

-- Bảng cơ sở
CREATE TABLE tblUser (
    ID INT NOT NULL AUTO_INCREMENT,
    username varchar(50) NOT NULL,
    password varchar(255) NOT NULL,
    name varchar(255) NOT NULL,
    dob date NOT NULL,
    gender varchar(5) NOT NULL,
    email varchar(255) NOT NULL,
    phoneNumber varchar(15) NOT NULL,
    address varchar(255) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE tblSupplier (
    ID INT NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    address varchar(255) NOT NULL,
    description varchar(255) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE tblBookTitle (
    ID INT NOT NULL AUTO_INCREMENT,
    title varchar(255) NOT NULL,
    publisher varchar(255) NOT NULL,
    publicYear YEAR NOT NULL,
    category varchar(255) NOT NULL,
    language varchar(255) NOT NULL,
    pageCount INT NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE tblPenaltySlip (
    ID INT NOT NULL AUTO_INCREMENT,
    amount float NOT NULL,
    note varchar(255) NOT NULL,
    PRIMARY KEY (ID)
);

-- Bảng kế thừa từ tblUser
CREATE TABLE tblLibrarian (
    role varchar(255) NOT NULL,
    UserID INT NOT NULL,
    PRIMARY KEY (UserID)
);

CREATE TABLE tblManager (
    role varchar(255) NOT NULL,
    UserID INT NOT NULL,
    PRIMARY KEY (UserID)
);

CREATE TABLE tblReader (
    ReaderCount INT,
    UserID INT NOT NULL,
    PRIMARY KEY (UserID)
);

-- Bảng nghiệp vụ
CREATE TABLE tblReaderCard (
    registrationDate date NOT NULL,
    cardID INT NOT NULL AUTO_INCREMENT,
    status varchar(255) NOT NULL,
    ReaderUserID INT NOT NULL,
    PRIMARY KEY (cardID)
);

-- ĐỔI TÊN BẢNG: tblDocument -> tblDocumentCopy
CREATE TABLE tblDocumentCopy (
    ID INT NOT NULL AUTO_INCREMENT,
    `condition` INT NOT NULL,
    status varchar(255) NOT NULL,
    BookTitleID INT NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE tblReturnSlip (
    ID INT NOT NULL AUTO_INCREMENT,
    returndate date NOT NULL,
    LibrarianUserID INT NOT NULL,
    ReaderUserID INT NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE tblImportInvoice (
    ID INT NOT NULL AUTO_INCREMENT,
    quantity INT NOT NULL,
    `date` date NOT NULL,
    LibrarianUserID INT NOT NULL,
    SupplierID INT NOT NULL,
    PRIMARY KEY (ID)
);

-- Bảng chi tiết (Nhiều)
CREATE TABLE tblInvoiceDetail (
    ID INT NOT NULL AUTO_INCREMENT,
    quantity INT NOT NULL,
    DocumentCopyID INT NOT NULL, -- Đổi tên cột
    ImportInvoiceID INT NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE tblLoanSlip (
    ID INT NOT NULL AUTO_INCREMENT,
    status varchar(255) NOT NULL,
    ReaderUserID INT NOT NULL,
    LibrarianUserID INT NOT NULL,
    ReturnSlipID INT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE tblLoanDetail (
    ID INT NOT NULL AUTO_INCREMENT,
    quantity INT NOT NULL,
    borrowdate date NOT NULL,
    returndate date NOT NULL,
    DocumentCopyID INT NOT NULL, -- Đổi tên cột
    LoanSlipID INT NOT NULL,
    ReturnSlipID INT NULL,
    PenaltySlipID INT NULL,
    PRIMARY KEY (ID)
);

-- ========= TẠO KHÓA NGOẠI =========

-- Kế thừa User
ALTER TABLE tblManager ADD CONSTRAINT FK_Manager_User FOREIGN KEY (UserID) REFERENCES tblUser (ID);
ALTER TABLE tblLibrarian ADD CONSTRAINT FK_Librarian_User FOREIGN KEY (UserID) REFERENCES tblUser (ID);
ALTER TABLE tblReader ADD CONSTRAINT FK_Reader_User FOREIGN KEY (UserID) REFERENCES tblUser (ID);

-- Liên kết đến Librarian
ALTER TABLE tblImportInvoice ADD CONSTRAINT FK_ImportInvoice_Librarian FOREIGN KEY (LibrarianUserID) REFERENCES tblLibrarian (UserID);
ALTER TABLE tblReturnSlip ADD CONSTRAINT FK_ReturnSlip_Librarian FOREIGN KEY (LibrarianUserID) REFERENCES tblLibrarian (UserID);
ALTER TABLE tblLoanSlip ADD CONSTRAINT FK_LoanSlip_Librarian FOREIGN KEY (LibrarianUserID) REFERENCES tblLibrarian (UserID);

-- Liên kết đến Reader
ALTER TABLE tblReaderCard ADD CONSTRAINT FK_ReaderCard_Reader FOREIGN KEY (ReaderUserID) REFERENCES tblReader (UserID);
ALTER TABLE tblReturnSlip ADD CONSTRAINT FK_ReturnSlip_Reader FOREIGN KEY (ReaderUserID) REFERENCES tblReader (UserID);
ALTER TABLE tblLoanSlip ADD CONSTRAINT FK_LoanSlip_Reader FOREIGN KEY (ReaderUserID) REFERENCES tblReader (UserID);

-- Liên kết đến Book/DocumentCopy (ĐÃ CẬP NHẬT)
ALTER TABLE tblDocumentCopy ADD CONSTRAINT FK_DocumentCopy_BookTitle FOREIGN KEY (BookTitleID) REFERENCES tblBookTitle (ID);
ALTER TABLE tblInvoiceDetail ADD CONSTRAINT FK_InvoiceDetail_DocumentCopy FOREIGN KEY (DocumentCopyID) REFERENCES tblDocumentCopy (ID);
LOS
ALTER TABLE tblLoanDetail ADD CONSTRAINT FK_LoanDetail_DocumentCopy FOREIGN KEY (DocumentCopyID) REFERENCES tblDocumentCopy (ID);

-- Liên kết nghiệp vụ Nhập hàng
ALTER TABLE tblImportInvoice ADD CONSTRAINT FK_ImportInvoice_Supplier FOREIGN KEY (SupplierID) REFERENCES tblSupplier (ID);
ALTER TABLE tblInvoiceDetail ADD CONSTRAINT FK_InvoiceDetail_ImportInvoice FOREIGN KEY (ImportInvoiceID) REFERENCES tblImportInvoice (ID);

-- Liên kết nghiệp vụ Mượn/Trả/Phạt
ALTER TABLE tblLoanDetail ADD CONSTRAINT FK_LoanDetail_LoanSlip FOREIGN KEY (LoanSlipID) REFERENCES tblLoanSlip (ID);
ALTER TABLE tblLoanDetail ADD CONSTRAINT FK_LoanDetail_ReturnSlip FOREIGN KEY (ReturnSlipID) REFERENCES tblReturnSlip (ID);
ALTER TABLE tblLoanDetail ADD CONSTRAINT FK_LoanDetail_PenaltySlip FOREIGN KEY (PenaltySlipID) REFERENCES tblPenaltySlip (ID);
ALTER TABLE tblLoanSlip ADD CONSTRAINT FK_LoanSlip_ReturnSlip FOREIGN KEY (ReturnSlipID) REFERENCES tblReturnSlip (ID);