<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Детали пользователя</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<jsp:include page="/WEB-INF/jsp/navbar.jsp" />

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1>Пользователь #${user.id}</h1>
        <a href="${pageContext.request.contextPath}/users" class="btn btn-outline-secondary">Назад к списку</a>
    </div>

    <div class="card shadow-sm mb-4">
        <div class="card-header bg-white">
            <h5 class="mb-0">Информация о пользователе</h5>
        </div>
        <div class="card-body">
            <div class="row mb-3">
                <div class="col-md-4 text-muted">Имя пользователя</div>
                <div class="col-md-8 fw-bold">${user.username}</div>
            </div>
            <div class="row mb-3">
                <div class="col-md-4 text-muted">Email</div>
                <div class="col-md-8">${user.email}</div>
            </div>
            <div class="row mb-3">
                <div class="col-md-4 text-muted">Роль</div>
                <div class="col-md-8">
                     <span class="badge ${user.role == 'ADMIN' ? 'bg-danger' : 'bg-primary'}">${user.role}</span>
                </div>
            </div>

            <div class="d-flex gap-2 mt-4">
                <a href="${pageContext.request.contextPath}/users/edit/${user.id}" class="btn btn-warning">Редактировать</a>
                <form action="${pageContext.request.contextPath}/users/delete/${user.id}" method="post" onsubmit="return confirm('Удалить этого пользователя?');">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    <button type="submit" class="btn btn-outline-danger">Удалить</button>
                </form>
            </div>
        </div>
    </div>

    <h3 class="mt-5 mb-3">Бронирования пользователя</h3>

    <c:if test="${empty user.bookings}">
        <div class="alert alert-info">У этого пользователя нет бронирований.</div>
    </c:if>

    <c:if test="${not empty user.bookings}">
        <div class="card shadow-sm">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-striped table-hover mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th>ID брони</th>
                                <th>ID номера</th>
                                <th>Заезд</th>
                                <th>Выезд</th>
                                <th>Цена</th>
                                <th>Статус</th>
                                <th>Действие</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${user.bookings}" var="b">
                                <tr>
                                    <td>#${b.id}</td>
                                    <td>${b.roomId}</td>
                                    <td>${b.checkInDate}</td>
                                    <td>${b.checkOutDate}</td>
                                    <td>$${b.totalPrice}</td>
                                    <td>
                                        <span class="badge ${b.status == 'CONFIRMED' ? 'bg-success' : b.status == 'CANCELLED' ? 'bg-danger' : 'bg-warning text-dark'}">
                                            ${b.status}
                                        </span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/bookings/${b.id}" class="btn btn-sm btn-primary">Просмотр</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>