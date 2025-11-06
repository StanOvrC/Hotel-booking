<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Bookings</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { width: 80%; margin: 40px auto; background: #fff; padding: 20px; border-radius: 10px; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: center; }
        th { background-color: #007bff; color: white; }
        a, button { text-decoration: none; padding: 6px 10px; border-radius: 4px; }
        .btn-view { background: #28a745; color: white; }
        .btn-cancel { background: #dc3545; color: white; border: none; cursor: pointer; }
        .btn-add { display: inline-block; margin-bottom: 15px; background: #007bff; color: white; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/navbar.jsp" />

<div class="container">
    <h2>Bookings</h2>

    <c:if test="${not empty sessionScope.currentUser}">
        <a href="${pageContext.request.contextPath}/bookings/add" class="btn-add">Add Booking</a>
    </c:if>

    <c:if test="${empty bookings}">
        <p>No bookings found.</p>
    </c:if>

    <c:if test="${not empty bookings}">
        <table>
            <tr>
                <th>ID</th>
                <th>Room ID</th>
                <th>User ID</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            <c:forEach var="b" items="${bookings}">
                <tr>
                    <td>${b.id}</td>
                    <td>${b.roomId}</td>
                    <td>${b.userId}</td>
                    <td>${b.checkInDate}</td>
                    <td>${b.checkOutDate}</td>
                    <td>${b.status}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/bookings/${b.id}" class="btn-view">View</a>

                        <form action="${pageContext.request.contextPath}/bookings/cancel" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="${b.id}">
                            <button type="submit" class="btn-cancel">Cancel</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
</div>
</body>
</html>
