<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Rooms</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<h1>Rooms</h1>
<form action="/hotel-booking/rooms/filter" method="get">
    <label>Type:</label>
    <select name="type">
        <option value=""></option>
        <option value="SINGLE">Single</option>
        <option value="DOUBLE">Double</option>
        <option value="FAMILY">Family</option>
    </select>

    <label>Max. price:</label>
    <input type="number" step="0.01" name="maxPrice"/>

    <input type="submit" value="Filter"/>
</form>

<hr/>
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
