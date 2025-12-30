<%
    String activeForm = (String) session.getAttribute("active_form");
    if (activeForm == null) activeForm = "login";
%>

<% if ("register".equals(activeForm)) { %>
    <h2>Register</h2>
<% } else { %>
    <h2>Login</h2>
<% } %>

<form action="auth" method="post">
    <h3>Register</h3>
    <input name="user_id" placeholder="User ID" required>
    <input name="fullname" placeholder="Full Name" required>
    <input name="email" type="email" placeholder="Email" required>
    <input name="phone_number" placeholder="Phone Number">
    <input name="password" type="password" placeholder="Password" required>
    <button type="submit" name="register">Register</button>
    <p class="text-danger">${sessionScope.register_error}</p>
</form>

<hr>

<form action="auth" method="post">
    <h3>Login</h3>
    <input name="user_id" placeholder="User ID" required>
    <input name="password" type="password" placeholder="Password" required>
    <button type="submit" name="login">Login</button>
    <p class="text-danger">${sessionScope.login_error}</p>
</form>
