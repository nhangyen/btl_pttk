-- Database setup for Library Management System
-- Drop database if exists and create new one
DROP DATABASE IF EXISTS libman_db;
CREATE DATABASE libman_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE libman_db;

-- Create tables
CREATE TABLE tblBookTitle (
    ID int(10) NOT NULL AUTO_INCREMENT, 
    title varchar(255) NOT NULL, 
    publisher varchar(255) NOT NULL, 
    publicYear date NOT NULL, 
    category varchar(255) NOT NULL, 
    language varchar(255) NOT NULL, 
    pageCount int(10) NOT NULL, 
    PRIMARY KEY (ID)
);

CREATE TABLE tblDocument (
    ID int(10) NOT NULL AUTO_INCREMENT, 
    `condition` int(10) NOT NULL, 
    status varchar(255) NOT NULL, 
    BookTitleBookTitleID int(10) NOT NULL, 
    PRIMARY KEY (ID)
);

CREATE TABLE tblImportInvoice (
    ID int(10) NOT NULL AUTO_INCREMENT, 
    quantity int(10) NOT NULL, 
    `date` date NOT NULL, 
    LibrarianLibrarianID int(10) NOT NULL, 
    SupplierSupplierID int(10) NOT NULL, 
    LibrarianUserID int(10) NOT NULL, 
    PRIMARY KEY (ID)
);

CREATE TABLE tblInvoiceDetail (
    ID int(10) NOT NULL AUTO_INCREMENT, 
    quantity int(10) NOT NULL, 
    DocumentDocumentID int(10) NOT NULL, 
    ImportInvoiceImportInvoiceID int(10) NOT NULL, 
    PRIMARY KEY (ID)
);

CREATE TABLE tblLibrarian (
    role varchar(255) NOT NULL, 
    UserID int(10) NOT NULL, 
    PRIMARY KEY (UserID)
);

CREATE TABLE tblLoanDetail (
    ID int(10) NOT NULL AUTO_INCREMENT, 
    quantity int(10) NOT NULL, 
    borrowdate date NOT NULL, 
    returndate date NOT NULL, 
    DocumentDocumentID int(10) NOT NULL, 
    ReturnSlipReturnSlipID int(10) DEFAULT NULL, 
    PenaltySlipPenaltySlipID int(10) DEFAULT NULL, 
    PRIMARY KEY (ID)
);

CREATE TABLE tblLoanSlip (
    ID int(10) NOT NULL AUTO_INCREMENT, 
    status varchar(255) NOT NULL, 
    ReaderID int(10) NOT NULL, 
    LibrarianID int(10) NOT NULL, 
    LoanDetailLoanDetailID int(10) DEFAULT NULL, 
    ReturnSlipReturnSlipID int(10) DEFAULT NULL, 
    LibrarianUserID int(10) NOT NULL, 
    ReaderUserID int(10) NOT NULL, 
    PRIMARY KEY (ID)
);

CREATE TABLE tblManager (
    role varchar(255) NOT NULL, 
    UserID int(10) NOT NULL, 
    PRIMARY KEY (UserID)
);

CREATE TABLE tblPenaltySlip (
    ID int(10) NOT NULL AUTO_INCREMENT, 
    amount float NOT NULL, 
    note varchar(255) NOT NULL, 
    PRIMARY KEY (ID)
);

CREATE TABLE tblReader (
    ReaderCount int(10) DEFAULT NULL, 
    UserID int(10) NOT NULL, 
    PRIMARY KEY (UserID)
);

CREATE TABLE tblReaderCard (
    registrationDate date NOT NULL, 
    cardID int(10) NOT NULL AUTO_INCREMENT, 
    status varchar(255) NOT NULL, 
    ReaderUserID int(10) NOT NULL, 
    PRIMARY KEY (cardID)
);

CREATE TABLE tblReturnSlip (
    ID int(10) NOT NULL AUTO_INCREMENT, 
    returndate date NOT NULL, 
    LibrarianLibrarianID int(10) NOT NULL, 
    ReaderID int(10) NOT NULL, 
    LibrarianUserID int(10) NOT NULL, 
    ReaderUserID int(10) NOT NULL, 
    PRIMARY KEY (ID)
);

CREATE TABLE tblSupplier (
    ID int(10) NOT NULL AUTO_INCREMENT, 
    name varchar(255) NOT NULL, 
    address varchar(255) NOT NULL, 
    description varchar(255) NOT NULL, 
    PRIMARY KEY (ID)
);

