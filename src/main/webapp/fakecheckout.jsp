<%@ page contentType="text/html;charset=UTF-8" %>

<%
String noteId = request.getParameter("noteId");
String amount = request.getParameter("amount");
String title  = request.getParameter("title");
%>

<!DOCTYPE html>
<html>
<head>
<title>Secure Payment Gateway</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

<div class="bg-white p-4 rounded-4 shadow-sm mx-auto" style="max-width:650px">

<h4 class="fw-bold mb-3 text-center">Checkout</h4>

<p class="text-muted text-center">
This is a simulated payment screen for demo purposes.
</p>

<hr>

<p><strong>Item:</strong> <%= title %></p>
<p><strong>Amount:</strong> RM <%= amount %></p>

<form action="Controller" method="post">

    <input type="hidden" name="action" value="pay">
    <input type="hidden" name="noteId" value="<%= noteId %>">
    <input type="hidden" name="amount" value="<%= amount %>">
    <input type="hidden" name="method" value="FPX / TNG">

    <button class="btn btn-success w-100 fw-bold mb-2">
        ✔ Confirm Payment
    </button>

</form>

<a href="payment.jsp?noteId=<%= noteId %>" class="btn btn-outline-secondary w-100">
    ✖ Cancel Payment
</a>

</div>

</div>

</body>
</html>
