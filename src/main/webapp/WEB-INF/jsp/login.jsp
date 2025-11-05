<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Authorization</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f7f7f7; }
        .container { width: 350px; margin: 80px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 0 10px #ccc; }
        h2 { text-align: center; }
        form { display: flex; flex-direction: column; gap: 10px; }
        input { padding: 10px; border: 1px solid #ccc; border-radius: 5px; }
        button { padding: 10px; background-color: #007bff; border: none; color: white; border-radius: 5px; cursor: pointer; }
        button:hover { background-color: #0056b3; }
        .error { color: red; text-align: center; }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="container">
    <h2>Authorization</h2>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/users/login" method="post">
        <label>Email:</label>
        <input type="email" name="email" required>

        <label>Password:</label>
        <input type="password" name="password" required>

        <button type="submit">Log in</button>
    </form>

    <p style="text-align:center; margin-top:15px;">
        No account? <a href="${pageContext.request.contextPath}/users/register">Registration</a>
    </p>
</div>
</body>
</html>
