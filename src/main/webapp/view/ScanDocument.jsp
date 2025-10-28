<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Scan Document</title>
</head>
<body>
    <h1>Scan or Search for Document</h1>
    <form action="${pageContext.request.contextPath}/searchDocument" method="get">
         <input type="hidden" name="action" value="search">
        <input type="text" name="keyword" placeholder="Enter document title" size="50">
        <input type="submit" value="Search">
    </form>

    <hr>

    <h3>Search Results</h3>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="doc" items="${documents}">
                <tr>
                    <td>${doc.id}</td>
                    <td>${doc.title}</td>
                    <td>
                        <form action="${pageContext.request.contextPath}/lending" method="post">
                            <input type="hidden" name="action" value="addDocument">
                            <input type="hidden" name="docId" value="${doc.id}">
                            Due Date: <input type="date" name="dueDate" required>
                            <input type="submit" value="Add to Loan">
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
