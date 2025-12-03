<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Профиль</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow text-center">
                <div class="card-body p-5">
                    <div class="d-inline-flex align-items-center justify-content-center rounded-circle bg-primary text-white mb-3"
                         style="width: 80px; height: 80px; font-size: 2rem;">
                        ${fn:toUpperCase(fn:substring(user.username, 0, 1))}
                    </div>

                    <h3 class="card-title">${user.username}</h3>
                    <p class="text-muted">${user.email}</p>

                    <ul class="list-group list-group-flush text-start mt-4 mb-4">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            Роль
                            <span class="badge ${user.role == 'ADMIN' ? 'bg-danger' : user.role == 'MANAGER' ? 'bg-warning text-dark' : 'bg-info text-dark'}">
                                ${user.role}
                            </span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            Статус аккаунта
                            <span class="badge bg-success">Активен</span>
                        </li>
                    </ul>

                    <div class="d-grid gap-2">
                         <form action="${pageContext.request.contextPath}/users/logout" method="post">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                            <button type="submit" class="btn btn-danger w-100">Выйти</button>
                        </form>
                        <a href="${pageContext.request.contextPath}/rooms" class="btn btn-outline-secondary">Назад к номерам</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>