<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Print Loan Slip</title>
</head>
<body>
    <h1>Loan Slip Details</h1>

    <c:if test="${not empty message}">
        <h3 style="color:green;">${message}</h3>
    </c:if>

    <p><strong>Loan Date:</strong> <%= new java.util.Date() %></p>
    <hr>
    <h3>Reader Information</h3>
    <p><strong>Reader ID:</strong> ${sessionScope.selectedReader.id}</p>
    <p><strong>Reader Name:</strong> ${sessionScope.selectedReader.name}</p>
    <hr>
    <h3>Librarian Information</h3>
    <p><strong>Librarian ID:</strong> ${sessionScope.loggedInLibrarian.id}</p>
    <p><strong>Librarian Name:</strong> ${sessionScope.loggedInLibrarian.name}</p>
    <hr>
    <h3>Loaned Documents</h3>
    <table border="1">
        <thead>
            <tr>
                <th>Doc ID</th>
                <th>Title</th>
                <th>Due Date</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="detail" items="${sessionScope.currentLoanDetails}">
                <tr>
                    <td>${detail.document.id}</td>
                    <td>${detail.document.title}</td>
                    <td>${detail.dueDate}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <br>
    <button onclick="window.print()">Print</button>
    <a href="${pageContext.request.contextPath}/LibrarianHome.jsp">Back to Home</a>
</body>
</html>
