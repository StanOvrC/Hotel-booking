<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Registration</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f7f7f7; }
        .container { width: 400px; margin: 60px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 0 10px #ccc; }
        h2 { text-align: center; }
        form { display: flex; flex-direction: column; gap: 10px; }
        input, select { padding: 10px; border: 1px solid #ccc; border-radius: 5px; }
        button { padding: 10px; background-color: #007bff; border: none; color: white; border-radius: 5px; cursor: pointer; }
        button:hover { background-color: #0056b3; }
        .error { color: red; text-align: center; }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="container">
    <h2>Registration</h2>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/users/register" method="post">
        <label>Name:</label>
        <input type="text" name="username" required>

        <label>Email:</label>
        <input type="email" name="email" required>

        <label>Password:</label>
        <input type="password" name="password" required>

        <label>Role:</label>
        <select name="role" required>
            <option value="USER">User</option>
            <option value="MANAGER">Manager</option>
            <option value="ADMIN">Admin</option>
        </select>

        <button type="submit">Register</button>
    </form>

    <p style="text-align:center; margin-top:15px;">
        Already have an account? <a href="${pageContext.request.contextPath}/users/login">Log in</a>
    </p>
</div>
</body>
</html>
