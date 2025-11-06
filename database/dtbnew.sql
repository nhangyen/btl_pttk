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
    author varchar(255) NOT NULL,
    publisher varchar(255) NOT NULL,
    publicYear YEAR NOT NULL, -- Giữ nguyên kiểu YEAR vì đúng logic
    category varchar(255) NOT NULL,
    language varchar(255) NOT NULL,
    pageCount INT NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE tblPenaltySlip (
    ID INT NOT NULL AUTO_INCREMENT,
    -- Giữ nguyên kiểu DECIMAL vì 'float' trong ERD là sai cho tiền tệ
    amount DECIMAL(15, 0) NOT NULL, 
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
    -- SỬA: Đổi 'borrowLimit' thành 'note' để khớp với ERD mới
    note varchar(255) NULL, 
    UserID INT NOT NULL,
    PRIMARY KEY (UserID)
);

-- Bảng nghiệp vụ
CREATE TABLE tblReaderCard (
    registrationDate date NOT NULL,
    cardID INT NOT NULL AUTO_INCREMENT,
    status varchar(255) NOT NULL,
    path varchar(255) NULL,
    ReaderUserID INT NOT NULL,
    PRIMARY KEY (cardID)
);

CREATE TABLE tblDocumentCopy (
    ID INT NOT NULL AUTO_INCREMENT,
    `condition` INT NOT NULL,
    status varchar(255) NOT NULL,
    -- Giữ 'BookTitleID' (thay vì 'BookTitleBookTitleID' trong ERD) vì nó sạch hơn và khớp với các bản sửa lỗi trước đó
    BookTitleID INT NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE tblReturnSlip (
    ID INT NOT NULL AUTO_INCREMENT,
    returndate date NOT NULL,
    LibrarianUserID INT NOT NULL,
    ReaderUserID INT NOT NULL,
    -- GHI CHÚ: ERD mới và SQL cũ của bạn đều không có 'penaltyAmount'. 
    -- Nếu bạn muốn thêm nó (như trong sơ đồ lớp), hãy bỏ ghi chú dòng sau:
    -- penaltyAmount DECIMAL(15, 0) NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE tblImportInvoice (
    ID INT NOT NULL AUTO_INCREMENT,
    -- SỬA: Đã bỏ cột 'quantity' để khớp với ERD mới và logic phi chuẩn hóa
    `date` date NOT NULL,
    LibrarianUserID INT NOT NULL,
    SupplierID INT NOT NULL,
    PRIMARY KEY (ID)
);

-- Bảng chi tiết (Nhiều)
CREATE TABLE tblInvoiceDetail (
    ID INT NOT NULL AUTO_INCREMENT,
    -- SỬA: Đã bỏ 'quantity' và thêm 'price' để khớp với ERD mới
    price DECIMAL(15, 0) NOT NULL,
    DocumentCopyID INT NOT NULL, 
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
    -- SỬA: Đã bỏ cột 'quantity' để khớp với ERD mới
    borrowdate date NOT NULL,
    returndate date NOT NULL,
    DocumentCopyID INT NOT NULL, 
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

-- Liên kết đến Book/DocumentCopy
ALTER TABLE tblDocumentCopy ADD CONSTRAINT FK_DocumentCopy_BookTitle FOREIGN KEY (BookTitleID) REFERENCES tblBookTitle (ID);
ALTER TABLE tblInvoiceDetail ADD CONSTRAINT FK_InvoiceDetail_DocumentCopy FOREIGN KEY (DocumentCopyID) REFERENCES tblDocumentCopy (ID);
ALTER TABLE tblLoanDetail ADD CONSTRAINT FK_LoanDetail_DocumentCopy FOREIGN KEY (DocumentCopyID) REFERENCES tblDocumentCopy (ID);

-- Liên kết nghiệp vụ Nhập hàng
ALTER TABLE tblImportInvoice ADD CONSTRAINT FK_ImportInvoice_Supplier FOREIGN KEY (SupplierID) REFERENCES tblSupplier (ID);
ALTER TABLE tblInvoiceDetail ADD CONSTRAINT FK_InvoiceDetail_ImportInvoice FOREIGN KEY (ImportInvoiceID) REFERENCES tblImportInvoice (ID);

-- Liên kết nghiệp vụ Mượn/Trả/Phạt
ALTER TABLE tblLoanDetail ADD CONSTRAINT FK_LoanDetail_LoanSlip FOREIGN KEY (LoanSlipID) REFERENCES tblLoanSlip (ID);
ALTER TABLE tblLoanDetail ADD CONSTRAINT FK_LoanDetail_ReturnSlip FOREIGN KEY (ReturnSlipID) REFERENCES tblReturnSlip (ID);
ALTER TABLE tblLoanDetail ADD CONSTRAINT FK_LoanDetail_PenaltySlip FOREIGN KEY (PenaltySlipID) REFERENCES tblPenaltySlip (ID);
ALTER TABLE tblLoanSlip ADD CONSTRAINT FK_LoanSlip_ReturnSlip FOREIGN KEY (ReturnSlipID) REFERENCES tblReturnSlip (ID);