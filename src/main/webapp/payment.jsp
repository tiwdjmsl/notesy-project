<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.notesy.beans.Note" %>

<%
    Note note = (Note) request.getAttribute("note");
%>



<!DOCTYPE html>
<html>
<head>
    <title>Payment | Notesy</title>

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

        <h3 class="fw-bold mb-3">Confirm Purchase</h3>
        <p class="text-muted">Review the note details before proceeding.</p>
        <hr>

        <% if (note == null) { %>

            <p class="text-danger">⚠ Invalid or missing note information.</p>

        <% } else { %>

            <div class="mb-3">
                <b>Title:</b> <%= note.getTitle() %><br>
                <b>Category:</b> <%= note.getCategory() %><br>
                <b>Price:</b> RM <%= note.getPrice() %>
            </div>

            <form action="fakecheckout.jsp" method="post">

                <input type="hidden" name="id" value="<%= note.getNoteId() %>">

                <button class="btn btn-warning w-100">
                    Proceed to Checkout →
                </button>
            </form>

            <a href="Controller?page=explore"
               class="btn btn-outline-secondary mt-3 w-100">
                Cancel
            </a>

        <% } %>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
