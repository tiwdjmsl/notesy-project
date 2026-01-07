<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String noteId = request.getParameter("id");
    String title  = request.getParameter("title");
    String amount = request.getParameter("amount");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Checkout | Notesy</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body { background:#f7f7f7; }
        .card { border-radius:18px; }
    </style>
</head>

<body>
<jsp:include page="components/navbar.jsp"/>

<div class="container py-5">

    <div class="card shadow p-4 mx-auto" style="max-width:650px">

        <h3 class="fw-bold text-center">Checkout</h3>
        <p class="text-muted text-center">
            This is a demo payment simulation screen.
        </p>

        <hr>

        <div class="mb-2">
            <b>Item:</b> <%= title != null ? title : "Note Purchase" %>
        </div>

        <div class="mb-3">
            <b>Amount:</b> RM <%= amount != null ? amount : "0.00" %>
        </div>

        <!-- Simulated Payment -->
       <form action="Controller" method="post">

    <input type="hidden" name="page" value="pay">
    <input type="hidden" name="id" value="<%= noteId %>">

    <button class="btn btn-success w-100 fw-bold mb-2">
        ✔ Confirm Payment & Download
    </button>

</form>

        <!-- Cancel -->
        <a href="Controller?page=explore"
           class="btn btn-outline-secondary w-100">
            ✖ Cancel Payment
        </a>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
