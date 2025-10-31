<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Search Documents</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h1>📚 Search for Documents</h1>
            <div>
                <c:if test="${not empty sessionScope.user}">
                    <span style="margin-right: 15px;">Xin chào, <strong>${sessionScope.user.name}</strong></span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn-secondary">Đăng xuất</a>
                </c:if>
            </div>
        </div>
        <form action="${pageContext.request.contextPath}/searchDocument" method="get">
            <input type="hidden" name="action" value="search">
            <input type="text" name="keyword" placeholder="Enter document title or category" value="${keyword}">
            <button type="submit">🔍 Search</button>
        </form>

        <h3>Available Documents</h3>
        <c:if test="${not empty documents}">
            <table>
                <thead>
                    <tr>
                        <th>Document ID</th>
                        <th>Title</th>
                        <th>Publisher</th>
                        <th>Category</th>
                        <th>Language</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="doc" items="${documents}">
                        <tr>
                            <td><strong>#${doc.id}</strong></td>
                            <td>${doc.title}</td>
                            <td>${doc.author}</td>
                            <td><span class="status status-available">${doc.category}</span></td>
                            <td>${doc.language}</td>
                            <td><span class="status status-${doc.status == 'Available' ? 'available' : 'borrowed'}">${doc.status}</span></td>
                            <td><a href="${pageContext.request.contextPath}/searchDocument?action=detail&id=${doc.id}" class="btn">View Details</a></td>
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
            <a href="${pageContext.request.contextPath}/ReaderHome.jsp" class="btn-secondary">Back to Home</a>
        </div>
    </div>
    
    <script>
        // Load documents on page load if no search has been performed
        window.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (!urlParams.has('keyword') && !urlParams.has('action')) {
                // Redirect to load all documents
                window.location.href = '${pageContext.request.contextPath}/searchDocument?action=search&keyword=';
            }
        });
    </script>
</body>
</html>
