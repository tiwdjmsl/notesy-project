<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.notesy.beans.Note" %>

<%
@SuppressWarnings("unchecked")
List<Note> notes = (List<Note>) request.getAttribute("noteList");
if (notes == null) {
    notes = java.util.Collections.emptyList();
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Notesy | Explore</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/custom.css">
</head>

<body class="bg-light">

<jsp:include page="/components/navbar.jsp" />

<div class="container-fluid my-4">
    <div class="row">

        <!-- SIDEBAR -->
        <aside class="col-md-3 col-lg-2">
            <div class="bg-white rounded-4 p-3 shadow-sm">
                <h6 class="fw-bold mb-3">Subject</h6>

                <ul class="list-unstyled subject-list">
                    <li class="active">All Subjects</li>
                    <li>Mathematics</li>
                    <li>Physics</li>
                    <li>Chemistry</li>
                    <li>Biology</li>
                    <li>Computer Science</li>
                    <li>Economics</li>
                    <li>Psychology</li>
                    <li>History</li>
                    <li>Literature</li>
                    <li>Business</li>
                </ul>
            </div>
        </aside>

        <!-- MAIN -->
        <main class="col-md-9 col-lg-10">

            <!-- HEADER -->
            <div class="d-flex justify-content-between align-items-center mb-3">

                <form class="d-flex gap-2" action="explore" method="get">

                    <input type="text" name="q" class="form-control"
                           placeholder="Search notes, subjects, authors..."
                           value="<%= request.getAttribute("q") == null ? "" : request.getAttribute("q") %>">

                    <select name="subject" class="form-select">
                        <option value="all">All Subjects</option>
                        <option value="Mathematics">Mathematics</option>
                        <option value="Physics">Physics</option>
                        <option value="Chemistry">Chemistry</option>
                        <option value="Biology">Biology</option>
                        <option value="Computer Science">Computer Science</option>
                        <option value="Economics">Economics</option>
                        <option value="Psychology">Psychology</option>
                        <option value="History">History</option>
                        <option value="Literature">Literature</option>
                        <option value="Business">Business</option>
                    </select>

                    <button class="btn btn-dark">
                        <i class="fa-solid fa-search"></i>
                    </button>
                </form>

                <h6 class="fw-bold mb-0">
                    <%= notes.size() %> results
                </h6>
            </div>

            <!-- NOTES GRID -->
            <div class="row g-4">

            <% for (Note n : notes) { %>

                <div class="col-md-6 col-lg-4 col-xl-3">
                    <div class="card h-100 shadow-sm border-0 rounded-4">

                        <img src="${pageContext.request.contextPath}/assets/images/cs.jpg"
                             class="card-img-top rounded-top-4">

                        <!-- PRICE / FREE -->
                        <span class="badge bg-warning position-absolute top-0 end-0 m-3">
                            <%= n.isPaid() ? "RM " + n.getPrice() : "Free" %>
                        </span>

                        <div class="card-body">

                            <!-- CATEGORY (safe fallback) -->
                            <span class="badge rounded-pill text-bg-light border mb-2">
                                <%= (n.getCategory() == null || n.getCategory().trim().isEmpty())
                                        ? "General"
                                        : n.getCategory()
                                %>
                            </span>

                            <!-- TITLE -->
                            <h6 class="fw-bold mt-2"><%= n.getTitle() %></h6>

                            <!-- AUTHOR (safe fallback) -->
                            <p class="text-muted mb-2">
                                <%= (n.getAuthor() == null || n.getAuthor().trim().isEmpty())
                                        ? "Unknown Author"
                                        : n.getAuthor()
                                %>
                            </p>

                            <!-- STATS -->
                            <div class="d-flex gap-3 text-muted small mb-2">
                                <span><i class="fa-regular fa-heart"></i> <%= n.getLikes() %></span>
                                <span><i class="fa-regular fa-eye"></i> <%= n.getViews() %></span>
                                <span><i class="fa-solid fa-download"></i> <%= n.getDownloads() %></span>
                            </div>

                            <!-- DOWNLOAD / PURCHASE -->
<%
    if (!n.isPaid()) {
%>
    <!-- FREE NOTE -->
    <a class="btn btn-dark w-100"
       href="${pageContext.request.contextPath}/download?noteId=<%= n.getNoteId() %>">
        <i class="fa-solid fa-download"></i> Download
    </a>
<%
    } else {
%>
    <!-- PAID NOTE -->
    <a class="btn btn-warning w-100"
       href="payment.jsp?noteId=<%= n.getNoteId() %>">
        💳 Buy & Download
    </a>
<%
    }
%>



                            

                        </div>
                    </div>
                </div>

            <% } %>

            </div>

        </main>
    </div>
</div>

<jsp:include page="/components/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
