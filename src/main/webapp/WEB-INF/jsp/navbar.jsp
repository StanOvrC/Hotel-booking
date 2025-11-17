<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<header>
    <h1>Hotel</h1>
    <nav>
        <a href="${pageContext.request.contextPath}/rooms">Rooms</a>

        <c:if test="${pageContext.request.isUserInRole('ADMIN') or pageContext.request.isUserInRole('MANAGER')}">
                <a href="${pageContext.request.contextPath}/rooms/add">Add Room</a>
        </c:if>

        <a href="${pageContext.request.contextPath}/bookings">Bookings</a>

        <c:if test="${empty pageContext.request.userPrincipal}">
               <a href="${pageContext.request.contextPath}/users/login">Login</a>
               <a href="${pageContext.request.contextPath}/users/register">Register</a>
        </c:if>

        <c:if test="${not empty pageContext.request.userPrincipal}">
                <a href="${pageContext.request.contextPath}/users/profile">Profile</a>
                <form action="${pageContext.request.contextPath}/logout" method="post" style="display:inline;">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    <button type="submit" >
                        Logout
                    </button>
                </form>
        </c:if>
    </nav>
</header>