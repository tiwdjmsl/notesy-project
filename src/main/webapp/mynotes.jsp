<%@ page import="java.util.List" %>
<%@ page import="com.notesy.beans.Note" %>

<%
List<Note> myNotes = (List<Note>) request.getAttribute("myNotes");
if (myNotes == null) myNotes = java.util.Collections.emptyList();
%>

<jsp:include page="/components/navbar.jsp" />

<div class="container my-4">

<h4 class="fw-bold mb-3">My Notes</h4>

<% if (myNotes.isEmpty()) { %>

<div class="alert alert-info rounded-4">
    You haven't uploaded any notes yet.
    <a href="upload.jsp" class="fw-bold">Upload one now</a>.
</div>

<% } %>

<div class="row g-4">

<% for (Note n : myNotes) { %>

    <div class="col-md-4">
        <div class="card shadow-sm rounded-4">

            <img src="${pageContext.request.contextPath}/assets/images/cs.jpg"
                 class="card-img-top">

            <div class="card-body">
                <h6 class="fw-bold"><%= n.getTitle() %></h6>
                <small class="text-muted"><%= n.getCategory() %></small>

                <p class="mt-1 small text-muted">
                    Views: <%= n.getViews() %> • Downloads: <%= n.getDownloads() %>
                </p>

                <a class="btn btn-outline-dark w-100"
                   href="Controller?page=download&noteId=<%= n.getNoteId() %>">
                   View / Download
                </a>
            </div>
        </div>
    </div>

<% } %>

</div>
</div>
