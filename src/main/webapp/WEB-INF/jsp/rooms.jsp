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

<div class="main-content">
    <!-- Filter Section -->
    <form action="${pageContext.request.contextPath}/rooms/filter" method="get">
        <section class="filter-section">
            <div class="filter-bar">
                <div class="filter-group">
                    <label for="type">Room Type</label>
                    <select id="type" name="type">
                        <option value="">All Room Types</option>
                        <option value="SINGLE">Single Room</option>
                        <option value="DOUBLE">Double Room</option>
                        <option value="FAMILY">Family Suite</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label for="price">Max Price Per Night</label>
                    <input type="number" id="price" name="maxPrice" placeholder="Enter max price" min="0">
                </div>

                <div class="filter-actions">
                    <button class="filter-btn" type="submit">Apply Filters</button>
                    <a href="${pageContext.request.contextPath}/rooms" class="reset-btn">Reset</a>
                </div>
            </div>
        </section>
    </form>



    <!-- Rooms Grid -->
    <section class="rooms-container">
        <c:forEach var="room" items="${rooms}">
            <div class="room-card">
                <!-- Status Badge -->
                <c:if test="${room.status != 'AVAILABLE'}">
                    <div class="room-badge ${room.status == 'BOOKED' ? 'booked' : 'booked'}">
                        ${room.status}
                    </div>
                </c:if>

                <!-- Room Image -->
                <img class="room-image"
                     src="https://images.unsplash.com/photo-1611892440504-42a792e24d32?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80"
                     alt="${room.type} Room">

                <div class="room-content">
                    <!-- Room Header -->
                    <div class="room-header">
                        <h3 class="room-type">${room.type} Room</h3>
                        <span class="room-number">#${room.number}</span>
                    </div>

                    <!-- Room Description -->
                    <p class="room-description">${room.description}</p>

                    <!-- Room Footer -->
                    <div class="room-footer">
                        <div class="price">
                            $${room.pricePerNight}<span class="price-period">/night</span>
                        </div>
                        <a href="${pageContext.request.contextPath}/rooms/${room.id}" class="view-details-btn">
                            View Details
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>

        <!-- No Results State - FIXED CENTERING -->
        <c:if test="${empty rooms}">
            <div class="no-rooms-container">
                <div class="no-rooms">
                    <h3>No Rooms Available</h3>
                    <p>We couldn't find any rooms matching your search criteria.</p>
                    <a href="${pageContext.request.contextPath}/rooms" class="view-details-btn">
                        View All Rooms
                    </a>
                </div>
            </div>
        </c:if>
    </section>
</div>

<footer>
    <p>2025 Hotel</p>
</footer>

</body>
</html>