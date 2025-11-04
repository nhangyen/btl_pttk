<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Manage Document Lending</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h1>📄 Quản lý phiếu mượn</h1>
            <div>
                <c:if test="${not empty sessionScope.user}">
                    <span style="margin-right: 15px;">Xin chào, <strong>${sessionScope.user.name}</strong></span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn-secondary">Đăng xuất</a>
                </c:if>
            </div>
        </div>

        <div class="nav-links" style="margin-bottom: 25px;">
            <a href="${pageContext.request.contextPath}/view/ScanReaderCard.jsp" class="btn">🔍 Tìm độc giả</a>
            <a href="${pageContext.request.contextPath}/searchDocument" class="btn">📚 Tìm tài liệu</a>
            <c:if test="${not empty sessionScope.selectedReader && not empty sessionScope.currentLoanDetails}">
                <form action="${pageContext.request.contextPath}/lending" method="post" style="display: inline;">
                    <input type="hidden" name="action" value="saveLoan">
                    <button type="submit">🖨️ In phiếu mượn</button>
                </form>
            </c:if>
            <a href="${pageContext.request.contextPath}/LibrarianHome.jsp" class="btn-secondary">⬅ Quay lại</a>
        </div>

        <c:if test="${not empty sessionScope.selectedReader}">
            <h3>👤 Thông tin độc giả</h3>
            <div class="info-box">
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 15px;">
                    <div>
                        <p><strong>Mã độc giả:</strong> #${sessionScope.selectedReader.id}</p>
                        <p><strong>Họ tên:</strong> ${sessionScope.selectedReader.name}</p>
                        <p><strong>Email:</strong> ${empty sessionScope.selectedReader.email ? 'Chưa cập nhật' : sessionScope.selectedReader.email}</p>
                    </div>
                    <div>
                        <p><strong>Số điện thoại:</strong> ${empty sessionScope.selectedReader.phoneNumber ? 'Chưa cập nhật' : sessionScope.selectedReader.phoneNumber}</p>
                        <c:if test="${not empty sessionScope.selectedReader.readerCard}">
                            <p><strong>Mã thẻ:</strong> #${sessionScope.selectedReader.readerCard.cardId}</p>
                            <p><strong>Trạng thái thẻ:</strong>
                                <span class="status status-${sessionScope.selectedReader.readerCard.status == 'ACTIVE' ? 'available' : 'borrowed'}">
                                    ${sessionScope.selectedReader.readerCard.status}
                                </span>
                            </p>
                        </c:if>
                    </div>
                </div>
            </div>

            <h3 style="margin-top: 25px;">🛒 Danh sách tài liệu trong giỏ mượn</h3>
            <c:if test="${not empty sessionScope.currentLoanDetails}">
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Mã tài liệu</th>
                            <th>Tên tài liệu</th>
                            <th>Nhà xuất bản</th>
                            <th>Thể loại</th>
                            <th>Ngày trả dự kiến</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="detail" items="${sessionScope.currentLoanDetails}" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td><strong>#${detail.documentCopy.id}</strong></td>
                                <td>${detail.documentCopy.title}</td>
                                <td>${detail.documentCopy.publisher}</td>
                                <td>${detail.documentCopy.category}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty detail.dueDate}">
                                            <fmt:formatDate value="${detail.dueDate}" pattern="dd/MM/yyyy"/>
                                        </c:when>
                                        <c:otherwise>Chưa đặt</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty sessionScope.currentLoanDetails}">
                <div class="info-box">
                    <p>Chưa có tài liệu nào trong giỏ mượn. Vui lòng thêm tài liệu.</p>
                </div>
            </c:if>

            <h3 style="margin-top: 25px;">➕ Thêm tài liệu</h3>
            <form action="${pageContext.request.contextPath}/lending" method="post" class="form-inline">
                <input type="hidden" name="action" value="addDocument">
                <label for="docId">Mã tài liệu:</label>
                <input type="text" id="docId" name="docId" placeholder="Nhập mã bản sao tài liệu" required>
                <label for="dueDate">Ngày trả dự kiến:</label>
                <input type="date" id="dueDate" name="dueDate" required>
                <button type="submit">Thêm vào giỏ</button>
            </form>
        </c:if>
        
        <c:if test="${empty sessionScope.selectedReader}">
            <div class="info-box">
                <p>Vui lòng lựa chọn độc giả trước khi thêm tài liệu vào giỏ mượn.</p>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <p>${error}</p>
            </div>
        </c:if>
    </div>
</body>
</html>
