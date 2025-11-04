<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Rooms</title>
</head>
<body>
<h1>Rooms</h1>
<table border="1">
    <thead>
        <tr>
            <th>ID</th>
            <th>Number</th>
            <th>Type</th>
            <th>Price per night</th>
            <th>Status</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
    <c:forEach var="room" items="${rooms}">
        <tr>
            <td>${room.id}</td>
            <td>${room.number}</td>
            <td>${room.type}</td>
            <td>${room.pricePerNight}</td>
            <td>${room.status}</td>
            <td>${room.description}</td>
            <td><a href="/hotel-booking/rooms/${room.id}">View details</a></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
