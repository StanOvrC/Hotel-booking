<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Add Room</title>
    <style>
        body { font-family: Arial; margin: 40px; }
        form { width: 400px; margin: auto; border: 1px solid #ccc; padding: 20px; border-radius: 8px; }
        label { display: block; margin-top: 10px; font-weight: bold; }
        input, select, textarea { width: 100%; padding: 8px; margin-top: 5px; }
        button { margin-top: 15px; padding: 10px; width: 100%; background-color: #28a745; color: white; border: none; border-radius: 5px; cursor: pointer; }
        button:hover { background-color: #218838; }
        a { display: block; margin-top: 15px; text-align: center; color: #007BFF; text-decoration: none; }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<h2 style="text-align:center;">Add New Room</h2>

<form action="/hotel-booking/rooms/add" method="post">
    <label>Number:</label>
    <input type="text" name="number" required />

    <label>Type:</label>
    <select name="type">
        <option value="SINGLE">Single</option>
        <option value="DOUBLE">Double</option>
        <option value="FAMILY">Family</option>
    </select>

    <label>Price per night:</label>
    <input type="number" step="0.01" name="pricePerNight" required />

    <label>Status:</label>
    <select name="status">
        <option value="AVAILABLE">Available</option>
        <option value="BOOKED">Booked</option>
    </select>

    <label>Description:</label>
    <textarea name="description" rows="4"></textarea>

    <button type="submit">Save</button>
    <a href="/hotel-booking/rooms">← Cancel</a>
</form>
</body>
</html>
