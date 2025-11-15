<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Bookings</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <style>

    </style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/navbar.jsp" />

<div class="bookings-container">
    <div class="bookings-header">
        <h1>
            <c:choose>
                <c:when test="${sessionScope.currentUser.role == 'MANAGER' or sessionScope.currentUser.role == 'ADMIN'}">
                    All Bookings
                </c:when>
                <c:otherwise>
                    My Bookings
                </c:otherwise>
            </c:choose>
        </h1>
        <a href="${pageContext.request.contextPath}/bookings/add" class="booking-filter-btn">New Booking</a>
    </div>

    <c:if test="${not empty bookings}">
        <div class="bookings-list">
            <c:forEach items="${bookings}" var="booking">
                <div class="booking-card">
                    <div class="booking-content">
                        <div class="booking-header">
                            <h3 class="booking-title">Booking #${booking.id}</h3>
                            <span class="booking-status-badge ${booking.status}">${booking.status}</span>
                        </div>

                        <div class="booking-details">
                            <div class="booking-detail-row">
                                <span class="booking-detail-label">Room Number</span>
                                <span class="booking-detail-value">#${booking.roomId}</span>
                            </div>
                            <div class="booking-detail-row">
                                <span class="booking-detail-label">Check-in Date</span>
                                <span class="booking-detail-value">
                                   ${booking.checkInDate}
                                </span>
                            </div>
                            <div class="booking-detail-row">
                                <span class="booking-detail-label">Check-out Date</span>
                                <span class="booking-detail-value">
                                    ${booking.checkOutDate}
                                </span>
                            </div>
                            <div class="booking-detail-row">
                                <span class="booking-detail-label">Total Price</span>
                                <span class="booking-detail-value price">$${booking.totalPrice}</span>
                            </div>
                            <c:if test="${user.role == 'ADMIN' || user.role == 'MANAGER'}">
                                <div class="booking-detail-row">
                                    <span class="booking-detail-label">User ID</span>
                                    <span class="booking-detail-value">${booking.userId}</span>
                                </div>
                            </c:if>
                        </div>

                        <div class="booking-actions">
                            <a href="${pageContext.request.contextPath}/bookings/${booking.id}" class="booking-view-details-btn">
                                View Details
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <c:if test="${empty bookings}">
        <div class="booking-no-bookings-container">
            <div class="booking-no-bookings">
                <h3>No Bookings Found</h3>
                <p>
                    <c:choose>
                        <c:when test="${sessionScope.currentUser.role == 'MANAGER' or sessionScope.currentUser.role == 'ADMIN'}">
                            There are no bookings in the system yet.
                        </c:when>
                        <c:otherwise>
                            You don't have any bookings yet. Start by exploring our available rooms and make your first reservation!
                        </c:otherwise>
                    </c:choose>
                </p>
                <a href="${pageContext.request.contextPath}/rooms" class="booking-filter-btn">Browse Available Rooms</a>
            </div>
        </div>
    </c:if>
</div>

<footer>
    <p>2025 Hotel</p>
</footer>

</body>
</html>