<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Scan Reader Card</title>
</head>
<body>
    <h1>Scan or Search for Reader</h1>
    <form action="${pageContext.request.contextPath}/scanReader" method="get">
        <input type="text" name="keyword" placeholder="Enter Reader ID or Name" size="50">
        <input type="submit" value="Search Reader">
    </form>

    <hr>

    <c:if test="${not empty reader}">
        <h3>Reader Found</h3>
        <p><strong>ID:</strong> ${reader.id}</p>
        <p><strong>Username:</strong> ${reader.username}</p>
        <p><strong>Name:</strong> ${reader.name}</p>
        <p><strong>Address:</strong> ${reader.address}</p>
        <p><strong>Email:</strong> ${reader.email}</p>
        <p><strong>Phone:</strong> ${reader.phone}</p>
        <form action="ManageLendingDocument.jsp" method="post">
            <% session.setAttribute("selectedReader", request.getAttribute("reader")); %>
            <input type="submit" value="OK">
        </form>
    </c:if>
     <c:if test="${empty reader && not empty param.keyword}">
        <p>Reader not found.</p>
    </c:if>
</body>
</html>
