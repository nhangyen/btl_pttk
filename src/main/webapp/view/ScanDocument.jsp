<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Scan Document</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <h1>📖 Scan or Search for Document</h1>
        <form action="${pageContext.request.contextPath}/searchDocument" method="get">
            <input type="hidden" name="action" value="search">
            <input type="text" name="keyword" placeholder="Enter document title or category" value="${keyword}">
            <button type="submit">🔍 Search</button>
        </form>

        <h3>Available Documents for Lending</h3>
        <c:if test="${not empty documents}">
            <table>
                <thead>
                    <tr>
                        <th>Doc ID</th>
                        <th>Title</th>
                        <th>Publisher</th>
                        <th>Category</th>
                        <th>Status</th>
                        <th>Due Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="doc" items="${documents}">
                        <tr>
                            <td><strong>#${doc.id}</strong></td>
                            <td>${doc.title}</td>
                            <td>${doc.author}</td>
                            <td>${doc.category}</td>
                            <td><span class="status status-${doc.status == 'Available' ? 'available' : 'borrowed'}">${doc.status}</span></td>
                            <td>
                                <form action="${pageContext.request.contextPath}/lending" method="post" style="display:inline; margin:0;">
                                    <input type="hidden" name="action" value="addDocument">
                                    <input type="hidden" name="docId" value="${doc.id}">
                                    <input type="date" name="dueDate" required style="width:auto; margin:0;">
                            </td>
                            <td>
                                    <button type="submit">Add to Loan</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        
        <c:if test="${empty documents}">
            <div class="alert alert-error">
                <p>No documents found. Please try another keyword.</p>
            </div>
        </c:if>
        
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/view/ManageLendingDocument.jsp" class="btn-secondary">Back to Lending</a>
        </div>
    </div>
    
    <script>
        // Load documents on page load
        window.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (!urlParams.has('keyword') && !urlParams.has('action')) {
                window.location.href = '${pageContext.request.contextPath}/searchDocument?action=search&keyword=';
            }
        });
    </script>
</body>
</html>
