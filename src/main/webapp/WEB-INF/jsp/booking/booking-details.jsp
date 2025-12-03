<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Детали бронирования</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="/WEB-INF/jsp/navbar.jsp" />

<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
            <h4 class="mb-0">Бронирование №${booking.id}</h4>
            <span class="badge ${booking.status == 'CONFIRMED' ? 'bg-success' : booking.status == 'CANCELLED' ? 'bg-danger' : 'bg-warning text-dark'} fs-6">
                ${booking.status}
            </span>
        </div>
        <div class="card-body p-4">
            <div class="row g-4">
                <div class="col-md-6">
                    <h5 class="text-primary border-bottom pb-2">Информация о бронировании</h5>
                    <dl class="row mb-0">
                        <dt class="col-sm-4 text-muted">Номер комнаты</dt>
                        <dd class="col-sm-8 fw-bold">№${booking.roomNumber}</dd>

                        <dt class="col-sm-4 text-muted">Итоговая цена</dt>
                        <dd class="col-sm-8 text-success fw-bold fs-5">$${booking.totalPrice}</dd>

                        <c:if test="${pageContext.request.isUserInRole('ADMIN') or pageContext.request.isUserInRole('MANAGER')}">
                            <dt class="col-sm-4 text-muted">ID пользователя</dt>
                            <dd class="col-sm-8">${booking.userId}</dd>

                            <dt class="col-sm-4 text-muted">Кем забронировано</dt>
                            <dd class="col-sm-8">
                                <c:choose>
                                    <c:when test="${booking.userId == user.id}">Вами</c:when>
                                    <c:otherwise>Пользователь №${booking.userId}</c:otherwise>
                                </c:choose>
                            </dd>
                        </c:if>
                    </dl>
                </div>

                <div class="col-md-6">
                    <h5 class="text-primary border-bottom pb-2">Даты пребывания</h5>
                    <div class="p-3 bg-light rounded">
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Заезд:</span>
                            <span class="fw-bold">${booking.checkInDate}</span>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span class="text-muted">Выезд:</span>
                            <span class="fw-bold">${booking.checkOutDate}</span>
                        </div>
                    </div>
                </div>
            </div>

            <hr class="my-4">

            <div class="d-flex gap-2 justify-content-end">
                <a href="${pageContext.request.contextPath}/bookings" class="btn btn-outline-secondary">
                    &larr; Назад к бронированиям
                </a>

                <c:if test="${booking.status == 'PENDING' || booking.status == 'CONFIRMED'}">
                    <form action="${pageContext.request.contextPath}/bookings/cancel" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        <input type="hidden" name="id" value="${booking.id}">
                        <button type="submit" class="btn btn-danger"
                                onclick="return confirm('Вы уверены, что хотите отменить это бронирование?')">
                            Отменить бронирование
                        </button>
                    </form>
                </c:if>

                <c:if test="${booking.status == 'PENDING' && (pageContext.request.isUserInRole('ADMIN') or pageContext.request.isUserInRole('MANAGER'))}">
                    <form action="${pageContext.request.contextPath}/bookings/approve" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        <input type="hidden" name="id" value="${booking.id}">
                        <button type="submit" class="btn btn-success">
                            Подтвердить бронирование
                        </button>
                    </form>
                </c:if>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>