<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Add Booking</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>

<body>
<jsp:include page="/WEB-INF/jsp/navbar.jsp" />

<div class="booking-container">
    <h2>Book a Room</h2>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <form class="booking-form" action="${pageContext.request.contextPath}/bookings/add" method="post">

        <c:if test="${not empty booking.roomId}">
            <input type="hidden" name="roomId" value="${booking.roomId}">
        </c:if>


        <c:if test="${empty booking.roomId}">
            <label>Room ID:</label>
            <input type="number" name="roomId" placeholder="Enter room ID" required>
        </c:if>

        <label>Check-in date:</label>
        <input type="date" name="checkInDate" required>

        <label>Check-out date:</label>
        <input type="date" name="checkOutDate" required>

        <button type="submit" class="booking-btn">Confirm Booking</button>

        <div class="back-link">
            <a href="${pageContext.request.contextPath}/rooms">&larr; Back to rooms</a>
        </div>
    </form>
</div>
</body>
</html>
