<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar navbar-expand-lg px-4 py-3"
     style="background:#fff6fb; border-bottom:1px solid #f3d7ea;">

    <!-- LOGO -->
    <a class="navbar-brand d-flex align-items-center gap-2 fw-bold"
       href="Controller?page=home"
       style="color:#222;">
        <span class="rounded-circle d-flex align-items-center justify-content-center"
              style="width:36px;height:36px;background:#eba7dc;">
            <i class="fa-solid fa-book text-dark"></i>
        </span>
        Notesy
    </a>

    <!-- RIGHT MENU -->
    <ul class="navbar-nav ms-auto align-items-center gap-3">

        <li class="nav-item">
            <a class="nav-link px-3 rounded-pill"
               href="Controller?page=home"
               style="background:#fde7f3; color:#e054a8;">
                <i class="fa-solid fa-book-open me-1"></i> Home
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link" href="Controller?page=explore">
                <i class="fa-solid fa-magnifying-glass me-1"></i> Explore
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link" href="Controller?page=upload">
                <i class="fa-solid fa-upload me-1"></i> Upload
            </a>
        </li>

        <!-- CART -->
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fa-solid fa-cart-shopping"></i>
            </a>
        </li>

        <!-- ================= NOT LOGGED IN ================= -->
        <c:if test="${empty sessionScope.user}">
            <li class="nav-item">
                <a class="nav-link" href="login.jsp">
                    <i class="fa-solid fa-right-to-bracket"></i> Login
                </a>
            </li>

            <li class="nav-item">
                <a class="btn rounded-pill px-3"
                   href="register.jsp"
                   style="background:#eba7dc; color:#000;">
                    Register
                </a>
            </li>
        </c:if>

        <!-- ================= LOGGED IN ================= -->
        <c:if test="${not empty sessionScope.user}">
            <li class="nav-item">
                <a class="nav-link" href="profile.jsp">
                    <i class="fa-solid fa-user me-1"></i> Profile
                </a>
            </li>

            <li class="nav-item text-muted">
                Hi, <strong>${sessionScope.user}</strong>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="Controller?page=logout">
                    <i class="fa-solid fa-right-from-bracket"></i> Logout
                </a>
            </li>
        </c:if>

    </ul>
</nav>
