<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>User Details</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>

<jsp:include page="/WEB-INF/jsp/navbar.jsp" />

<div class="user-details-container">

    <!-- HEADER -->
    <div class="user-details-header">
        <h1>User #${user.id}</h1>
        <div class="user-details-actions">
            <a href="${pageContext.request.contextPath}/users" class="user-back-btn">Back to Users</a>
        </div>
    </div>

    <!-- USER INFO CARD -->
    <div class="user-info-card">
        <h2 class="user-info-title">User Information</h2>

        <div class="user-info-grid">

            <div class="user-info-row">
                <span class="user-info-label">Username</span>
                <span class="user-info-value">${user.username}</span>
            </div>

            <div class="user-info-row">
                <span class="user-info-label">Email</span>
                <span class="user-info-value">${user.email}</span>
            </div>

            <div class="user-info-row">
                <span class="user-info-label">Role</span>
                <span class="user-info-value role-${user.role}">${user.role}</span>
            </div>

        </div>

        <div class="user-booking-actions">
            <a href="${pageContext.request.contextPath}/users/edit/${user.id}"
               class="btn-base user-edit-btn">Edit</a>

            <form action="${pageContext.request.contextPath}/users/delete/${user.id}" method="post"
                  class="user-delete-form">
                  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                <button type="submit" class="btn-base user-delete-btn">Delete User</button>
            </form>
        </div>
    </div>


    <!-- BOOKINGS LIST -->
    <div class="user-bookings-section">
        <h2 class="user-bookings-title">User Bookings</h2>

        <c:if test="${empty user.bookings}">
            <div class="user-no-bookings-box">
                <p>This user has no bookings.</p>
            </div>
        </c:if>

        <c:if test="${not empty user.bookings}">
            <div class="user-bookings-list">

                <c:forEach items="${user.bookings}" var="b">

                    <div class="user-booking-card">
                        <div class="user-booking-header">
                            <h3 class="user-booking-title">Booking #${b.id}</h3>
                            <span class="user-booking-status status-${b.status}">
                                ${b.status}
                            </span>
                        </div>

                        <div class="user-booking-grid">

                            <div class="user-booking-row">
                                <span class="user-booking-label">Room</span>
                                <span class="user-booking-value">${b.roomId}</span>
                            </div>

                            <div class="user-booking-row">
                                <span class="user-booking-label">Check-in</span>
                                <span class="user-booking-value">${b.checkInDate}</span>
                            </div>

                            <div class="user-booking-row">
                                <span class="user-booking-label">Check-out</span>
                                <span class="user-booking-value">${b.checkOutDate}</span>
                            </div>

                            <div class="user-booking-row">
                                <span class="user-booking-label">Total Price</span>
                                <span class="user-booking-value">$${b.totalPrice}</span>
                            </div>

                        </div>

                        <div class="user-booking-actions">
                            <a href="${pageContext.request.contextPath}/bookings/${b.id}"
                               class="user-booking-view-btn">View Booking</a>
                        </div>
                    </div>

                </c:forEach>

            </div>
        </c:if>
    </div>

</div>

<footer>
    <p>2025 Hotel</p>
</footer>

</body>
</html>
