<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Login</title>
</head>
<body>

<h2>Login to Notesy</h2>

<form action="LoginServlet" method="post">
    Email: <input type="text" name="email" required><br><br>
    Password: <input type="password" name="password" required><br><br>
    <button type="submit">Login</button>
</form>

<p>Don't have an account? <a href="register.jsp">Create one here</a></p>

<% 
    String message = (String) request.getAttribute("message");
    if (message != null) {
%>
    <p style="color:red;"><%= message %></p>
<% } %>



</body>
</html>

