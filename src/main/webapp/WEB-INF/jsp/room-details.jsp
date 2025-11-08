<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Room Details</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <style>
        .room-detail-container {
            max-width: 900px;
            margin: 60px auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .room-image {
            width: 100%;
            height: 400px;
            object-fit: cover;
        }

        .room-info {
            padding: 30px 40px;
        }

        .room-info h2 {
            margin-top: 0;
            font-size: 28px;
            color: #222;
        }

        .room-meta {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px 30px;
            margin: 25px 0;
        }

        .room-meta div {
            font-size: 15px;
            color: #555;
        }

        .room-meta span {
            font-weight: 600;
            color: #222;
        }

        .room-description {
            margin-top: 20px;
            color: #666;
            line-height: 1.6;
        }

        .room-actions {
            margin-top: 35px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .back-link {
            color: #0077cc;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s;
        }

        .back-link:hover {
            color: #005fa3;
        }

        .book-btn {
            background: #0077cc;
            color: #fff;
            padding: 12px 22px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.2s;
            text-decoration: none;
        }

        .book-btn:hover {
            background: #005fa3;
        }

        @media (max-width: 700px) {
            .room-meta {
                grid-template-columns: 1fr;
            }
            .room-info {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="room-detail-container">
    <img class="room-image" src="${pageContext.request.contextPath}/images/room-${room.id}.jpg" alt="Room image"
         onerror="this.src='${pageContext.request.contextPath}/images/default-room.jpg'"/>

    <div class="room-info">
        <h2>Room № ${room.number}</h2>

        <div class="room-meta">
            <div><span>Type:</span> ${room.type}</div>
            <div><span>Price per night:</span> $${room.pricePerNight}</div>
            <div><span>Status:</span> ${room.status}</div>
            <div><span>ID:</span> ${room.id}</div>
        </div>

        <div class="room-description">
            ${room.description}
        </div>

        <div class="room-actions">
            <a href="${pageContext.request.contextPath}/rooms" class="back-link">← Back to list</a>
            <a href="${pageContext.request.contextPath}/bookings/add?roomId=${room.id}" class="book-btn">Book this room</a>
        </div>
    </div>
</div>

<footer>
    <p>© 2025 Hotel Booking. All rights reserved.</p>
</footer>

</body>
</html>
