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

    <!-- Optional custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/custom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/landing.css">
</head>
<body class="bg-light">

<!-- NAVBAR -->
<jsp:include page="components/navbar.jsp" />

<c:forEach var="note" items="${notes}">
    <div class="col-md-6 col-lg-3">
        <div class="card h-100 shadow-sm border-0 rounded-4">

            <img src="${pageContext.request.contextPath}/assets/images/default.jpg"
                 class="card-img-top rounded-top-4">

            <span class="badge bg-warning position-absolute top-0 end-0 m-3">
                $${note.price}
            </span>

            <div class="card-body">
                <h6 class="fw-bold">${note.title}</h6>
                <p class="text-muted">${note.description}</p>
            </div>

        </div>
    </div>
</c:forEach>



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
        <h3>25,000+</h3>
        <p>Notes Shared</p>
    </div>
    <div class="stat-card">
        <h3>50,000+</h3>
        <p>Active Students</p>
    </div>
    <div class="stat-card">
        <h3>500K+</h3>
        <p>Downloads</p>
    </div>
    <div class="stat-card">
        <h3>12,000+</h3>
        <p>5-Star Reviews</p>
    </div>
</section>

<!-- ================= SUCCESS STORIES ================= -->
<section class="stories">
    <h4>🌟 Student Success Stories</h4>
    <p>Join 50,000+ students who improved their grades with Notesy</p>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<!-- ================= FEATURED NOTES ================= -->
<div class="container my-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold">Featured Notes</h2>
            <p class="text-muted mb-0">
                Handpicked quality notes from top contributors
            </p>
        </div>
        <a href="#" class="text-decoration-none fw-semibold">
            View All <i class="fa-solid fa-arrow-right ms-1"></i>
        </a>
    </div>

    <div class="row g-4">

        <!-- CARD 1 -->
        <div class="col-md-6 col-lg-3">
            <div class="card h-100 shadow-sm border-0 rounded-4">
                <img src="${pageContext.request.contextPath}/assets/images/math.jpg"
                     class="card-img-top rounded-top-4">

                <span class="badge bg-warning position-absolute top-0 end-0 m-3">$9.99</span>

                <div class="card-body">
                    <span class="badge rounded-pill text-bg-light border mb-2">Mathematics</span>
                    <h6 class="fw-bold mt-2">
                        Complete Calculus I Notes - From Limits to Integrals
                    </h6>
                    <p class="text-muted mb-2">Sarah Chen</p>

                    <div class="d-flex gap-3 text-muted small">
                        <span><i class="fa-regular fa-heart"></i> 342</span>
                        <span><i class="fa-regular fa-eye"></i> 1520</span>
                        <span><i class="fa-solid fa-download"></i> 289</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- CARD 2 -->
        <div class="col-md-6 col-lg-3">
            <div class="card h-100 shadow-sm border-0 rounded-4">
                <img src="${pageContext.request.contextPath}/assets/images/chemistry.jpg"
                     class="card-img-top rounded-top-4">

                <span class="badge bg-primary position-absolute top-0 end-0 m-3">Free</span>

                <div class="card-body">
                    <span class="badge rounded-pill text-bg-light border mb-2">Chemistry</span>
                    <h6 class="fw-bold mt-2">
                        Organic Chemistry Reaction Mechanisms
                    </h6>
                    <p class="text-muted mb-2">Michael Torres</p>

                    <div class="d-flex gap-3 text-muted small">
                        <span><i class="fa-regular fa-heart"></i> 567</span>
                        <span><i class="fa-regular fa-eye"></i> 2340</span>
                        <span><i class="fa-solid fa-download"></i> 1200</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- CARD 3 -->
        <div class="col-md-6 col-lg-3">
            <div class="card h-100 shadow-sm border-0 rounded-4">
                <img src="${pageContext.request.contextPath}/assets/images/cs.jpg"
                     class="card-img-top rounded-top-4">

                <span class="badge bg-warning position-absolute top-0 end-0 m-3">$14.99</span>

                <div class="card-body">
                    <span class="badge rounded-pill text-bg-light border mb-2">
                        Computer Science
                    </span>
                    <h6 class="fw-bold mt-2">
                        Python Programming - Beginner to Advanced
                    </h6>
                    <p class="text-muted mb-2">Emily Watson</p>

                    <div class="d-flex gap-3 text-muted small">
                        <span><i class="fa-regular fa-heart"></i> 891</span>
                        <span><i class="fa-regular fa-eye"></i> 4520</span>
                        <span><i class="fa-solid fa-download"></i> 780</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- CARD 4 -->
        <div class="col-md-6 col-lg-3">
            <div class="card h-100 shadow-sm border-0 rounded-4">
                <img src="${pageContext.request.contextPath}/assets/images/economics.jpg"
                     class="card-img-top rounded-top-4">

                <span class="badge bg-warning position-absolute top-0 end-0 m-3">$7.99</span>

                <div class="card-body">
                    <span class="badge rounded-pill text-bg-light border mb-2">Economics</span>
                    <h6 class="fw-bold mt-2">
                        Microeconomics Fundamentals
                    </h6>
                    <p class="text-muted mb-2">David Kim</p>

                    <div class="d-flex gap-3 text-muted small">
                        <span><i class="fa-regular fa-heart"></i> 234</span>
                        <span><i class="fa-regular fa-eye"></i> 980</span>
                        <span><i class="fa-solid fa-download"></i> 156</span>
                    </div>
                </div>
            </div>
        </div>
        
         <section class="py-5">
      <div class="container-fluid">
        <div class="row">
          
          <div class="col-md-6">
            <div class="banner-ad bg-danger mb-3" style="background: url('images/ad-image-3.png');background-repeat: no-repeat;background-position: right bottom;">
              <div class="banner-content p-5">

                <div class="categories text-primary fs-3 fw-bold">Upto 25% Off</div>
                <h3 class="banner-title">Luxa Dark Chocolate</h3>
                <p>Very tasty & creamy vanilla flavour creamy muffins.</p>
                <a href="#" class="btn btn-dark text-uppercase">Show Now</a>

              </div>
            
            </div>
          </div>
          <div class="col-md-6">
            <div class="banner-ad bg-info" style="background: url('images/ad-image-4.png');background-repeat: no-repeat;background-position: right bottom;">
              <div class="banner-content p-5">

                <div class="categories text-primary fs-3 fw-bold">Upto 25% Off</div>
                <h3 class="banner-title">Creamy Muffins</h3>
                <p>Very tasty & creamy vanilla flavour creamy muffins.</p>
                <a href="#" class="btn btn-dark text-uppercase">Show Now</a>

              </div>
            
            </div>
          </div>
             
        </div>
      </div>
    </section>

