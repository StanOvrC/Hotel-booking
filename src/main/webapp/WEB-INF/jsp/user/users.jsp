<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Users</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>

<jsp:include page="/WEB-INF/jsp/navbar.jsp" />

<div class="users-container">
    <div class="users-header">
        <h1>Users</h1>
        <a href="${pageContext.request.contextPath}/users/add" class="user-add-btn">Add User</a>
    </div>

    <c:if test="${not empty users}">
        <div class="users-list">
            <c:forEach items="${users}" var="u">
                <div class="user-card">
                    <div class="user-header">
                        <h3 class="user-title">${u.username}</h3>
                        <span class="user-role-badge ${u.role}">${u.role}</span>
                    </div>

                    <div class="user-details">
                        <div class="user-detail-row">
                            <span class="user-detail-label">ID</span>
                            <span class="user-detail-value">${u.id}</span>
                        </div>

                        <div class="user-detail-row">
                            <span class="user-detail-label">Email</span>
                            <span class="user-detail-value">${u.email}</span>
                        </div>

                        <div class="user-detail-row">
                            <span class="user-detail-label">Role</span>
                            <span class="user-detail-value">${u.role}</span>
                        </div>

                        <div class="user-detail-row">
                            <span class="user-detail-label">Bookings</span>
                            <span class="user-detail-value">${u.username}</span>
                        </div>
                    </div>

                    <div class="user-actions">
                        <a href="${pageContext.request.contextPath}/users/${u.id}" class="user-view-btn">View</a>

                        <a href="${pageContext.request.contextPath}/users/${u.id}/edit" class="user-edit-btn">Edit</a>

                        <form action="${pageContext.request.contextPath}/users/${u.id}/delete"
                              method="post" class="user-action-form">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                            <button type="submit" class="user-delete-btn">Delete</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <c:if test="${empty users}">
        <div class="users-no-container">
            <div class="users-no">
                <h3>No Users Found</h3>
                <p>There are no users in the system yet.</p>
                <a href="${pageContext.request.contextPath}/users/add" class="user-add-btn">Add User</a>
            </div>
        </div>
    </c:if>
</div>

<footer>
    <p>2025 Hotel</p>
</footer>

</body>
</html>
