<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Notesy</title>
</head>
<body>

<h2>Create Your Notesy Account</h2>

<form action="RegisterServlet" method="post">
    <label>Fullname:</label><br>
    <input type="fullname" name="fullname" required><br><br>
    
    <label>Email:</label><br>
    <input type="email" name="email" required><br><br>

    <label>Password:</label><br>
    <input type="password" name="password" required><br><br>

    <button type="submit">Register</button>
</form>

<%
    String msg = request.getParameter("msg");
    if("exists".equals(msg)){
%>
        <p style="color:red;">Email already registered.</p>
<%
    } else if("success".equals(msg)){
%>
        <p style="color:green;">Registration successful! Please login.</p>
<%
    }
%>

<p>Already have an account? <a href="login.jsp">Login here</a></p>

</body>
</html>
