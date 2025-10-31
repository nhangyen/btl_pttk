<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Manage Document Lending</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h1>Manage Document Lending</h1>
            <div>
                <c:if test="${not empty sessionScope.user}">
                    <span style="margin-right: 15px;">Xin chào, <strong>${sessionScope.user.name}</strong></span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn-secondary">Đăng xuất</a>
                </c:if>
            </div>
        </div>

    <!-- Step 1: Scan Reader Card -->
    <div class="nav-links">
        <a href="ScanReaderCard.jsp">Scan Reader Card</a>
    </div>

    <c:if test="${not empty sessionScope.selectedReader}">
        <h3>Selected Reader</h3>
        <div class="info-box">
            <p><strong>ID:</strong> ${sessionScope.selectedReader.id}</p>
            <p><strong>Name:</strong> ${sessionScope.selectedReader.name}</p>
            <p><strong>Email:</strong> ${sessionScope.selectedReader.email}</p>
        </div>

        <!-- Step 2: Scan Document -->
        <h3>Add Document to Loan</h3>
        <form action="${pageContext.request.contextPath}/lending" method="post">
            <input type="hidden" name="action" value="addDocument">
            <label>Document ID:</label>
            <input type="text" name="docId" placeholder="Enter document ID">
            <label>Due Date:</label>
            <input type="date" name="dueDate">
            <button type="submit">Add Document</button>
        </form>
        
        <div class="nav-links">
            <a href="ScanDocument.jsp">Or Scan Document</a>
        </div>

        <!-- Current Loan -->
        <h3>📋 Current Loan Cart</h3>
        <c:if test="${not empty sessionScope.currentLoanDetails}">
            <table>
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Doc ID</th>
                        <th>Title</th>
                        <th>Publisher</th>
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
                            <td>${detail.dueDate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        
        <c:if test="${empty sessionScope.currentLoanDetails}">
            <div class="info-box">
                <p>No documents added yet. Please add documents to the loan cart.</p>
            </div>
        </c:if>

        <!-- Step 3: Print Slip -->
        <form action="${pageContext.request.contextPath}/lending" method="post">
            <input type="hidden" name="action" value="saveLoan">
            <button type="submit">Print Loan Slip</button>
        </form>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-error">
            <p>${error}</p>
        </div>
    </c:if>
    
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/LibrarianHome.jsp" class="btn-secondary">Back to Home</a>
    </div>
    
    </div>
</body>
</html>
