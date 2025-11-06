<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Tìm kiếm đầu sách</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            overflow: hidden;
        }

        .container {
            height: 100vh;
            display: flex;
            flex-direction: column;
            padding: 15px 20px;
            max-width: none;
        }

        .header-section {
            flex-shrink: 0;
            margin-bottom: 12px;
        }

        .search-section {
            flex-shrink: 0;
            margin-bottom: 12px;
        }

        .search-section form {
            margin: 0;
            display: flex;
            gap: 10px;
        }

        .search-section input[type="text"] {
            flex: 1;
            margin: 0;
            padding: 8px 12px;
        }

        .search-section button {
            margin: 0;
            padding: 8px 20px;
        }

        .content-wrapper {
            flex: 1;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            min-height: 0;
            overflow: hidden;
        }

        .left-panel, .right-panel {
            display: flex;
            flex-direction: column;
            min-height: 0;
            overflow: hidden;
        }

        .panel-header {
            flex-shrink: 0;
            margin-bottom: 8px;
        }

        .panel-header h3 {
            margin: 0;
            font-size: 1.1em;
        }

        .scrollable-content {
            flex: 1;
            overflow-y: auto;
            overflow-x: hidden;
            padding-right: 5px;
        }

        .scrollable-content::-webkit-scrollbar {
            width: 6px;
        }

        .scrollable-content::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }

        .scrollable-content::-webkit-scrollbar-thumb {
            background: #667eea;
            border-radius: 10px;
        }

        .scrollable-content::-webkit-scrollbar-thumb:hover {
            background: #764ba2;
        }

        table {
            margin: 0;
            font-size: 0.9em;
        }

        table th, table td {
            padding: 8px 10px;
        }

        .detail-section {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 10px;
        }

        .detail-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            font-size: 0.9em;
        }

        .detail-grid p {
            margin: 5px 0;
        }

        .document-copy-list {
            margin-top: 10px;
        }

        .document-copy-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 12px;
            background: #ffffff;
            border: 1px solid #e3e6ef;
            border-radius: 6px;
            margin-bottom: 8px;
            cursor: pointer;
            transition: all 0.2s ease;
            font-size: 0.9em;
        }

        .document-copy-item:hover {
            border-color: rgba(102, 126, 234, 0.5);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.15);
        }

        .document-copy-details {
            display: none;
            background: #fdfdff;
            border: 1px solid #e3e6ef;
            border-radius: 0 0 6px 6px;
            border-top: none;
            padding: 12px;
            margin-top: -8px;
            margin-bottom: 8px;
            font-size: 0.85em;
        }

        .document-copy-details.active {
            display: block;
        }

        .document-copy-details p {
            margin: 5px 0;
        }

        .condition-bar {
            height: 5px;
            width: 100%;
            background: #e1e5f2;
            border-radius: 3px;
            overflow: hidden;
            margin: 6px 0;
        }

        .condition-fill {
            height: 100%;
            transition: width 0.3s ease;
        }

        .condition-excellent { background: #38c172; }
        .condition-good { background: #51d88a; }
        .condition-fair { background: #ffed4a; }
        .condition-poor { background: #f6993f; }
        .condition-damaged { background: #e3342f; }

        .empty-state {
            padding: 12px;
            background: #fff5f5;
            border-radius: 6px;
            color: #c53030;
            font-size: 0.9em;
        }

        .footer-section {
            flex-shrink: 0;
            margin-top: 12px;
        }

        .nav-links {
            margin: 0;
        }

        .alert {
            padding: 10px;
            margin: 10px 0;
            font-size: 0.9em;
        }

        h1 {
            font-size: 1.5em;
            margin: 0;
        }

        h2 {
            font-size: 1.2em;
            margin: 0 0 10px 0;
        }

        h3 {
            font-size: 1.1em;
            margin: 0 0 8px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header-section" style="display: flex; justify-content: space-between; align-items: center;">
            <h1>📚 Tìm kiếm đầu sách</h1>
            <div>
                <c:if test="${not empty sessionScope.user}">
                    <span style="margin-right: 15px; font-size: 0.9em;">Xin chào, <strong>${sessionScope.user.name}</strong></span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn-secondary" style="padding: 6px 12px; font-size: 0.9em;">Đăng xuất</a>
                </c:if>
            </div>
        </div>

        <div class="search-section">
            <form action="${pageContext.request.contextPath}/searchDocument" method="get">
                <input type="hidden" name="action" value="search">
                <input type="text" name="keyword" placeholder="Nhập tên sách, thể loại hoặc nhà xuất bản..." value="${keyword}">
                <button type="submit">🔍 Tìm kiếm</button>
            </form>
        </div>

        <div class="content-wrapper">
            <div class="left-panel">
                <div class="panel-header">
                    <h3>📋 Danh sách đầu sách</h3>
                </div>
                <div class="scrollable-content">
                    <c:if test="${not empty bookTitles}">
                        <table>
                <thead>
                    <tr>
                        <th>Mã đầu sách</th>
                        <th>Tên sách</th>
                        <th>Nhà xuất bản</th>
                        <th>Năm xuất bản</th>
                        <th>Thể loại</th>
                        <th>Ngôn ngữ</th>
                        <th>Số trang</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="bt" items="${bookTitles}">
                        <tr>
                            <td><strong>#${bt.id}</strong></td>
                            <td>${bt.title}</td>
                            <td>${empty bt.publisher ? 'Chưa cập nhật' : bt.publisher}</td>
                            <td>${bt.publicationYear > 0 ? bt.publicationYear : 'Chưa cập nhật'}</td>
                            <td><span class="status status-available">${empty bt.category ? 'N/A' : bt.category}</span></td>
                            <td>${empty bt.language ? 'N/A' : bt.language}</td>
                            <td>${bt.pageCount > 0 ? bt.pageCount : 'N/A'}</td>
                            <td>
                                <c:url var="detailUrl" value="/searchDocument">
                                    <c:param name="action" value="detail" />
                                    <c:param name="id" value="${bt.id}" />
                                    <c:param name="keyword" value="${keyword}" />
                                </c:url>
                                <a href="${pageContext.request.contextPath}${detailUrl}" class="btn">
                                    Xem chi tiết
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
                    </c:if>
                    <c:if test="${empty bookTitles}">
                        <div class="alert alert-error">
                            <p>Không tìm thấy đầu sách nào phù hợp. Vui lòng thử từ khóa khác.</p>
                        </div>
                    </c:if>
                </div>
            </div>

            <div class="right-panel">
                <div class="panel-header">
                    <h3>📖 Chi tiết đầu sách</h3>
                </div>
                <div class="scrollable-content">
                    <c:if test="${not empty bookTitle}">
                        <div class="detail-section">
                            <h2>� Thông tin cơ bản</h2>
                            <div class="detail-grid">
                    <div>
                        <p><strong>Mã đầu sách:</strong> #${bookTitle.id}</p>
                        <p><strong>Tên sách:</strong> ${bookTitle.title}</p>
                        <p><strong>Tác giả:</strong> ${empty bookTitle.author ? 'Chưa cập nhật' : bookTitle.author}</p>
                        <p><strong>Nhà xuất bản:</strong> ${empty bookTitle.publisher ? 'Chưa cập nhật' : bookTitle.publisher}</p>
                    </div>
                    <div>
                        <p><strong>Năm xuất bản:</strong> ${bookTitle.publicationYear > 0 ? bookTitle.publicationYear : 'Chưa cập nhật'}</p>
                        <p><strong>Thể loại:</strong> ${empty bookTitle.category ? 'Chưa cập nhật' : bookTitle.category}</p>
                        <p><strong>Ngôn ngữ:</strong> ${empty bookTitle.language ? 'Chưa cập nhật' : bookTitle.language}</p>
                        <p><strong>Số trang:</strong> ${bookTitle.pageCount > 0 ? bookTitle.pageCount : 'Chưa cập nhật'}</p>
                            </div>
                            </div>

                            <c:if test="${not empty bookTitle.description}">
                                <p style="margin-top: 10px; font-size: 0.9em;"><strong>Mô tả:</strong> ${bookTitle.description}</p>
                            </c:if>

                            <h3 style="margin-top: 15px;">📘 Các bản sao hiện có</h3>
                            <c:if test="${not empty documentCopies}">
                                <div class="document-copy-list">
                        <c:forEach var="doc" items="${documentCopies}">
                            <div class="document-copy-item" data-target="copy-${doc.id}">
                                <div>
                                    <strong>Bản sao #${doc.id}</strong>
                                    <span style="margin-left: 10px;" class="status status-${doc.status == 'Available' ? 'available' : 'borrowed'}">${doc.status}</span>
                                </div>
                                <div style="display:flex; align-items:center; gap:12px;">
                                    <span style="font-size: 13px; color:#666;">Tình trạng: ${doc.condition}%</span>
                                    <span class="expand-icon">▼</span>
                                </div>
                            </div>
                            <div class="document-copy-details" id="copy-${doc.id}">
                                <p><strong>Mã bản sao:</strong> #${doc.id}</p>
                                <p><strong>Trạng thái:</strong>
                                    <c:choose>
                                        <c:when test="${doc.status == 'Available'}">
                                            <span class="status status-available">Có sẵn</span>
                                        </c:when>
                                        <c:when test="${doc.status == 'Borrowed'}">
                                            <span class="status status-borrowed">Đã mượn</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status">${doc.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <p><strong>Tình trạng vật lý:</strong></p>
                                <div class="condition-bar">
                                    <c:set var="conditionClass" value="condition-excellent" />
                                    <c:if test="${doc.condition < 90}"><c:set var="conditionClass" value="condition-good" /></c:if>
                                    <c:if test="${doc.condition < 70}"><c:set var="conditionClass" value="condition-fair" /></c:if>
                                    <c:if test="${doc.condition < 50}"><c:set var="conditionClass" value="condition-poor" /></c:if>
                                    <c:if test="${doc.condition < 30}"><c:set var="conditionClass" value="condition-damaged" /></c:if>
                                    <div class="condition-fill ${conditionClass}" style="width: ${doc.condition}%"></div>
                                </div>
                                <p style="font-size: 13px; color: #555; margin-top: 6px;">
                                    <c:choose>
                                        <c:when test="${doc.condition >= 90}">Tình trạng xuất sắc</c:when>
                                        <c:when test="${doc.condition >= 70}">Tình trạng tốt</c:when>
                                        <c:when test="${doc.condition >= 50}">Tình trạng khá</c:when>
                                        <c:when test="${doc.condition >= 30}">Tình trạng trung bình</c:when>
                                        <c:otherwise>Tình trạng cần bảo dưỡng</c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                                </c:forEach>
                                </div>
                            </c:if>
                            <c:if test="${empty documentCopies}">
                                <div class="empty-state">
                                    <strong>⚠️ Chưa có bản sao nào cho đầu sách này.</strong>
                                </div>
                            </c:if>
                    </c:if>
                    <c:if test="${empty bookTitle}">
                        <div class="info-box" style="padding: 15px; font-size: 0.9em;">
                            <p>Chọn một đầu sách từ danh sách bên trái để xem chi tiết và các bản sao.</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <div class="footer-section">
            <div class="nav-links">
                <c:choose>
                    <c:when test="${sessionScope.userType == 'librarian'}">
                        <a href="${pageContext.request.contextPath}/view/ManageLendingDocument.jsp" class="btn" style="padding: 6px 15px; font-size: 0.9em;">📄 Quản lý mượn trả</a>
                        <a href="${pageContext.request.contextPath}/LibrarianHome.jsp" class="btn-secondary" style="padding: 6px 15px; font-size: 0.9em;">⬅ Về trang chủ</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/ReaderHome.jsp" class="btn-secondary" style="padding: 6px 15px; font-size: 0.9em;">⬅ Về trang chủ</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <script>
        window.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (!urlParams.has('keyword') && !urlParams.has('action')) {
                window.location.href = '${pageContext.request.contextPath}/searchDocument?action=search&keyword=';
            }

            document.querySelectorAll('.document-copy-item').forEach(function(item) {
                item.addEventListener('click', function() {
                    const targetId = this.getAttribute('data-target');
                    const detailsEl = document.getElementById(targetId);
                    if (detailsEl) {
                        detailsEl.classList.toggle('active');
                        const icon = this.querySelector('.expand-icon');
                        if (icon) {
                            icon.textContent = detailsEl.classList.contains('active') ? '▲' : '▼';
                        }
                    }
                });
            });
        });
    </script>
</body>
</html>
