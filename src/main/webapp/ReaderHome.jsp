<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Reader Home</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h1>👤 Thông tin độc giả</h1>
            <div>
                <c:if test="${not empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/logout" class="btn-secondary">Đăng xuất</a>
                </c:if>
            </div>
        </div>

        <c:if test="${not empty sessionScope.user}">
            <div class="info-box">
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 15px; align-items: start;">
                    <div>
                        <p><strong>Mã độc giả:</strong> ${sessionScope.user.id}</p>
                        <p><strong>Tên đăng nhập:</strong> ${sessionScope.user.username}</p>
                        <p><strong>Họ và tên:</strong> ${sessionScope.user.name}</p>
                        <p><strong>Email:</strong> ${sessionScope.user.email}</p>
                        <p><strong>Số điện thoại:</strong> ${sessionScope.user.phoneNumber}</p>
                    </div>
                    <div>
                        <p><strong>Ngày sinh:</strong>
                            <c:choose>
                                <c:when test="${not empty sessionScope.user.dob}">
                                    <fmt:formatDate value="${sessionScope.user.dob}" pattern="dd/MM/yyyy"/>
                                </c:when>
                                <c:otherwise>Chưa cập nhật</c:otherwise>
                            </c:choose>
                        </p>
                        <p><strong>Giới tính:</strong> ${empty sessionScope.user.gender ? 'Chưa cập nhật' : sessionScope.user.gender}</p>
                        <p><strong>Địa chỉ:</strong> ${empty sessionScope.user.address ? 'Chưa cập nhật' : sessionScope.user.address}</p>
                        <p><strong>Mã thẻ:</strong> #${sessionScope.user.readerCard.cardId}</p>
                            <p><strong>Ngày đăng ký:</strong>
                                <fmt:formatDate value="${sessionScope.user.readerCard.registrationDate}" pattern="dd/MM/yyyy"/>
                            </p>
                            <c:set var="cardStatus" value="${fn:toUpperCase(sessionScope.user.readerCard.status)}" />
                            <p><strong>Trạng thái thẻ:</strong>
                                <span class="status status-${cardStatus == 'ACTIVE' ? 'available' : 'borrowed'}">
                                    ${sessionScope.user.readerCard.status}
                                </span>
                            </p>

                    </div>
                    <c:if test="${not empty sessionScope.user.readerCard}">
                        <div>
                            <c:if test="${not empty sessionScope.user.readerCard.path}">
                                <div style="margin-top: 12px; display: flex; flex-direction: column; align-items: center;">
                                    <img src="${pageContext.request.contextPath}/${sessionScope.user.readerCard.path}" alt="Ảnh thẻ" style="width: 180px; height: 220px; object-fit: cover; border-radius: 12px; border: 3px solid #6c63ff; box-shadow: 0 4px 12px rgba(108, 99, 255, 0.3);">
                                    <span style="margin-top: 8px; font-size: 0.9em; color: #555;">Ảnh thẻ</span>
                                </div>
                            </c:if>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:if>

        <h2>📚 Chức năng nhanh</h2>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/searchDocument" class="btn">Tìm kiếm đầu sách</a>
        </div>
    </div>
</body>
</html>
