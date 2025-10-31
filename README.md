# Hệ thống Quản lý Thư viện (Library Management System)

## Cài đặt và chạy ứng dụng


mvn jetty:run


### 1. Cài đặt cơ sở dữ liệu

Chạy file SQL để tạo database và dữ liệu mẫu:

```bash
mysql -u root -p < database/setup_database.sql
```

Hoặc sử dụng MySQL Workbench để import file `database/setup_database.sql`

**Database được tạo:** `libman_db`

### 2. Cấu hình kết nối database

Kiểm tra và cập nhật thông tin kết nối trong file:
`src/main/java/com/libman/dao/DAOFactory.java`

```java
con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/libman_db?serverTimezone=UTC", 
    "root",      // username
    "mysql1612"  // password - thay đổi theo MySQL của bạn
);
```

### 3. Build project

```bash
mvn clean package
```

### 4. Deploy lên Tomcat

- Copy file `target/LibMan.war` vào thư mục `webapps` của Tomcat
- Khởi động Tomcat
- Truy cập: `http://localhost:8080/LibMan/`

### 5. Hoặc chạy với Jetty

```bash
mvn jetty:run
```

Sau đó truy cập: `http://localhost:8080/`

## Tài khoản demo

### Bạn đọc (Readers):
- Username: `reader1` / Password: `pass123` (Nguyen Van A)
- Username: `reader2` / Password: `pass123` (Tran Thi B)
- Username: `reader3` / Password: `pass123` (Le Van C)

### Thủ thư (Librarians):
- Username: `lib1` / Password: `pass123` (Pham Thi D)
- Username: `lib2` / Password: `pass123` (Hoang Van E)

### Quản lý (Manager):
- Username: `manager1` / Password: `pass123` (Vu Thi F)

## Cấu trúc dữ liệu

### Sách trong thư viện (BookTitles):
1. Lập trình Java cơ bản
2. Cấu trúc dữ liệu và giải thuật
3. Clean Code
4. Design Patterns
5. Toán cao cấp
6. Văn học Việt Nam hiện đại
7. Lịch sử Việt Nam
8. Kinh tế học đại cương

### Tài liệu (Documents):
- Mỗi BookTitle có 1-2 bản vật lý (tổng 12 documents)
- Tất cả đang ở trạng thái "Available"

## Chức năng đã triển khai

### 1. Tìm kiếm tài liệu (Reader)
- URL: `/searchDocument`
- Tìm kiếm theo tên sách hoặc thể loại
- Xem chi tiết tài liệu

### 2. Quản lý mượn tài liệu (Librarian)
- URL: `/lending`
- Quét thẻ bạn đọc
- Quét tài liệu
- Tạo phiếu mượn
- In phiếu mượn

## Cấu trúc project

```
LibMan/
├── src/main/java/com/libman/
│   ├── model/          # Lớp thực thể
│   │   ├── User.java
│   │   ├── Reader.java
│   │   ├── Librarian.java
│   │   ├── BookTitle.java
│   │   ├── ReaderCard.java
│   │   ├── Document.java
│   │   ├── LoanSlip.java
│   │   └── LoanDetail.java
│   ├── dao/            # Data Access Object
│   │   ├── DAOFactory.java
│   │   ├── DocumentDAO.java
│   │   ├── ReaderDAO.java
│   │   └── LoanSlipDAO.java
│   └── control/        # Servlets
│       ├── DocumentServlet.java
│       ├── ReaderServlet.java
│       └── LoanSlipServlet.java
├── src/main/webapp/
│   ├── view/           # JSP views
│   │   ├── SearchDocumentView.jsp
│   │   ├── DocumentDetailView.jsp
│   │   ├── ManageLendingDocument.jsp
│   │   ├── ScanReaderCard.jsp
│   │   ├── ScanDocument.jsp
│   │   └── PrintLoanSlip.jsp
│   ├── ReaderHome.jsp
│   ├── LibrarianHome.jsp
│   └── index.jsp
├── database/
│   ├── btl_pttk.sql       # DDL schema
│   ├── sample_data.sql     # Dữ liệu mẫu
│   └── setup_database.sql  # Full setup (DDL + data)
└── pom.xml

```

## Công nghệ sử dụng

- **Backend:** Java 8+, Jakarta EE 9.1, Servlet API 5.0
- **Frontend:** JSP, JSTL 2.0
- **Database:** MySQL 8.0+
- **Build Tool:** Maven 3.6+
- **Server:** Apache Tomcat 10+ hoặc Jetty 9+

## Lưu ý

1. Đảm bảo MySQL đang chạy trên port 3306
2. Tạo database trước khi chạy ứng dụng
3. Cập nhật username/password MySQL trong DAOFactory.java
4. Sử dụng Tomcat 10+ cho Jakarta EE 9.1
5. Encoding: UTF-8 cho tiếng Việt

## Troubleshooting

### Lỗi kết nối database
- Kiểm tra MySQL đang chạy
- Kiểm tra username/password trong DAOFactory.java
- Kiểm tra database `libman_db` đã được tạo

### Lỗi ClassNotFoundException: TagLibraryValidator
- Đảm bảo đã thêm dependency `jakarta.servlet.jsp-api` vào pom.xml
- Chạy `mvn clean install` để download dependencies

### Lỗi 404 Not Found
- Kiểm tra context path: `/LibMan/`
- Kiểm tra servlet mapping trong các Servlet class
