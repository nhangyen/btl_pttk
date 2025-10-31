-- Sample data for testing Library Management System (ĐÃ SỬA LỖI)

-- Insert Users
INSERT INTO tblUser (ID, username, password, name, dob, gender, email, phoneNumber, address) VALUES
(1, 'reader1', 'pass123', 'Nguyen Van A', '1995-05-15', 'Nam', 'nguyenvana@email.com', '0901234567', '123 Nguyen Trai, Ha Noi'),
(2, 'reader2', 'pass123', 'Tran Thi B', '1998-08-20', 'Nu', 'tranthib@email.com', '0912345678', '456 Le Loi, Ha Noi'),
(3, 'reader3', 'pass123', 'Le Van C', '1997-03-10', 'Nam', 'levanc@email.com', '0923456789', '789 Tran Phu, Ha Noi'),
(4, 'librarian1', 'pass123', 'Pham Thi D', '1990-01-25', 'Nu', 'phamthid@email.com', '0934567890', '321 Hai Ba Trung, Ha Noi'),
(5, 'librarian2', 'pass123', 'Hoang Van E', '1988-11-30', 'Nam', 'hoangvane@email.com', '0945678901', '654 Ba Trieu, Ha Noi'),
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
-- SỬA LỖI: publicYear giờ là kiểu YEAR, không phải DATE
INSERT INTO tblBookTitle (ID, title, publisher, publicYear, category, language, pageCount) VALUES
(1, 'Lập trình Java cơ bản', 'NXB Khoa học và Kỹ thuật', 2023, 'Công nghệ thông tin', 'Tiếng Việt', 350),
(2, 'Cấu trúc dữ liệu và giải thuật', 'NXB Đại học Quốc gia', 2022, 'Công nghệ thông tin', 'Tiếng Việt', 420),
(3, 'Clean Code', 'NXB Tre', 2023, 'Công nghệ thông tin', 'Tiếng Anh', 464),
(4, 'Design Patterns', 'NXB Lao động', 2022, 'Công nghệ thông tin', 'Tiếng Anh', 395),
(5, 'Toán cao cấp', 'NXB Giáo dục', 2023, 'Toán học', 'Tiếng Việt', 520),
(6, 'Văn học Việt Nam hiện đại', 'NXB Văn học', 2023, 'Văn học', 'Tiếng Việt', 280),
(7, 'Lịch sử Việt Nam', 'NXB Chính trị quốc gia', 2022, 'Lịch sử', 'Tiếng Việt', 450),
(8, 'Kinh tế học đại cương', 'NXB Thống kê', 2023, 'Kinh tế', 'Tiếng Việt', 380);

-- Insert DocumentCopies (Physical copies)
-- SỬA LỖI: Đổi tên cột BookTitleBookTitleID -> BookTitleID
INSERT INTO tblDocumentCopy (ID, `condition`, status, BookTitleID) VALUES
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
-- SỬA LỖI: Bỏ cột thừa LibrarianLibrarianID và đổi SupplierSupplierID -> SupplierID
INSERT INTO tblImportInvoice (ID, quantity, `date`, LibrarianUserID, SupplierID) VALUES
(1, 50, '2024-01-10', 4, 1),
(2, 30, '2024-02-15', 4, 2),
(3, 40, '2024-03-20', 5, 1);

-- Insert Invoice Details
-- SỬA LỖI: Đổi tên cột DocumentDocumentID -> DocumentCopyID và ImportInvoiceImportInvoiceID -> ImportInvoiceID
INSERT INTO tblInvoiceDetail (ID, quantity, DocumentCopyID, ImportInvoiceID) VALUES
(1, 2, 1, 1),
(2, 2, 2, 1),
(3, 2, 3, 2),
(4, 2, 5, 2),
(5, 2, 7, 3);