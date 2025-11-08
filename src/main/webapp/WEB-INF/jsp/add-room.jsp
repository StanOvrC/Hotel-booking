<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Room</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<section class="auth-container" style="margin-top: 30px;">
  <div class="auth-card" >
    <h2>Add New Room</h2>

    <c:if test="${not empty error}">
      <div class="error-message">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/rooms/add" method="post">
      <label for="number">Room Number</label>
      <input id="number" type="text" name="number" placeholder="e.g. 101" required>

      <label for="type">Room Type</label>
      <select id="type" name="type" required>
        <option value="">Select type...</option>
        <option value="SINGLE">Single</option>
        <option value="DOUBLE">Double</option>
        <option value="FAMILY">Family</option>
      </select>

      <label for="price">Price per Night</label>
      <input id="price" type="number" step="0.01" name="pricePerNight" placeholder="e.g. 89.99" required>

      <label for="status">Status</label>
      <select id="status" name="status">
        <option value="AVAILABLE">Available</option>
        <option value="BOOKED">Booked</option>
      </select>

      <label for="description">Description</label>
      <textarea id="description" name="description" rows="4" placeholder="Describe the room..." required></textarea>

      <button type="submit" class="auth-btn" style="margin-top: 20px;">Save Room</button>

      <div class="switch-link">
        <a href="${pageContext.request.contextPath}/rooms">← Back to Rooms</a>
      </div>
    </form>
  </div>
</section>

<footer>
    2025 Hotel
</footer>

</body>
</html>
