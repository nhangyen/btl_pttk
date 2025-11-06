<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title>Quản lý phiếu mượn</title>
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
            margin-bottom: 10px;
        }

        .action-buttons {
            flex-shrink: 0;
            margin-bottom: 12px;
        }

        .action-buttons .nav-links {
            margin: 0;
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .action-buttons .btn, .action-buttons .btn-secondary, .action-buttons button {
            padding: 8px 15px;
            font-size: 0.9em;
            margin: 0;
        }

        .content-wrapper {
            flex: 1;
            display: grid;
            grid-template-columns: 1fr 1.5fr;
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

        .info-box {
            padding: 12px;
            margin-bottom: 12px;
            font-size: 0.9em;
        }

        .info-box p {
            margin: 5px 0;
        }

        table {
            margin: 0;
            font-size: 0.9em;
        }

        table th, table td {
            padding: 8px 10px;
        }

        .add-document-form {
            margin-top: 12px;
            padding: 12px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .add-document-form label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            font-size: 0.9em;
        }

        .add-document-form input {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            font-size: 0.9em;
        }

        .add-document-form button {
            width: 100%;
            padding: 10px;
            font-size: 0.95em;
        }

        h1 {
            font-size: 1.5em;
            margin: 0;
        }

        h3 {
            font-size: 1.1em;
            margin: 0 0 8px 0;
        }

        .alert {
            padding: 10px;
            margin: 10px 0;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header-section" style="display: flex; justify-content: space-between; align-items: center;">
            <h1>📄 Quản lý phiếu mượn</h1>
            <div>
                <c:if test="${not empty sessionScope.user}">
                    <span style="margin-right: 15px; font-size: 0.9em;">Xin chào, <strong>${sessionScope.user.name}</strong></span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn-secondary" style="padding: 6px 12px; font-size: 0.9em;">Đăng xuất</a>
                </c:if>
            </div>
        </div>

        <div class="action-buttons">
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/view/ScanReaderCard.jsp" class="btn">🔍 Tìm độc giả</a>
                <a href="${pageContext.request.contextPath}/searchBookTitle" class="btn">📚 Tìm tài liệu</a>
                <c:if test="${not empty sessionScope.selectedReader && not empty sessionScope.currentLoanDetails}">
                    <form action="${pageContext.request.contextPath}/lending" method="post" style="display: inline; margin: 0;">
                        <input type="hidden" name="action" value="saveLoan">
                        <button type="submit">🖨️ In phiếu mượn</button>
                    </form>
                </c:if>
                <a href="${pageContext.request.contextPath}/LibrarianHome.jsp" class="btn-secondary">⬅ Quay lại</a>
            </div>
        </div>

        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger" style="background: linear-gradient(135deg, #ff6b6b, #ee5a52); color: white; border-radius: 8px;">
                <strong>⚠️ Lỗi:</strong> ${sessionScope.error}
            </div>
            <c:remove var="error" scope="session" />
        </c:if>

        <c:if test="${not empty requestScope.error}">
            <div class="alert alert-danger" style="background: linear-gradient(135deg, #ff6b6b, #ee5a52); color: white; border-radius: 8px;">
                <strong>⚠️ Lỗi:</strong> ${requestScope.error}
            </div>
        </c:if>

        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success" style="background: linear-gradient(135deg, #51cf66, #37b24d); color: white; border-radius: 8px;">
                <strong>✅ Thành công:</strong> ${sessionScope.success}
            </div>
            <c:remove var="success" scope="session" />
        </c:if>

        <c:if test="${not empty sessionScope.selectedReader}">
            <div class="content-wrapper">
                <div class="left-panel">
                    <div class="panel-header">
                        <h3>👤 Thông tin độc giả</h3>
                    </div>
                    <div class="scrollable-content">
                        <div class="info-box">
                            <div style="display: flex; gap: 15px; align-items: flex-start;">
                                <div>
                                    <p><strong>Mã độc giả:</strong> #${sessionScope.selectedReader.id}</p>
                                    <p><strong>Họ tên:</strong> ${sessionScope.selectedReader.name}</p>
                                    <p><strong>Email:</strong> ${empty sessionScope.selectedReader.email ? 'Chưa cập nhật' : sessionScope.selectedReader.email}</p>
                                    <p><strong>Số điện thoại:</strong> ${empty sessionScope.selectedReader.phoneNumber ? 'Chưa cập nhật' : sessionScope.selectedReader.phoneNumber}</p>
                                    <c:if test="${not empty sessionScope.selectedReader.readerCard}">
                                        <p><strong>Mã thẻ:</strong> #${sessionScope.selectedReader.readerCard.cardId}</p>
                                        <c:set var="readerCardStatus" value="${fn:toUpperCase(sessionScope.selectedReader.readerCard.status)}" />
                                        <p><strong>Trạng thái thẻ:</strong>
                                            <span class="status status-${readerCardStatus == 'ACTIVE' ? 'available' : 'borrowed'}">
                                                ${sessionScope.selectedReader.readerCard.status}
                                            </span>
                                        </p>
                                    </c:if>
                                </div>
                                <c:if test="${not empty sessionScope.selectedReader.readerCard && not empty sessionScope.selectedReader.readerCard.path}">
                                    <img src="${pageContext.request.contextPath}/${sessionScope.selectedReader.readerCard.path}" alt="Reader Card Image" style="max-width: 100px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                                </c:if>
                            </div>
                        </div>

                        <div class="add-document-form">
                            <h3 style="margin-bottom: 10px;">➕ Thêm tài liệu</h3>
                            <form action="${pageContext.request.contextPath}/lending" method="post">
                                <input type="hidden" name="action" value="addDocument">
                                <label for="docId">Mã bản sao:</label>
                                <input type="text" id="docId" name="docId" placeholder="Nhập mã bản sao" required>
                                <label for="dueDate">Ngày trả dự kiến:</label>
                                <input type="date" id="dueDate" name="dueDate" required>
                                <button type="submit">Thêm vào giỏ</button>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="right-panel">
                    <div class="panel-header">
                        <h3>🛒 Danh sách tài liệu trong giỏ mượn</h3>
                    </div>
                    <div class="scrollable-content">
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
                    </div>
                </div>
            </div>
        </c:if>
        
        <c:if test="${empty sessionScope.selectedReader}">
            <div class="info-box" style="margin-top: 20px;">
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
