<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Add Booking</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f2f2f2; }
        .container { width: 350px; margin: 60px auto; background: #fff; padding: 25px; border-radius: 10px; box-shadow: 0 0 10px #ccc; }
        h2 { text-align: center; }
        form { display: flex; flex-direction: column; gap: 10px; }
        input { padding: 10px; border: 1px solid #ccc; border-radius: 5px; }
        button { background: #007bff; color: white; padding: 10px; border: none; border-radius: 5px; cursor: pointer; }
        button:hover { background: #0056b3; }
        .error { color: red; text-align: center; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/navbar.jsp" />

<div class="container">
    <h2>Add Booking</h2>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/bookings/add" method="post">
        <label>Room Number:</label>
        <input type="number" name="roomNumber" required>

        <label>Start Date:</label>
        <input type="date" name="checkInDate" required>

        <label>End Date:</label>
        <input type="date" name="checkOutDate" required>

        <button type="submit">Book Room</button>
    </form>
</div>
</body>
</html>
