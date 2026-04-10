<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Вход</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5 col-lg-4">
            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <h2 class="text-center mb-4">Вход</h2>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                             Неверное имя пользователя или пароль.
                        </div>
                    </c:if>

                    <c:if test="${param.logout != null}">
                         <div class="alert alert-success">Вы успешно вышли из системы.</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/users/login" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" name="username" class="form-control" placeholder="name@example.com" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Пароль</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Войти</button>
                        </div>
                    </form>

                    <div class="text-center mt-3">
                        <p class="small">Нет аккаунта? <a href="${pageContext.request.contextPath}/users/register">Зарегистрироваться</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>