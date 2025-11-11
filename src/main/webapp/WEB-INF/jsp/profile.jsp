<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>Profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="main-content">
    <div class="profile-container">
        <div class="profile-card">
            <div class="profile-header">
                <div class="profile-avatar">
                    ${fn:toUpperCase(fn:substring(user.username, 0, 1))}
                </div>
                <h2 class="profile-username">${user.username}</h2>
                <p class="profile-email">${user.email}</p>
            </div>

            <div class="profile-body">
                <div class="profile-info">
                    <div class="info-item">
                        <span class="info-label">Username:</span>
                        <span class="info-value">${user.username}</span>
                    </div>

                    <div class="info-item">
                        <span class="info-label">Email:</span>
                        <span class="info-value">${user.email}</span>
                    </div>

                    <div class="info-item">
                        <span class="info-label">Role:</span>
                        <span class="info-value">
                            <c:choose>
                                <c:when test="${user.role == 'ADMIN'}">
                                    <span class="status-badge" style="background: #0077cc; color: white;">${user.role}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge">${user.role}</span>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>

                    <div class="info-item">
                        <span class="info-label">Status:</span>
                        <span class="info-value">
                            <span class="status-badge">Active</span>
                        </span>
                    </div>
                </div>

                <div class="profile-actions">
                    <form action="${pageContext.request.contextPath}/users/logout" method="post">
                        <button type="submit" class="logout-btn">Logout</button>
                    </form>
                </div>

                <div class="back-link-profile">
                    <a href="${pageContext.request.contextPath}/rooms">&larr; Back to Rooms</a>
                </div>
            </div>
        </div>
    </div>
</div>

<footer>
    <p>2025 Hotel</p>
</footer>

</body>
</html>