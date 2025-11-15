<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Room</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<section class="auth-container" style="margin-top: 30px;">
  <div class="auth-card">
    <h2>Edit Room</h2>

    <c:if test="${not empty error}">
      <div class="error-message">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/rooms/edit" method="post">
      <input type="hidden" name="id" value="${room.id}"/>

      <label for="number">Room Number</label>
      <input id="number" type="text" name="number" value="${room.number}" required>

      <label for="type">Room Type</label>
      <select id="type" name="type" required>
        <option value="SINGLE" ${room.type == 'SINGLE' ? 'selected' : ''}>Single</option>
        <option value="DOUBLE" ${room.type == 'DOUBLE' ? 'selected' : ''}>Double</option>
        <option value="FAMILY" ${room.type == 'FAMILY' ? 'selected' : ''}>Family</option>
      </select>

      <label for="price">Price per Night</label>
      <input id="price" type="number" step="0.01" name="pricePerNight" value="${room.pricePerNight}" required>

      <label for="status">Status</label>
      <select id="status" name="status">
        <option value="AVAILABLE" ${room.status == 'AVAILABLE' ? 'selected' : ''}>Available</option>
        <option value="BOOKED" ${room.status == 'BOOKED' ? 'selected' : ''}>Booked</option>
      </select>

      <label for="description">Description</label>
      <textarea id="description" name="description" rows="4" required>${room.description}</textarea>

      <button type="submit" class="auth-btn" style="margin-top: 20px;">Save Changes</button>

      <div class="switch-link">
        <a href="${pageContext.request.contextPath}/rooms">&larr; Back to Rooms</a>
      </div>
    </form>

    <hr style="margin: 25px 0; border: none; border-top: 1px solid #ddd;">

    <form action="${pageContext.request.contextPath}/rooms/delete" method="post"
          onsubmit="return confirm('Are you sure you want to delete this room?');">
      <input type="hidden" name="id" value="${room.id}">
      <button type="submit" class="auth-btn"
              style="background:#c0392b; margin-top:5px;">Delete Room</button>
    </form>

  </div>
</section>

<footer>
    2025 Hotel
</footer>

</body>
</html>
