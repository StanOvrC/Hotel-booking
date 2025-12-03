<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Забронировать номер</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="/WEB-INF/jsp/navbar.jsp" />

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">Подтверждение бронирования</h4>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/bookings/add" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                        <c:if test="${not empty booking.roomId}">
                            <input type="hidden" name="roomId" value="${booking.roomId}">
                            <div class="mb-3">
                                <label class="form-label">ID номера</label>
                                <input type="text" class="form-control" value="${booking.roomId}" disabled>
                            </div>
                        </c:if>

                        <c:if test="${empty booking.roomId}">
                            <div class="mb-3">
                                <label class="form-label">ID номера</label>
                                <input type="number" name="roomId" class="form-control" placeholder="Введите ID номера" required>
                            </div>
                        </c:if>

                        <div class="mb-3">
                            <label class="form-label">Дата заезда</label>
                            <input type="date" name="checkInDate" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Дата выезда</label>
                            <input type="date" name="checkOutDate" class="form-control" required>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">Подтвердить бронирование</button>
                            <a href="${pageContext.request.contextPath}/rooms" class="btn btn-link text-decoration-none text-center">Отмена</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>