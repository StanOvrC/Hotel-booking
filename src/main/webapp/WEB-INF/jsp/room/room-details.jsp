<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Детали номера</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="container mt-4">
    <div class="card shadow">
        <div class="row g-0">
            <div class="col-md-6">
                 <img src="${pageContext.request.contextPath}/images/${room.type}.jpg"
                      class="img-fluid rounded-start h-100 object-fit-cover"
                      alt="Фото номера"
                      style="min-height: 400px;"
                      onerror="this.src='https://placehold.co/800x600?text=No+Image'">
            </div>
            <div class="col-md-6">
                <div class="card-body p-4">
                    <div class="d-flex justify-content-between align-items-start">
                        <h2 class="card-title">Номер №${room.number}</h2>
                        <span class="badge ${room.status == 'AVAILABLE' ? 'bg-success' : 'bg-secondary'} fs-6">
                            ${room.status}
                        </span>
                    </div>
                    <hr>
                    <p class="card-text"><strong>Тип:</strong>
                        <c:choose>
                            <c:when test="${room.type == 'SINGLE'}">Одноместный</c:when>
                            <c:when test="${room.type == 'DOUBLE'}">Двухместный</c:when>
                            <c:when test="${room.type == 'FAMILY'}">Семейный</c:when>
                            <c:otherwise>${room.type}</c:otherwise>
                        </c:choose>
                    </p>
                    <p class="card-text"><strong>Цена:</strong> <span class="text-primary fs-4 fw-bold">$${room.pricePerNight}</span> / ночь</p>
                    <p class="card-text"><strong>Описание:</strong><br>${room.description}</p>
                    <p class="text-muted small">Внутренний ID: ${room.id}</p>

                    <div class="d-grid gap-2 d-md-block mt-4">
                        <a href="${pageContext.request.contextPath}/rooms" class="btn btn-outline-secondary">← Назад</a>

                        <c:if test="${room.status == 'AVAILABLE'}">
                            <a href="${pageContext.request.contextPath}/bookings/add?roomId=${room.id}" class="btn btn-success">Забронировать</a>
                        </c:if>

                        <c:if test="${pageContext.request.isUserInRole('ADMIN') or pageContext.request.isUserInRole('MANAGER')}">
                             <a href="${pageContext.request.contextPath}/rooms/edit/${room.id}" class="btn btn-warning">Редактировать</a>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>