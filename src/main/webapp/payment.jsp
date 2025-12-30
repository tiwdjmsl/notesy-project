<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.notesy.model.NoteDAO, com.notesy.beans.Note" %>

<%
    String id = request.getParameter("noteId");
    Note note = null;

    if (id != null) {
        NoteDAO dao = new NoteDAO();
        note = dao.getNoteById(Integer.parseInt(id));
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Payment | Notesy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">
<jsp:include page="/components/navbar.jsp"/>

<div class="container py-4">
    <div class="card shadow rounded-4 p-4 mx-auto" style="max-width: 650px">

        <h4 class="fw-bold mb-3">Confirm Purchase</h4>

        <% if (note == null) { %>
            <p class="text-danger">Invalid note.</p>
        <% } else { %>

        <p><b>Title:</b> <%= note.getTitle() %></p>
        <p><b>Author:</b> <%= note.getAuthor() %></p>
        <p><b>Price:</b> RM <%= note.getPrice() %></p>

        <form action="fakecheckout.jsp" method="post">
            <input type="hidden" name="noteId" value="<%= note.getNoteId() %>">

            <button class="btn btn-warning w-100">
                Proceed to Checkout
            </button>
        </form>

        <% } %>

    </div>
</div>

</body>
</html>
