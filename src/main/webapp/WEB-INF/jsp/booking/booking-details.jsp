<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Booking Details</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<jsp:include page="/WEB-INF/jsp/navbar.jsp" />

<div class="main-content">
<div class="booking-details-container">

    <div class="booking-card">
        <div class="booking-header">
            <h1 class="booking-title">Booking #${booking.id}</h1>
            <span class="status-badge ${booking.status}">${booking.status}</span>
        </div>

        <div class="booking-info">
            <!-- Booking Details Section -->
            <div class="booking-info-section">
                <h3>Booking Information</h3>
                <div>
                    <span class="booking-info-label">Booking ID</span>
                    <span class="booking-info-value">#${booking.id}</span>
                </div>
                <div>
                    <span class="booking-info-label">Room Number</span>
                    <span class="booking-info-value">#${booking.roomNumber}</span>
                </div>
                <div>
                    <span class="booking-info-label">Total Price</span>
                    <span class="booking-info-value price">$${booking.totalPrice}</span>
                </div>
                <div>
                    <span class="booking-info-label">Status</span>
                    <span class="booking-info-value">${booking.status}</span>
                </div>
            </div>

            <!-- Dates Section -->
            <div class="booking-info-section">
                <h3>Stay Dates</h3>
                <div>
                    <span class="booking-info-label">Check-in Date</span>
                    <span class="booking-info-value">
                        ${booking.checkInDate}
                    </span>
                </div>
                <div>
                    <span class="booking-info-label">Check-out Date</span>
                    <span class="booking-info-value">
                        ${booking.checkOutDate}
                    </span>
                </div>
            </div>

            <c:if test="${sessionScope.currentUser.role == 'MANAGER' or sessionScope.currentUser.role == 'ADMIN'}">
                <div class="booking-info-section">
                    <h3>User Information</h3>
                    <div>
                        <span class="booking-info-label">User ID</span>
                        <span class="booking-info-value">${booking.userId}</span>
                    </div>
                    <div>
                        <span class="booking-info-label">Booked By</span>
                        <span class="booking-info-value">
                            <c:choose>
                                <c:when test="${booking.userId == user.id}">You</c:when>
                                <c:otherwise>User #${booking.userId}</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
            </c:if>
        </div>

        <div class="booking-actions">
            <a href="${pageContext.request.contextPath}/bookings" class="booking-btn booking-btn-back">
                &larr; Back to Bookings
            </a>

            <c:if test="${booking.status == 'PENDING' || booking.status == 'CONFIRMED'}">
                <form action="${pageContext.request.contextPath}/bookings/cancel" method="post" class="booking-action-form">
                    <input type="hidden" name="id" value="${booking.id}">
                    <button type="submit" class="booking-btn booking-btn-cancel"
                            onclick="return confirm('Are you sure you want to cancel this booking? This action cannot be undone.')">
                        Cancel Booking
                    </button>
                </form>
            </c:if>

            <!-- Approve Button (only for admins on pending bookings) -->
            <c:if test="${booking.status == 'PENDING' && (sessionScope.currentUser.role == 'MANAGER' or sessionScope.currentUser.role == 'ADMIN')}">
                <form action="${pageContext.request.contextPath}/bookings/approve" method="post" class="booking-action-form">
                    <input type="hidden" name="id" value="${booking.id}">
                    <button type="submit" class="booking-btn booking-btn-approve">
                        Approve Booking
                    </button>
                </form>
            </c:if>
        </div>
    </div>
</div>
</div>

<footer>
    <p>2025 Hotel</p>
</footer>

</body>
</html>