<!-- ================= NOTE PREVIEW MODAL ================= -->
<div class="modal fade" id="notePreviewModal" tabindex="-1">
  <div class="modal-dialog modal-xl modal-dialog-centered">
    <div class="modal-content rounded-4">

      <div class="modal-header border-0">
        <h5 class="modal-title">Organic Chemistry Reaction Mechanisms</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body text-center">

        <img id="previewImage"
             src="${pageContext.request.contextPath}/assets/images/chemistry.jpg"
             class="img-fluid rounded-4 preview-image">

        <div class="d-flex justify-content-center align-items-center gap-3 mt-3">
          <button class="btn btn-light" id="prevBtn">&lt;</button>
          <span id="pageIndicator">Page 1 of 5</span>
          <button class="btn btn-light" id="nextBtn">&gt;</button>
        </div>

        <p id="lockedNotice" class="text-warning mt-3 d-none">
          🔒 This page is locked. Purchase to unlock full content.
        </p>

      </div>

    </div>
  </div>
</div>

 


</div>
<!-- FOOTER -->
<jsp:include page="components/footer.jsp" />

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
let currentPage = 1;
let totalPages = 1;
let previewPages = 1;
let isPurchased = false;

const img = document.getElementById("previewImage");
const indicator = document.getElementById("pageIndicator");
const notice = document.getElementById("lockedNotice");

document.querySelectorAll(".note-preview-trigger").forEach(card => {
  card.addEventListener("click", () => {
    totalPages = parseInt(card.dataset.totalPages);
    previewPages = parseInt(card.dataset.previewPages);
    isPurchased = card.dataset.purchased === "true";
    currentPage = 1;
    updatePage();
  });
});

function updatePage() {
  indicator.innerText = `Page ${currentPage} of ${totalPages}`;

  if (!isPurchased && currentPage > previewPages) {
    img.classList.add("locked");
    notice.classList.remove("d-none");
  } else {
    img.classList.remove("locked");
    notice.classList.add("d-none");
  }
}

document.getElementById("nextBtn").onclick = () => {
  if (currentPage < totalPages) {
    currentPage++;
    updatePage();
  }
};

document.getElementById("prevBtn").onclick = () => {
  if (currentPage > 1) {
    currentPage--;
    updatePage();
  }
};
</script>

</body>
</html>