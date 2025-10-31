<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Print Loan Slip</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        @media print {
            .no-print { display: none; }
            body { background: white; }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📋 Loan Slip</h1>

        <c:if test="${not empty message}">
            <div class="alert alert-success no-print">
                <p>${message}</p>
            </div>
        </c:if>

        <div class="info-box">
            <p><strong>Loan Date:</strong> <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd/MM/yyyy HH:mm"/></p>
        </div>

        <h3>Reader Information</h3>
        <div class="info-box">
            <p><strong>Reader ID:</strong> ${sessionScope.selectedReader.id}</p>
            <p><strong>Name:</strong> ${sessionScope.selectedReader.name}</p>
            <p><strong>Email:</strong> ${sessionScope.selectedReader.email}</p>
            <p><strong>Phone:</strong> ${sessionScope.selectedReader.phone}</p>
        </div>

        <h3>Librarian Information</h3>
        <div class="info-box">
            <p><strong>Librarian ID:</strong> ${sessionScope.loggedInLibrarian.id}</p>
            <p><strong>Name:</strong> ${sessionScope.loggedInLibrarian.name}</p>
        </div>

        <h3>Loaned Documents</h3>
        <table>
            <thead>
                <tr>
                    <th>No.</th>
                    <th>Document ID</th>
                    <th>Title</th>
                    <th>Publisher</th>
                    <th>Category</th>
                    <th>Due Date</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="detail" items="${sessionScope.currentLoanDetails}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td><strong>#${detail.documentCopy.id}</strong></td>
                        <td>${detail.documentCopy.title}</td>
                        <td>${detail.documentCopy.author}</td>
                        <td>${detail.documentCopy.category}</td>
                        <td><fmt:formatDate value="${detail.dueDate}" pattern="dd/MM/yyyy"/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="nav-links no-print">
            <button onclick="window.print()">🖨️ Print</button>
            <a href="${pageContext.request.contextPath}/LibrarianHome.jsp" class="btn-secondary">Back to Home</a>
        </div>
    </div>
</body>
</html>
