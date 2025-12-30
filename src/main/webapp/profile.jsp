<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>
<html lang="en">
<head>
    <title>Profile | Notesy</title>

    <!-- Bootstrap -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

    <!-- Global Styles -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/custom.css">

    <!-- Profile Page Styles (optional) -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/profile.css">
</head>

<body class="bg-light">
<jsp:include page="/components/navbar.jsp" />

<main class="profile-container">

    <!-- ================= PROFILE HEADER ================= -->
    <section class="profile-header">

        <div class="profile-left">
            <div class="avatar">
                ${user.name.substring(0,1)}
            </div>
        </div>

        <div class="profile-center">
            <h1 class="profile-name">${user.name}</h1>
            <p class="profile-bio">${user.bio}</p>

            <div class="profile-meta">
                <span>📍 ${user.location}</span>
                <span>
                    🔗 <a href="${user.website}" target="_blank">${user.website}</a>
                </span>
                <span>📅 Joined ${user.joinDate}</span>
            </div>
        </div>

        <div class="profile-right">
            <a href="edit-profile" class="btn-outline">Edit Profile</a>
        </div>

    </section>

    <!-- ================= STATS ================= -->
    <section class="profile-stats">

        <div class="stat-card">
            <div class="stat-value">${stats.notes}</div>
            <div class="stat-label">Notes Uploaded</div>
        </div>

        <div class="stat-card">
            <div class="stat-value">$${stats.sales}</div>
            <div class="stat-label">Total Sales</div>
        </div>

        <div class="stat-card">
            <div class="stat-value">${stats.followers}</div>
            <div class="stat-label">Followers</div>
        </div>

        <div class="stat-card">
            <div class="stat-value">${stats.rating}</div>
            <div class="stat-label">Avg. Rating</div>
        </div>

    </section>

    <!-- ================= TABS ================= -->
    <section class="profile-tabs">
        <a href="profile" class="tab active">My Notes</a>
        <a href="profile?tab=purchased" class="tab">Purchased</a>
        <a href="profile?tab=favorites" class="tab">Favorites</a>
    </section>

    <!-- ================= NOTES ================= -->
    <section class="notes-grid">

        <c:choose>
            <c:when test="${empty notes}">
                <p class="empty-state">No notes yet.</p>
            </c:when>

            <c:otherwise>
                <c:forEach var="note" items="${notes}">
                    <div class="note-card">
                        <h3>${note.title}</h3>
                        <p>${note.description}</p>
                        <span class="note-price">$${note.price}</span>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>

    </section>

</main>

<jsp:include page="/components/footer.jsp" />

</body>
</html>
