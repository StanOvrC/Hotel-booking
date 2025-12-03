<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Редактировать номер</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-header bg-warning text-dark">
                    <h4 class="mb-0">Редактировать номер</h4>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/rooms/edit" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        <input type="hidden" name="id" value="${room.id}"/>

                        <div class="mb-3">
                            <label class="form-label">Номер комнаты</label>
                            <input type="text" name="number" class="form-control" value="${room.number}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Тип номера</label>
                            <select name="type" class="form-select" required>
                                <option value="SINGLE" ${room.type == 'SINGLE' ? 'selected' : ''}>Одноместный</option>
                                <option value="DOUBLE" ${room.type == 'DOUBLE' ? 'selected' : ''}>Двухместный</option>
                                <option value="FAMILY" ${room.type == 'FAMILY' ? 'selected' : ''}>Семейный</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Цена за ночь</label>
                            <div class="input-group">
                                <span class="input-group-text">$</span>
                                <input type="number" step="0.01" name="pricePerNight" class="form-control" value="${room.pricePerNight}" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Статус</label>
                            <select name="status" class="form-select">
                                <option value="AVAILABLE" ${room.status == 'AVAILABLE' ? 'selected' : ''}>Доступен</option>
                                <option value="BOOKED" ${room.status == 'BOOKED' ? 'selected' : ''}>Занят</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Описание</label>
                            <textarea name="description" class="form-control" rows="4" required>${room.description}</textarea>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">Сохранить изменения</button>
                            <a href="${pageContext.request.contextPath}/rooms" class="btn btn-outline-secondary">Назад к номерам</a>
                        </div>
                    </form>

                    <hr class="my-4">

                    <form action="${pageContext.request.contextPath}/rooms/delete" method="post"
                          onsubmit="return confirm('Вы уверены, что хотите удалить этот номер?');">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        <input type="hidden" name="id" value="${room.id}">
                        <div class="d-grid">
                             <button type="submit" class="btn btn-outline-danger">Удалить номер</button>
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