<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Scan Reader Card</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .info-container {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            margin-bottom: 20px;
        }
        .info-container .info-box {
            flex: 1;
            border: 1px solid #ccc;
            padding: 15px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Scan or Search for Reader</h1>
        <form action="${pageContext.request.contextPath}/scanReader" method="get">
            <input type="text" name="keyword" placeholder="Enter Reader ID, Username, or Name">
            <button type="submit">Search Reader</button>
        </form>

        <c:if test="${not empty reader}">
            <h3>Reader Found</h3>
            <div class="info-container">
                <div class="info-box">
                    <h4>Reader Information</h4>
                    <p><strong>ID:</strong> ${reader.id}</p>
                    <p><strong>Username:</strong> ${reader.username}</p>
                    <p><strong>Name:</strong> ${reader.name}</p>
                    <p><strong>Address:</strong> ${reader.address}</p>
                    <p><strong>Email:</strong> ${reader.email}</p>
                    <p><strong>Phone:</strong> ${reader.phone}</p>
                </div>

                <c:if test="${not empty reader.readerCard}">
                    <div class="info-box">
                        <h4>Reader Card Information</h4>
                        <p><strong>Card ID:</strong> ${reader.readerCard.cardId}</p>
                        <p><strong>Registration Date:</strong> ${reader.readerCard.registrationDate}</p>
                        <p><strong>Status:</strong> ${reader.readerCard.status}</p>
                        <c:if test="${not empty reader.readerCard.path}">
                            <img src="${pageContext.request.contextPath}/${reader.readerCard.path}" alt="Reader Card Image" style="max-width: 150px; margin-top: 10px;">
                        </c:if>
                    </div>
                </c:if>
            </div>
            
            <form action="${pageContext.request.contextPath}/view/ManageLendingDocument.jsp" method="post">
                <% session.setAttribute("selectedReader", request.getAttribute("reader")); %>
                <button type="submit">Select This Reader</button>
            </form>
        </c:if>
        
        
        <c:if test="${empty reader && not empty param.keyword}">
            <div class="alert alert-error">
                <p>Reader not found. Please try again.</p>
            </div>
        </c:if>
        
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/view/ManageLendingDocument.jsp" class="btn-secondary">Back</a>
        </div>
    </div>
</body>
</html>
