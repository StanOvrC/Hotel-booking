<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<header>
    <h1>Hotel</h1>
    <nav>
        <a href="${pageContext.request.contextPath}/rooms">Rooms</a>

        <c:if test="${sessionScope.currentUser.role == 'MANAGER' or sessionScope.currentUser.role == 'ADMIN'}">
                <a href="${pageContext.request.contextPath}/rooms/add">Add Room</a>
        </c:if>

        <a href="${pageContext.request.contextPath}/bookings">Bookings</a>

        <c:if test="${empty sessionScope.currentUser}">
               <a href="${pageContext.request.contextPath}/users/login">Login</a>
               <a href="${pageContext.request.contextPath}/users/register">Register</a>
        </c:if>

        <c:if test="${not empty sessionScope.currentUser}">
                <a href="${pageContext.request.contextPath}/users/profile">Profile (${sessionScope.currentUser.username})</a>
                <a href="${pageContext.request.contextPath}/users/logout">Logout</a>
        </c:if>
    </nav>
</header>