<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm py-3 mb-4">
    <div class="container">

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 fw-semibold">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/rooms">Номера</a>
                </li>
                <c:if test="${pageContext.request.isUserInRole('ADMIN') or pageContext.request.isUserInRole('MANAGER')}">
                    <li class="nav-item">
                        <a class="nav-link text-success" href="${pageContext.request.contextPath}/rooms/add">+ Добавить номер</a>
                    </li>
                </c:if>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/bookings">Бронирования</a>
                </li>
                <c:if test="${pageContext.request.isUserInRole('ADMIN') or pageContext.request.isUserInRole('MANAGER')}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/users">Пользователи</a>
                    </li>
                </c:if>
            </ul>
            <ul class="navbar-nav align-items-center">
                <c:if test="${empty pageContext.request.userPrincipal}">
                    <li class="nav-item"><a class="nav-link me-2" href="${pageContext.request.contextPath}/users/login">Войти</a></li>
                    <li class="nav-item"><a class="btn btn-primary px-4 rounded-pill" href="${pageContext.request.contextPath}/users/register">Регистрация</a></li>
                </c:if>
                <c:if test="${not empty pageContext.request.userPrincipal}">
                    <li class="nav-item"><a class="nav-link fw-bold text-dark me-2" href="${pageContext.request.contextPath}/users/profile">Профиль</a></li>
                    <li class="nav-item">
                        <form action="${pageContext.request.contextPath}/logout" method="post" class="d-inline">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                            <button type="submit" class="btn btn-outline-danger btn-sm rounded-pill px-3">Выйти</button>
                        </form>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>