CREATE TABLE tblUser (
    ID int(10) NOT NULL AUTO_INCREMENT, 
    username varchar(10) NOT NULL, 
    password varchar(255) NOT NULL, 
    name varchar(255) NOT NULL, 
    dob date NOT NULL, 
    gender varchar(10) NOT NULL, 
    email varchar(255) NOT NULL, 
    phoneNumber varchar(15) NOT NULL, 
    address varchar(255) NOT NULL, 
    PRIMARY KEY (ID)
);

-- Add Foreign Key Constraints
ALTER TABLE tblLoanSlip ADD CONSTRAINT FKtblLoanSli516430 FOREIGN KEY (ReaderUserID) REFERENCES tblReader (UserID);
ALTER TABLE tblLoanSlip ADD CONSTRAINT FKtblLoanSli458738 FOREIGN KEY (LibrarianUserID) REFERENCES tblLibrarian (UserID);
ALTER TABLE tblManager ADD CONSTRAINT FKtblManager354359 FOREIGN KEY (UserID) REFERENCES tblUser (ID);
ALTER TABLE tblLibrarian ADD CONSTRAINT FKtblLibrari351005 FOREIGN KEY (UserID) REFERENCES tblUser (ID);
ALTER TABLE tblReader ADD CONSTRAINT FKtblReader499437 FOREIGN KEY (UserID) REFERENCES tblUser (ID);
ALTER TABLE tblImportInvoice ADD CONSTRAINT FKtblImportI579771 FOREIGN KEY (LibrarianUserID) REFERENCES tblLibrarian (UserID);
ALTER TABLE tblReturnSlip ADD CONSTRAINT FKtblReturnS662240 FOREIGN KEY (LibrarianUserID) REFERENCES tblLibrarian (UserID);
ALTER TABLE tblDocument ADD CONSTRAINT FKtblDocumen3653 FOREIGN KEY (BookTitleBookTitleID) REFERENCES tblBookTitle (ID);
ALTER TABLE tblInvoiceDetail ADD CONSTRAINT FKtblInvoice144741 FOREIGN KEY (DocumentDocumentID) REFERENCES tblDocument (ID);
ALTER TABLE tblLoanDetail ADD CONSTRAINT FKtblLoanDet804415 FOREIGN KEY (DocumentDocumentID) REFERENCES tblDocument (ID);
-- ALTER TABLE tblLoanSlip ADD CONSTRAINT FKtblLoanSli727430 FOREIGN KEY (LoanDetailLoanDetailID) REFERENCES tblLoanDetail (ID);
-- ALTER TABLE tblLoanDetail ADD CONSTRAINT FKtblLoanDet867115 FOREIGN KEY (ReturnSlipReturnSlipID) REFERENCES tblReturnSlip (ID);
ALTER TABLE tblReturnSlip ADD CONSTRAINT FKtblReturnS334181 FOREIGN KEY (ReaderUserID) REFERENCES tblReader (UserID);
ALTER TABLE tblInvoiceDetail ADD CONSTRAINT FKtblInvoice805365 FOREIGN KEY (ImportInvoiceImportInvoiceID) REFERENCES tblImportInvoice (ID);
-- ALTER TABLE tblLoanDetail ADD CONSTRAINT FKtblLoanDet920427 FOREIGN KEY (PenaltySlipPenaltySlipID) REFERENCES tblPenaltySlip (ID);
ALTER TABLE tblImportInvoice ADD CONSTRAINT FKtblImportI554985 FOREIGN KEY (SupplierSupplierID) REFERENCES tblSupplier (ID);
ALTER TABLE tblReaderCard ADD CONSTRAINT FKtblReaderC626031 FOREIGN KEY (ReaderUserID) REFERENCES tblReader (UserID);

-- Insert Sample Data

-- Insert Users
INSERT INTO tblUser (ID, username, password, name, dob, gender, email, phoneNumber, address) VALUES
(1, 'reader1', 'pass123', 'Nguyen Van A', '1995-05-15', 'Nam', 'nguyenvana@email.com', '0901234567', '123 Nguyen Trai, Ha Noi'),
(2, 'reader2', 'pass123', 'Tran Thi B', '1998-08-20', 'Nu', 'tranthib@email.com', '0912345678', '456 Le Loi, Ha Noi'),
(3, 'reader3', 'pass123', 'Le Van C', '1997-03-10', 'Nam', 'levanc@email.com', '0923456789', '789 Tran Phu, Ha Noi'),
(4, 'lib1', 'pass123', 'Pham Thi D', '1990-01-25', 'Nu', 'phamthid@email.com', '0934567890', '321 Hai Ba Trung, Ha Noi'),
(5, 'lib2', 'pass123', 'Hoang Van E', '1988-11-30', 'Nam', 'hoangvane@email.com', '0945678901', '654 Ba Trieu, Ha Noi'),
(6, 'manager1', 'pass123', 'Vu Thi F', '1985-07-18', 'Nu', 'vuthif@email.com', '0956789012', '987 Ly Thuong Kiet, Ha Noi');

