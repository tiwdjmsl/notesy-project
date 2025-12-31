<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="components/navbar.jsp" />

<div class="container mt-4">

    <!-- PAGE TITLE -->
    <div class="text-center mb-4">
        <h3 class="fw-bold text-warning">
            <i class="fa-solid fa-magnifying-glass me-1"></i>
            Explore Study Notes
        </h3>
        <p class="text-muted">
            Browse free and paid notes shared by students.
        </p>
    </div>

    <!-- NO RESULTS -->
    <c:if test="${empty notes}">
        <div class="alert alert-warning rounded-4">
            No notes found. Try another search.
        </div>
    </c:if>

    <!-- NOTES GRID -->
    <div class="row g-3">
        <c:forEach var="n" items="${notes}">
            <div class="col-md-4">

                <!-- CARD -->
                <div class="card shadow-sm border-0 rounded-4">

                    <div class="card-body">

                        <!-- CATEGORY -->
                        <span class="badge bg-warning text-dark mb-2">
                            ${n.category}
                        </span>

                        <!-- TITLE -->
                        <h5 class="fw-bold">${n.title}</h5>

                        <!-- AUTHOR -->
                        <p class="text-muted small mb-2">
                            by <span class="fw-semibold">${n.author}</span>
                        </p>

                        <!-- PRICE LABEL -->
                        <c:if test="${!n.paid}">
                            <span class="badge bg-success">FREE</span>
                        </c:if>

                        <c:if test="${n.paid}">
                            <span class="badge bg-dark">
                                RM ${n.price}
                            </span>
                        </c:if>

                        <hr>

                        <!-- ACTION BUTTONS -->
                        <div class="d-flex gap-2">

                            <c:if test="${!n.paid}">
                                <a class="btn btn-warning btn-sm rounded-pill fw-semibold"
                                   href="Controller?page=download&id=${n.noteId}">
                                   Download
                                </a>
                            </c:if>

                            <c:if test="${n.paid}">
                                <a class="btn btn-outline-warning btn-sm rounded-pill"
                                   href="Controller?page=pay&id=${n.noteId}">
                                   Purchase
                                </a>

                                <a class="btn btn-warning btn-sm rounded-pill fw-semibold"
                                   href="Controller?page=download&id=${n.noteId}">
                                   Download
                                </a>
                            </c:if>

                        </div>

                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
