<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Manage Lending</title>
</head>
<body>
    <h1>Manage Document Lending</h1>

    <!-- Step 1: Scan Reader Card -->
    <a href="ScanReaderCard.jsp">Scan Reader Card</a>

    <c:if test="${not empty sessionScope.selectedReader}">
        <hr>
        <h3>Selected Reader</h3>
        <p>ID: ${sessionScope.selectedReader.id}</p>
        <p>Name: ${sessionScope.selectedReader.name}</p>

        <!-- Step 2: Scan Document -->
        <hr>
        <h3>Add Document to Loan</h3>
        <form action="${pageContext.request.contextPath}/lending" method="post">
            <input type="hidden" name="action" value="addDocument">
            Document ID: <input type="text" name="docId">
            Due Date: <input type="date" name="dueDate">
            <input type="submit" value="Add Document">
        </form>
        <br>
        <a href="ScanDocument.jsp">Or Scan Document</a>

        <!-- Current Loan -->
        <hr>
        <h3>Current Loan Cart</h3>
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

        <!-- Step 3: Print Slip -->
        <hr>
        <form action="${pageContext.request.contextPath}/lending" method="post">
            <input type="hidden" name="action" value="saveLoan">
            <input type="submit" value="Print Loan Slip">
        </form>
    </c:if>

    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>

</body>
</html>
