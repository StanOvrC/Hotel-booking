<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Добавить новый номер</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow-sm">
                <div class="card-header bg-success text-white">
                    <h4 class="mb-0">Добавить новый номер</h4>
                </div>
                <div class="card-body p-4">

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            ${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/rooms/add" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                        <div class="mb-3">
                            <label for="number" class="form-label">Номер комнаты</label>
                            <input id="number" type="text" name="number" class="form-control" placeholder="например, 101" required>
                        </div>

                        <div class="mb-3">
                            <label for="type" class="form-label">Тип номера</label>
                            <select id="type" name="type" class="form-select" required>
                                <option value="" disabled selected>Выберите тип...</option>
                                <option value="SINGLE">Одноместный</option>
                                <option value="DOUBLE">Двухместный</option>
                                <option value="FAMILY">Семейный</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="price" class="form-label">Цена за ночь</label>
                            <div class="input-group">
                                <span class="input-group-text">$</span>
                                <input id="price" type="number" step="0.01" name="pricePerNight" class="form-control" placeholder="например, 89.99" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="status" class="form-label">Статус</label>
                            <select id="status" name="status" class="form-select">
                                <option value="AVAILABLE" selected>Доступен</option>
                                <option value="BOOKED">Занят</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="description" class="form-label">Описание</label>
                            <textarea id="description" name="description" class="form-control" rows="4" placeholder="Описание номера..." required></textarea>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-success">Сохранить номер</button>
                            <a href="${pageContext.request.contextPath}/rooms" class="btn btn-outline-secondary">Назад к номерам</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>