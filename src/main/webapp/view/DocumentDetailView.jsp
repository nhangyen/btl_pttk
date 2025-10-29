<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Document Details</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <h1>Document Details</h1>
        <c:if test="${not empty document}">
            <div class="info-box">
                <p><strong>ID:</strong> ${document.id}</p>
                <p><strong>Title:</strong> ${document.title}</p>
                <p><strong>Publisher:</strong> ${document.author}</p>
                <p><strong>Category:</strong> ${document.category}</p>
                <p><strong>Language:</strong> ${document.language}</p>
                <p><strong>Publication Year:</strong> ${document.publicationYear}</p>
                <p><strong>Description:</strong> ${document.description}</p>
                <p><strong>Page Count:</strong> ${document.pageCount}</p>
                <p><strong>Condition:</strong> ${document.condition}%</p>
                <p><strong>Status:</strong> <span class="status status-${document.status == 'Available' ? 'available' : 'borrowed'}">${document.status}</span></p>
            </div>
        </c:if>
        <c:if test="${empty document}">
            <div class="alert alert-error">
                <p>Document not found.</p>
            </div>
        </c:if>
        
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/view/SearchDocumentView.jsp" class="btn-secondary">Back to Search</a>
        </div>
    </div>
</body>
</html>
