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
        .method-box:hover { border-color:#0d6efd; cursor:pointer; }
    </style>
</head>

<body>

<jsp:include page="components/navbar.jsp"/>

<div class="container py-5">

    <div class="card shadow p-4 mx-auto" style="max-width:650px">

        <h3 class="fw-bold mb-2">Confirm Purchase</h3>
        <p class="text-muted">Review the note details and choose a payment method.</p>
        <hr>

        <% if (note == null) { %>

            <p class="text-danger fw-bold">
                ⚠ Invalid or missing note information.
            </p>

            <a href="Controller?page=explore"
               class="btn btn-secondary w-100 mt-2">
                Back to Explore
            </a>

        <% } else { %>

            <!-- NOTE DETAILS -->
            <div class="mb-3">
                <b>Title:</b> <%= note.getTitle() %><br>
                <b>Category:</b> <%= note.getCategory() %><br>
                <b>Price:</b> RM <%= note.getPrice() %>
            </div>

            <!-- DEMO PAYMENT METHOD -->
            <h6 class="fw-bold mt-2 mb-2">Select Payment Method (Demo)</h6>

            <form action="fakecheckout.jsp" method="post">

                <input type="hidden" name="id" value="<%= note.getNoteId() %>">
                <input type="hidden" name="title" value="<%= note.getTitle() %>">
                <input type="hidden" name="amount" value="<%= note.getPrice() %>">

                <div class="card p-3 mb-3">

                    <label class="method-box border rounded p-2 d-flex align-items-center mb-2">
                        <input type="radio" name="method" value="FPX Online Banking" checked>
                        <span class="ms-2">FPX Online Banking</span>
                    </label>

                    <label class="method-box border rounded p-2 d-flex align-items-center mb-2">
                        <input type="radio" name="method" value="Credit / Debit Card">
                        <span class="ms-2">Credit / Debit Card</span>
                    </label>

                    <label class="method-box border rounded p-2 d-flex align-items-center">
                        <input type="radio" name="method" value="E-Wallet">
                        <span class="ms-2">E-Wallet (Boost / TnG / GrabPay)</span>
                    </label>

                </div>

                <button class="btn btn-warning w-100">
                    Proceed to Checkout →
                </button>
            </form>

            <!-- CANCEL -->
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