-- Insert Readers
INSERT INTO tblReader (UserID, ReaderCount) VALUES
(1, 5),
(2, 3),
(3, 8);

-- Insert Librarians
INSERT INTO tblLibrarian (UserID, role) VALUES
(4, 'Thu Thu'),
(5, 'Phu Trach Muon Tra');

-- Insert Manager
INSERT INTO tblManager (UserID, role) VALUES
(6, 'Quan Ly');

-- Insert Reader Cards
INSERT INTO tblReaderCard (cardID, registrationDate, status, ReaderUserID) VALUES
(1, '2024-01-15', 'Active', 1),
(2, '2024-02-20', 'Active', 2),
(3, '2024-03-10', 'Active', 3);

-- Insert Book Titles
INSERT INTO tblBookTitle (ID, title, publisher, publicYear, category, language, pageCount) VALUES
(1, 'Lập trình Java cơ bản', 'NXB Khoa học và Kỹ thuật', '2023-01-01', 'Công nghệ thông tin', 'Tiếng Việt', 350),
(2, 'Cấu trúc dữ liệu và giải thuật', 'NXB Đại học Quốc gia', '2022-06-15', 'Công nghệ thông tin', 'Tiếng Việt', 420),
(3, 'Clean Code', 'NXB Tre', '2023-03-20', 'Công nghệ thông tin', 'Tiếng Anh', 464),
(4, 'Design Patterns', 'NXB Lao động', '2022-09-10', 'Công nghệ thông tin', 'Tiếng Anh', 395),
(5, 'Toán cao cấp', 'NXB Giáo dục', '2023-08-25', 'Toán học', 'Tiếng Việt', 520),
(6, 'Văn học Việt Nam hiện đại', 'NXB Văn học', '2023-05-12', 'Văn học', 'Tiếng Việt', 280),
(7, 'Lịch sử Việt Nam', 'NXB Chính trị quốc gia', '2022-11-30', 'Lịch sử', 'Tiếng Việt', 450),
(8, 'Kinh tế học đại cương', 'NXB Thống kê', '2023-02-18', 'Kinh tế', 'Tiếng Việt', 380);

-- Insert Documents (Physical copies)
INSERT INTO tblDocument (ID, `condition`, status, BookTitleBookTitleID) VALUES
(1, 100, 'Available', 1),
(2, 100, 'Available', 1),
(3, 95, 'Available', 2),
(4, 100, 'Available', 2),
(5, 100, 'Available', 3),
(6, 90, 'Available', 4),
(7, 100, 'Available', 5),
(8, 95, 'Available', 5),
(9, 100, 'Available', 6),
(10, 100, 'Available', 7),
(11, 85, 'Available', 7),
(12, 100, 'Available', 8);

-- Insert Suppliers
INSERT INTO tblSupplier (ID, name, address, description) VALUES
(1, 'Công ty Sách Phương Nam', '123 Nguyen Dinh Chieu, TP.HCM', 'Nhà cung cấp sách chính'),
(2, 'Công ty Fahasa', '456 Nguyen Trai, Ha Noi', 'Nhà phân phối sách lớn'),
(3, 'Nhà sách Trí Tuệ', '789 Le Lai, Da Nang', 'Nhà sách chuyên ngành');

-- Insert Import Invoices
INSERT INTO tblImportInvoice (ID, quantity, `date`, LibrarianLibrarianID, SupplierSupplierID, LibrarianUserID) VALUES
(1, 50, '2024-01-10', 4, 1, 4),
(2, 30, '2024-02-15', 4, 2, 4),
(3, 40, '2024-03-20', 5, 1, 5);

-- Insert Invoice Details
INSERT INTO tblInvoiceDetail (ID, quantity, DocumentDocumentID, ImportInvoiceImportInvoiceID) VALUES
(1, 2, 1, 1),
(2, 2, 2, 1),
(3, 2, 3, 2),
(4, 2, 5, 2),
(5, 2, 7, 3);
