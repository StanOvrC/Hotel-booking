<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - Hotel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>
<div class="main-content">
<section class="auth-container">
    <div class="auth-card">
        <h2>Login</h2>

        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/users/login" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            <label>Email</label>
            <input type="email" name="username" required placeholder="Enter your email">

            <label>Password</label>
            <input type="password" name="password" required placeholder="Enter your password">

            <button type="submit" class="auth-btn">Login</button>
        </form>

        <p class="switch-link">
            Don't have an account? <a href="${pageContext.request.contextPath}/users/register">Register</a>
        </p>
    </div>
</section>
</div>

<footer>
    2025 Hotel
</footer>

</body>
</html>
