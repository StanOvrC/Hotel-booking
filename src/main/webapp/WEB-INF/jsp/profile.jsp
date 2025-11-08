<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>Profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<section class="auth-container" style="margin-top: 30px;">
  <div class="auth-card" style="max-width: 450px;">
    <h2>Your Profile</h2>

    <div style="text-align: center; margin-top: 15px; margin-bottom: 25px;">
      <div style="
        width: 90px; height: 90px;
        background: #0077cc;
        color: white;
        font-size: 36px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 10px auto;
      ">
        ${fn:substring(user.username, 0, 1)}
      </div>
      <h3 style="margin: 5px 0; color: #222;">${user.username}</h3>
      <p style="color: #777; margin: 0;">${user.email}</p>
    </div>

    <div style="border-top: 1px solid #eee; margin-bottom: 25px;"></div>

    <div style="display: flex; flex-direction: column; gap: 8px;">
      <p><strong>Role:</strong> ${user.role}</p>
      <p><strong>Status:</strong> Active</p>
    </div>

    <form action="${pageContext.request.contextPath}/users/logout" style="margin-top: 25px;">
      <button type="submit" class="auth-btn" style="background: #c0392b;">Logout</button>
    </form>

    <div class="switch-link" style="margin-top: 20px;">
      <a href="${pageContext.request.contextPath}/rooms"><- Back to Rooms</a>
    </div>
  </div>
</section>

<footer>
  2025 Hotel
</footer>

</body>
</html>
