<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Profile</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<h2>Welcome, ${user.username}!</h2>
<p>Email: ${user.email}</p>
<p>Role: ${user.role}</p>

<a href="${pageContext.request.contextPath}/users/logout">Logout</a>
</body>
</html>
