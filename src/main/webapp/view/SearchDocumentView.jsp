<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Search Documents</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <h1>Search for a Document</h1>
        <form action="${pageContext.request.contextPath}/searchDocument" method="get">
            <input type="hidden" name="action" value="search">
            <input type="text" name="keyword" placeholder="Enter document title or category" size="50">
            <input type="submit" value="Search">
        </form>

        <c:if test="${not empty documents}">
            <h3>Search Results</h3>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Publisher</th>
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
                            <td>${doc.author}</td>
                            <td>${doc.category}</td>
                            <td><span class="status status-${doc.status == 'Available' ? 'available' : 'borrowed'}">${doc.status}</span></td>
                            <td><a href="${pageContext.request.contextPath}/searchDocument?action=detail&id=${doc.id}" class="btn">View Details</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/ReaderHome.jsp" class="btn-secondary">Back to Home</a>
        </div>
    </div>
</body>
</html>
