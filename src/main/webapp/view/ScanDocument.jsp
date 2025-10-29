<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Scan Document</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <h1>Scan or Search for Document</h1>
        <form action="${pageContext.request.contextPath}/searchDocument" method="get">
            <input type="hidden" name="action" value="search">
            <input type="text" name="keyword" placeholder="Enter document title or category">
            <button type="submit">Search</button>
        </form>

        <c:if test="${not empty documents}">
            <h3>Search Results</h3>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Category</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="doc" items="${documents}">
                        <tr>
                            <td>${doc.id}</td>
                            <td>${doc.title}</td>
                            <td>${doc.category}</td>
                            <td><span class="status status-${doc.status == 'Available' ? 'available' : 'borrowed'}">${doc.status}</span></td>
                            <td>
                                <form action="${pageContext.request.contextPath}/lending" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="addDocument">
                                    <input type="hidden" name="docId" value="${doc.id}">
                                    <input type="date" name="dueDate" required>
                                    <button type="submit">Add to Loan</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/view/ManageLendingDocument.jsp" class="btn-secondary">Back to Lending</a>
        </div>
    </div>
</body>
</html>
