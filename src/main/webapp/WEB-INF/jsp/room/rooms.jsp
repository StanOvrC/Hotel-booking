<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Номера отеля</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .card-img-top {
            height: 250px; /* Фиксированная высота */
            object-fit: cover; /* Картинка обрежется, но не растянется */
        }
    </style>
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="container">
    <div class="card mb-4 shadow-sm">
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/rooms/filter" method="get" class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label for="type" class="form-label">Тип номера</label>
                    <select id="type" name="type" class="form-select">
                        <option value="">Все типы</option>
                        <option value="SINGLE">Одноместный</option>
                        <option value="DOUBLE">Двухместный</option>
                        <option value="FAMILY">Семейный люкс</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label for="price" class="form-label">Макс. цена за ночь</label>
                    <input type="number" id="price" name="maxPrice" class="form-control" placeholder="Макс. цена" min="0">
                </div>
                <div class="col-md-4">
                    <button class="btn btn-primary me-2" type="submit">Применить</button>
                    <a href="${pageContext.request.contextPath}/rooms" class="btn btn-secondary">Сброс</a>
                </div>
            </form>
        </div>
    </div>

    <div class="row row-cols-1 row-cols-md-3 g-4">
        <c:forEach var="room" items="${rooms}">
            <div class="col">
                <div class="card h-100 shadow-sm">
                    <img src="${pageContext.request.contextPath}/images/${room.type}.jpg"
                         class="card-img-top"
                         alt="${room.type}"
                         onerror="this.src='https://placehold.co/600x400?text=No+Image'">

                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h5 class="card-title mb-0">
                                <c:choose>
                                    <c:when test="${room.type == 'SINGLE'}">Одноместный</c:when>
                                    <c:when test="${room.type == 'DOUBLE'}">Двухместный</c:when>
                                    <c:when test="${room.type == 'FAMILY'}">Семейный</c:when>
                                    <c:otherwise>${room.type}</c:otherwise>
                                </c:choose>
                            </h5>
                            <span class="badge ${room.status == 'AVAILABLE' ? 'bg-success' : 'bg-secondary'}">
                                ${room.status}
                            </span>
                        </div>
                        <h6 class="card-subtitle mb-2 text-muted">Номер №${room.number}</h6>
                        <p class="card-text text-truncate">${room.description}</p>
                    </div>
                    <div class="card-footer bg-white border-top-0 d-flex justify-content-between align-items-center">
                        <h5 class="text-primary mb-0">$${room.pricePerNight} <small class="text-muted fs-6">/ ночь</small></h5>
                        <a href="${pageContext.request.contextPath}/rooms/${room.id}" class="btn btn-outline-primary btn-sm">Подробнее</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <c:if test="${empty rooms}">
        <div class="alert alert-info text-center mt-4" role="alert">
            Номера по вашему запросу не найдены. <a href="${pageContext.request.contextPath}/rooms" class="alert-link">Показать все номера</a>.
        </div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>