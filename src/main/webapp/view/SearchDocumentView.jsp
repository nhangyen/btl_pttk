<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Tìm kiếm đầu sách</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .detail-section {
            background: #f8f9fa;
            padding: 25px;
            border-radius: 10px;
            margin-top: 30px;
            box-shadow: inset 0 0 0 1px rgba(102, 126, 234, 0.08);
        }

        .detail-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 15px;
        }

        .document-copy-list {
            margin-top: 20px;
        }

        .document-copy-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 18px;
            background: #ffffff;
            border: 1px solid #e3e6ef;
            border-radius: 8px;
            margin-bottom: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .document-copy-item:hover {
            border-color: rgba(102, 126, 234, 0.5);
            box-shadow: 0 6px 18px rgba(102, 126, 234, 0.15);
        }

        .document-copy-details {
            display: none;
            background: #fdfdff;
            border: 1px solid #e3e6ef;
            border-radius: 0 0 8px 8px;
            border-top: none;
            padding: 18px;
            margin-top: -10px;
            margin-bottom: 10px;
        }

        .document-copy-details.active {
            display: block;
        }

        .condition-bar {
            height: 6px;
            width: 100%;
            background: #e1e5f2;
            border-radius: 4px;
            overflow: hidden;
            margin: 8px 0;
        }

        .condition-fill {
            height: 100%;
            transition: width 0.4s ease;
        }

        .condition-excellent { background: #38c172; }
        .condition-good { background: #51d88a; }
        .condition-fair { background: #ffed4a; }
        .condition-poor { background: #f6993f; }
        .condition-damaged { background: #e3342f; }

        .empty-state {
            padding: 18px;
            background: #fff5f5;
            border-radius: 8px;
            color: #c53030;
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h1>📚 Tìm kiếm đầu sách</h1>
            <div>
                <c:if test="${not empty sessionScope.user}">
                    <span style="margin-right: 15px;">Xin chào, <strong>${sessionScope.user.name}</strong></span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn-secondary">Đăng xuất</a>
                </c:if>
            </div>
        </div>

        <form action="${pageContext.request.contextPath}/searchDocument" method="get">
            <input type="hidden" name="action" value="search">
            <input type="text" name="keyword" placeholder="Nhập tên sách, thể loại hoặc nhà xuất bản..." value="${keyword}">
            <button type="submit">🔍 Tìm kiếm</button>
        </form>

        <h3>Danh sách đầu sách</h3>
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

        <c:if test="${not empty bookTitle}">
            <div class="detail-section">
                <h2>🔍 Thông tin đầu sách</h2>
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
                    <p style="margin-top: 15px;"><strong>Mô tả:</strong> ${bookTitle.description}</p>
                </c:if>

                <h3 style="margin-top: 25px;">📘 Các bản sao hiện có</h3>
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
            </div>
        </c:if>

        <div class="nav-links" style="margin-top: 25px;">
            <c:choose>
                <c:when test="${sessionScope.userType == 'librarian'}">
                    <a href="${pageContext.request.contextPath}/LibrarianHome.jsp" class="btn-secondary">Về trang thủ thư</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/ReaderHome.jsp" class="btn-secondary">Về trang độc giả</a>
                </c:otherwise>
            </c:choose>
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
