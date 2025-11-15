<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Ошибка</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<jsp:include page="navbar.jsp"/>
    <h1 style="color:red;">Error</h1>
    <a href="${pageContext.request.contextPath}/rooms">Back to rooms</a>
    <footer>
        <p>2025 Hotel</p>
    </footer>
</body>
</html>