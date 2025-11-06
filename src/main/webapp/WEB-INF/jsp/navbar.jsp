<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<nav style="background:#007bff; padding:10px;">
    <a href="${pageContext.request.contextPath}/" style="color:white; margin-right:15px; text-decoration:none;">Home</a>
    <a href="${pageContext.request.contextPath}/rooms" style="color:white; margin-right:15px; text-decoration:none;">Rooms</a>
    <c:if test="${sessionScope.currentUser.role == 'MANAGER' or sessionScope.currentUser.role == 'ADMIN'}">
        <a href="${pageContext.request.contextPath}/rooms/add"
           style="color:white; margin-right:15px; text-decoration:none;">Add Room</a>
    </c:if>

    <c:if test="${not empty sessionScope.currentUser}">
        <a href="${pageContext.request.contextPath}/users/profile"
           style="color:white; margin-right:15px; text-decoration:none;">
            Profile (${sessionScope.currentUser.username})
        </a>
        <a href="${pageContext.request.contextPath}/users/logout"
           style="color:white; text-decoration:none;">Logout</a>
    </c:if>

    <c:if test="${empty sessionScope.currentUser}">
        <a href="${pageContext.request.contextPath}/users/login"
           style="color:white; margin-right:15px; text-decoration:none;">Login</a>
        <a href="${pageContext.request.contextPath}/users/register"
           style="color:white; text-decoration:none;">Register</a>
    </c:if>
    <a href="${pageContext.request.contextPath}/bookings"
   style="color:white; margin-right:15px; text-decoration:none;">Bookings</a>

</nav>
