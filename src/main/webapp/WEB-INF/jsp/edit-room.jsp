<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Редактирование номера</title>
</head>
<body>
<h2>Редактирование номера</h2>

<form action="/hotel-booking/rooms/edit" method="post">
    <input type="hidden" name="id" value="${room.id}"/>

    <label>Номер комнаты:</label>
    <input type="text" name="number" value="${room.number}" required/><br/>

    <label>Тип:</label>
    <select name="type">
        <option value="SINGLE" ${room.type == 'SINGLE' ? 'selected' : ''}>Одноместный</option>
        <option value="DOUBLE" ${room.type == 'DOUBLE' ? 'selected' : ''}>Двухместный</option>
        <option value="FAMILY" ${room.type == 'FAMILY' ? 'selected' : ''}>Семейный</option>
    </select><br/>

    <label>Цена за ночь:</label>
    <input type="number" step="0.01" name="pricePerNight" value="${room.pricePerNight}" required/><br/>

    <label>Статус:</label>
    <select name="status">
        <option value="AVAILABLE" ${room.status == 'AVAILABLE' ? 'selected' : ''}>Доступен</option>
        <option value="BOOKED" ${room.status == 'BOOKED' ? 'selected' : ''}>Забронирован</option>
    </select><br/>

    <label>Описание:</label><br/>
    <textarea name="description" rows="4" cols="50">${room.description}</textarea><br/>

    <input type="submit" value="Сохранить изменения"/>
</form>

<hr/>

<form action="/hotel-booking/rooms/delete" method="post"
      onsubmit="return confirm('Вы уверены, что хотите удалить этот номер?');">
    <input type="hidden" name="id" value="${room.id}"/>
    <input type="submit" value="Удалить номер" style="color:red;"/>
</form>

<br/>
<a href="/hotel-booking/rooms">Назад к списку</a>
</body>
</html>
