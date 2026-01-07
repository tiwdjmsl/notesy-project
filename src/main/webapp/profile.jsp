<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="username" value="${sessionScope.user}" />
<c:set var="tab" value="${param.tab != null ? param.tab : 'my'}" />

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

    <!-- Profile Page Styles -->
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
                ${fn:substring(username, 0, 1)}
            </div>
        </div>

        <div class="profile-center">
            <h1 class="profile-name">${username}</h1>
            <p class="profile-bio">No bio yet</p>

            <div class="profile-meta">
                <span>Not set</span>
                <span>🎓 Not set</span>
                <span>📧 ${username}@gmail.com</span>
            </div>
        </div>

        <div class="profile-right">
            <a href="edit-profile" class="btn-outline">Edit Profile</a>
        </div>

    </section>

    <!-- ================= STATS ================= -->
    <section class="profile-stats">

        <div class="stat-card">
    <div class="stat-value">${statsNotes}</div>
    <div class="stat-label">Notes Uploaded</div>
</div>

<div class="stat-card">
    <div class="stat-value">RM ${statsSales}</div>
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

        <a href="Controller?page=profile&tab=my"
           class="tab ${tab == 'my' ? 'active' : ''}">
            My Notes
        </a>

        <a href="Controller?page=profile&tab=purchased"
           class="tab ${tab == 'purchased' ? 'active' : ''}">
            Purchased
        </a>

        <a href="Controller?page=profile&tab=favorites"
           class="tab ${tab == 'favorites' ? 'active' : ''}">
            Favorites
        </a>

    </section>

    <!-- ================= NOTES GRID ================= -->
    <section class="notes-grid">

        <!-- ========= MY NOTES ========= -->
        <c:if test="${tab == 'my'}">
            <c:choose>
                <c:when test="${empty myNotes}">
                    <p class="empty-state">No notes uploaded yet.</p>
                </c:when>

                <c:otherwise>
                    <c:forEach var="note" items="${myNotes}">
                        <div class="note-card">
                            <h3>${note.title}</h3>
                            <p>${note.description}</p>
                            <span class="note-price">RM ${note.price}</span>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </c:if>


        <!-- ========= PURCHASED NOTES ========= -->
        <c:if test="${tab == 'purchased'}">
            <c:choose>
                <c:when test="${empty purchasedNotes}">
                    <p class="empty-state">No purchased notes yet.</p>
                </c:when>

                <c:otherwise>
                    <c:forEach var="note" items="${purchasedNotes}">
                        <div class="note-card">
                            <h3>${note.title}</h3>
                            <p>${note.description}</p>
                            <span class="note-price">RM ${note.price}</span>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </c:if>


        <!-- ========= FAVORITE NOTES ========= -->
        <c:if test="${tab == 'favorites'}">
            <c:choose>
                <c:when test="${empty favoriteNotes}">
                    <p class="empty-state">No favorites yet.</p>
                </c:when>

                <c:otherwise>
                    <c:forEach var="note" items="${favoriteNotes}">
                        <div class="note-card">
                            <h3>${note.title}</h3>
                            <p>${note.description}</p>
                            <span class="note-price">RM ${note.price}</span>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </c:if>

    </section>

</main>

<jsp:include page="/components/footer.jsp" />

</body>
</html>
