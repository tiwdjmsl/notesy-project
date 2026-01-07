<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Notesy | Home</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
          rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/custom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/landing.css">
</head>

<body class="bg-light">

<!-- NAVBAR -->
<jsp:include page="components/navbar.jsp"/>






<!-- ================= HERO SECTION ================= -->
<section class="hero">
    <p class="hero-badge">⭐ Join 50,000+ students sharing knowledge</p>

    <h1 class="hero-title">
        Share Your Notes, <span>Grow Together</span>
    </h1>

    <p class="hero-subtitle">
        The ultimate marketplace for students to buy, sell, and share study notes.
        Turn your hard work into earnings while helping others succeed.
    </p>

    <div class="hero-actions">
        <a href="explore.jsp" class="btn btn-warning btn-lg">
            Start Browsing →
        </a>
        <a href="upload.jsp" class="btn btn-outline-dark btn-lg">
            Upload Notes
        </a>
    </div>
</section>


<!-- ================= STATS ================= -->
<section class="stats">
    <div class="stat-card">
        <h3>7,000+</h3>
        <p>Notes Shared</p>
    </div>
    <div class="stat-card">
        <h3>5,000+</h3>
        <p>Active Students</p>
    </div>
    <div class="stat-card">
        <h3>500+</h3>
        <p>Downloads</p>
    </div>
    <div class="stat-card">
        <h3>2,500+</h3>
        <p>5-Star Reviews</p>
    </div>
</section>


<!-- ================= DAILY KNOWLEDGE ================= -->
<section class="daily-knowledge">
    <div class="dk-icon">💡</div>
    <div class="dk-content">
        <small>Daily Knowledge</small>
        <p>
            The number 0.999… (repeating) is exactly equal to 1,
            not just approximately equal.
        </p>
    </div>
</section>


<!-- ================= FEATURED NOTES GRID ================= -->
<section class="container my-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold">Featured Notes</h2>
            <p class="text-muted mb-0">Handpicked quality notes from top contributors</p>
        </div>
    </div>

    <c:if test="${empty featuredNotes}">
        <p class="text-muted">No featured notes available.</p>
    </c:if>

    <div class="row g-4">

        <c:forEach var="n" items="${featuredNotes}">
            <div class="col-md-6 col-lg-3">
                <div class="card h-100 shadow-sm border-0 rounded-4">

                    <img src="${pageContext.request.contextPath}/assets/images/default.jpg"
                         class="card-img-top rounded-top-4">

                    <!-- Paid / Free badge based on price -->
                    <span class="badge bg-${n.price > 0 ? 'danger' : 'success'} position-absolute top-0 end-0 m-3">
                        ${n.price > 0 ? 'Paid' : 'Free'}
                    </span>

                    <div class="card-body">
                        <h6 class="fw-bold">${n.title}</h6>

                        <p class="text-muted small">${n.description}</p>

                        <!-- We do not have author field in Note bean -->
                        <small class="text-secondary">
                            Uploaded by User #${n.userId}
                        </small>
                    </div>

                </div>
            </div>
        </c:forEach>

    </div>
</section>


<!-- FOOTER -->
<jsp:include page="components/footer.jsp" />


<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
