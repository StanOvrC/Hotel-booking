<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Ошибка</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
<jsp:include page="navbar.jsp"/>

<div class="container d-flex flex-column align-items-center justify-content-center flex-grow-1">
    <div class="text-center">
        <h1 class="display-1 fw-bold text-danger">Ой!</h1>
        <h2 class="mb-4">Что-то пошло не так.</h2>
        <p class="lead mb-4">Произошла непредвиденная ошибка.</p>
        <a href="${pageContext.request.contextPath}/rooms" class="btn btn-primary btn-lg">На главную</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>