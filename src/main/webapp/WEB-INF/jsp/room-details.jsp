<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Room Details</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="main-content">
    <div class="room-detail-container">
        <img class="room-image2"
             src="${pageContext.request.contextPath}/images/room-${room.id}.jpg"
             alt="Room ${room.number}"
             onerror="this.src='https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80'"/>

        <div class="room-info">
            <h2>Room № ${room.number}</h2>

            <div class="room-meta">
                <div><span>Type:</span> ${room.type}</div>
                <div><span>Price per night:</span> $${room.pricePerNight}</div>
                <div><span>Status:</span>
                    <c:choose>
                        <c:when test="${room.status == 'AVAILABLE'}">
                            <span class="status available">${room.status}</span>
                        </c:when>
                        <c:when test="${room.status == 'BOOKED'}">
                            <span class="status booked">${room.status}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status unknown">${room.status}</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div><span>Room ID:</span> ${room.id}</div>
            </div>

            <div class="room-description">
                ${room.description}
            </div>

            <div class="room-actions">
                <a href="${pageContext.request.contextPath}/rooms" class="back-link">&larr; Back to Rooms</a>
                <c:if test="${room.status == 'AVAILABLE'}">
                    <a href="${pageContext.request.contextPath}/bookings/add?roomId=${room.id}" class="book-btn">Book This Room</a>
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