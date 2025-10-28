<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Document Details</title>
</head>
<body>
    <h1>Document Details</h1>
    <c:if test="${not empty document}">
        <p><strong>ID:</strong> ${document.id}</p>
        <p><strong>Title:</strong> ${document.title}</p>
        <p><strong>Author:</strong> ${document.author}</p>
        <p><strong>Publisher:</strong> ${document.publisher}</p>
        <p><strong>Publication Year:</strong> ${document.publicationYear}</p>
        <p><strong>Description:</strong> ${document.description}</p>
        <p><strong>Quantity Available:</strong> ${document.quantity}</p>
    </c:if>
    <c:if test="${empty document}">
        <p>Document not found.</p>
    </c:if>
    <br>
    <a href="${pageContext.request.contextPath}/view/SearchDocumentView.jsp">Back to Search</a>
</body>
</html>
