<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Booking Details</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f2f2f2; }
        .container { width: 400px; margin: 50px auto; background: #fff; padding: 25px; border-radius: 10px; box-shadow: 0 0 10px #ccc; }
        h2 { text-align: center; }
        .info p { margin: 8px 0; }
        a, button { text-decoration: none; display: inline-block; padding: 8px 12px; margin-top: 10px; border-radius: 5px; }
        .btn-back { background: #007bff; color: white; }
        .btn-cancel { background: #dc3545; color: white; border: none; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/navbar.jsp" />

<div class="container">
    <h2>Booking Details</h2>

    <div class="info">
        <p><strong>ID:</strong> ${booking.id}</p>
        <p><strong>Room ID:</strong> ${booking.roomId}</p>
        <p><strong>User ID:</strong> ${booking.userId}</p>
        <p><strong>Start Date:</strong> ${booking.checkInDate}</p>
        <p><strong>End Date:</strong> ${booking.checkOutDate}</p>
        <p><strong>Status:</strong> ${booking.status}</p>
    </div>

    <form action="${pageContext.request.contextPath}/bookings/cancel" method="post" style="display:inline;">
        <input type="hidden" name="id" value="${booking.id}">
        <button type="submit" class="btn-cancel">Cancel</button>
    </form>

    <a href="${pageContext.request.contextPath}/bookings" class="btn-back">Back</a>
</div>
</body>
</html>
