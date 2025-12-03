<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Бронирования</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="/WEB-INF/jsp/navbar.jsp" />

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1>
            <c:choose>
                <c:when test="${sessionScope.currentUser.role == 'MANAGER' or sessionScope.currentUser.role == 'ADMIN'}">Все бронирования</c:when>
                <c:otherwise>Мои бронирования</c:otherwise>
            </c:choose>
        </h1>
        <a href="${pageContext.request.contextPath}/bookings/add" class="btn btn-primary">Новое бронирование</a>
    </div>

    <c:if test="${not empty bookings}">
        <div class="card shadow-sm">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-striped table-hover mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th>#</th>
                                <th>Комната</th>
                                <th>Заезд</th>
                                <th>Выезд</th>
                                <th>Цена</th>
                                <th>Статус</th>
                                <th>Действие</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${bookings}" var="booking">
                                <tr>
                                    <td>${booking.id}</td>
                                    <td>${booking.roomId}</td>
                                    <td>${booking.checkInDate}</td>
                                    <td>${booking.checkOutDate}</td>
                                    <td>$${booking.totalPrice}</td>
                                    <td>
                                        <span class="badge ${booking.status == 'CONFIRMED' ? 'bg-success' : booking.status == 'CANCELLED' ? 'bg-danger' : 'bg-warning text-dark'}">
                                            ${booking.status}
                                        </span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/bookings/${booking.id}" class="btn btn-sm btn-outline-primary">Детали</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </c:if>

    <c:if test="${empty bookings}">
        <div class="alert alert-info text-center p-5">
            <h3>Бронирований не найдено</h3>
            <p>Вы еще не совершали бронирований.</p>
            <a href="${pageContext.request.contextPath}/rooms" class="btn btn-primary mt-2">Просмотр номеров</a>
        </div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>