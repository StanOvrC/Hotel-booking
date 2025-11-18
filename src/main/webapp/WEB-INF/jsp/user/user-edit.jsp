<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit User</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<section class="auth-container" style="margin-top: 30px;">
  <div class="auth-card">
    <h2>Edit User</h2>

    <c:if test="${not empty error}">
      <div class="error-message">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/users/edit/${user.id}" method="post">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
      <input type="hidden" name="id" value="${user.id}"/>

      <!-- First Name -->
      <label for="firstName">First Name</label>
      <input id="firstName" type="text" name="username" value="${user.username}" required>

      <!-- Email -->
      <label for="email">Email</label>
      <input id="email" type="email" name="email" value="${user.email}" required>

      <!-- Role -->
      <label for="role">Role</label>
      <select id="role" name="role" required>
        <option value="ADMIN"   ${user.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
        <option value="MANAGER" ${user.role == 'MANAGER' ? 'selected' : ''}>Manager</option>
        <option value="USER"    ${user.role == 'USER' ? 'selected' : ''}>User</option>
      </select>

      <button type="submit" class="auth-btn" style="margin-top: 20px;">Save Changes</button>

      <div class="switch-link">
        <a href="${pageContext.request.contextPath}/users">&larr; Back to Users</a>
      </div>
    </form>

    <hr style="margin: 25px 0; border: none; border-top: 1px solid #ddd;">
  </div>
</section>

<footer>
    2025 Hotel
</footer>

</body>
</html>
