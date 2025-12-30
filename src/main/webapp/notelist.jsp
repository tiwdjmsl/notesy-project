<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.notesy.beans.Note" %>

<%
@SuppressWarnings("unchecked")
List<Note> notes = (List<Note>) request.getAttribute("noteList");


%>

<h2>Notes List</h2>

<table border="1" cellpadding="8">
<tr>
    <th>Title</th>
    <th>Category</th>
    <th>Author</th>
    <th>Type</th>
    <th>Likes</th>
    <th>Views</th>
    <th>Downloads</th>
    <th>Action</th>
</tr>

<% for (Note n : notes) { %>
<tr>
    <td><%= n.getTitle() %></td>
    <td><%= n.getCategory() != null ? n.getCategory() : "-" %></td>
    <td><%= n.getAuthor() != null ? n.getAuthor() : "-" %></td>

    <td>
        <%= n.isPaid() ? "Paid (RM " + n.getPrice() + ")" : "Free" %>
    </td>

    <td><%= n.getLikes() %></td>
    <td><%= n.getViews() %></td>
    <td><%= n.getDownloads() %></td>

    <td>
        <a href="Controller?page=download&noteId=<%= n.getNoteId() %>">
            Download
        </a>
    </td>
</tr>
<% } %>

</table>
