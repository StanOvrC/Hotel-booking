<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Room Details</title>

</head>
<body>
<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="container">
    <h2>Room № ${room.number}</h2>
    <div class="info"><span class="label">Type:</span> ${room.type}</div>
    <div class="info"><span class="label">Price per night:</span> ${room.pricePerNight}</div>
    <div class="info"><span class="label">Status:</span> ${room.status}</div>
    <div class="info"><span class="label">Description:</span> ${room.description}</div>

    <div class="button">
        <a href="/hotel-booking/rooms"><- Back to list</a>
    </div>
</div>
</body>
</html>
