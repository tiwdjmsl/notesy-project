<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.notesy.beans.Note" %>

<%
    Note n = (Note) request.getAttribute("note");
%>

<!DOCTYPE html>
<html>
<head>
<title>Download Notes | Notesy</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<style>
body { background:#f4f6fb; }

.note-box{
  max-width:950px;
  margin:35px auto;
  background:#fff;
  border-radius:18px;
  padding:25px;
  box-shadow:0 14px 28px rgba(0,0,0,.08);
}

.badge-free{
  background:#28a745;
  padding:6px 12px;
  border-radius:10px;
  color:#fff;
  font-weight:600;
}

.badge-paid{
  background:#dc3545;
  padding:6px 12px;
  border-radius:10px;
  color:#fff;
  font-weight:600;
}

.preview-box{
  border:1px solid #eee;
  border-radius:14px;
  padding:18px;
  background:#fafafa;
  text-align:center;
}

.thumb-img{
  width:100%;
  max-height:260px;
  border-radius:14px;
  object-fit:cover;
}
</style>
</head>

<body>

<jsp:include page="components/navbar.jsp"/>

<div class="note-box">

  <a href="Controller?page=explore" class="text-decoration-none mb-2 d-inline-block">
    <i class="fa fa-arrow-left"></i> Back to Explore
  </a>

  <%-- ============ NOTE NOT FOUND ============ --%>
  <% if (n == null) { %>

      <h3 class="text-danger mt-3">Note not found.</h3>

  <% } else { %>

  <%-- ============ HEADER ============ --%>
  <div class="d-flex justify-content-between align-items-start">
    <h2 class="fw-bold"><%= n.getTitle() %></h2>

    <% if (n.getPrice() > 0) { %>
      <span class="badge-paid">Paid</span>
    <% } else { %>
      <span class="badge-free">Free</span>
    <% } %>
  </div>

  <p class="text-muted mb-1">
    <i class="fa fa-folder-open"></i> <%= n.getCategory() %> &nbsp;•&nbsp;
    <i class="fa fa-user"></i> User #<%= n.getUserId() %>
  </p>

  <div class="row mt-4">

    <%-- ============ LEFT: PREVIEW / THUMBNAIL ============ --%>
    <div class="col-md-5">

      <div class="preview-box">

        <% if (n.getPicture() != null && !n.getPicture().isEmpty()) { %>

            <img src="<%= n.getPicture() %>" class="thumb-img">

        <% } else { %>

            <i class="fa-solid fa-file-pdf fa-5x text-danger"></i>
            <p class="mt-2 text-muted">PDF Document</p>

        <% } %>

      </div>
    </div>

    <%-- ============ RIGHT: DETAILS & ACTION ============ --%>
    <div class="col-md-7">

      <p class="text-muted"><%= n.getDescription() %></p>

      <h4 class="fw-bold mt-2">
        RM <%= n.getPrice() %>
      </h4>

      <hr>

      <%-- ========= FREE NOTE → DIRECT DOWNLOAD ========= --%>
      <% if (n.getPrice() == 0) { %>

        <a href="Controller?page=download&id=<%= n.getNoteId() %>"
           class="btn btn-primary w-100">
           <i class="fa fa-download"></i> Download Now
        </a>

      <%-- ========= PAID NOTE → PAYMENT PAGE ========= --%>
      <% } else { %>

        <a href="Controller?page=payment&id=<%= n.getNoteId() %>"
           class="btn btn-warning w-100">
           <i class="fa fa-credit-card"></i> Buy & Continue
        </a>

      <% } %>

    </div>
  </div>

  <% } %>

</div>

</body>
</html>
