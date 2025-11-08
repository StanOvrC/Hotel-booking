<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <meta charset="UTF-8">
    <title>Hotel Rooms</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>


<form action="${pageContext.request.contextPath}/rooms/filter" method="get">
    <section class="filter-bar">
        <div>
            <label for="type">Room Type:</label>
            <select id="type" name="type">
                <option value="">All</option>
                <option value="SINGLE">Single</option>
                <option value="DOUBLE">Double</option>
                <option value="FAMILY">Family</option>
            </select>
        </div>
        <div>
            <label for="price">Max Price:</label>
            <input type="number" id="price" name="maxPrice" placeholder="e.g. 150">
        </div>
        <button class="learn-btn" type="submit">Filter</button>
    </section>
</form>

<section class="rooms-container">
    <c:forEach var="room" items="${rooms}">
        <div class="room-card">
            <img src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c" alt="${room.type}">
            <div class="room-content">
                <h3>${room.type}</h3>
                <p>${room.description}</p>
                <div class="room-footer">
                    <span class="price">${room.pricePerNight} / night</span>
                    <a href="/hotel-booking/rooms/${room.id}"><button class="learn-btn">Learn More</button></a>
                </div>
            </div>
        </div>
    </c:forEach>
</section>

<footer>
    <p> 2025 Hotel</p>
</footer>

</body>
</html>
