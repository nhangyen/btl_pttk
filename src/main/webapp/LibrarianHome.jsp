<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Librarian Home</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h1>👨‍💼 Thông tin thủ thư</h1>
            <div>
                <c:if test="${not empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/logout" class="btn-secondary">Đăng xuất</a>
                </c:if>
            </div>
        </div>

        <c:if test="${not empty sessionScope.user}">
            <div class="info-box">
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 15px;">
                    <div>
                        <p><strong>Mã thủ thư:</strong> ${sessionScope.user.id}</p>
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
                        <p><strong>Vai trò:</strong>
                            <span class="status status-available">${empty sessionScope.user.role ? 'Librarian' : sessionScope.user.role}</span>
                        </p>
                    </div>
                </div>
            </div>
        </c:if>

        <h2>📋 Chức năng nhanh</h2>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/view/ManageLendingDocument.jsp" class="btn">Quản lý mượn trả</a>
            <a href="${pageContext.request.contextPath}/searchDocument" class="btn">Tìm kiếm đầu sách</a>
        </div>
    </div>
</body>
</html>
