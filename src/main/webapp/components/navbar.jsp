<%@ page contentType="text/html; charset=UTF-8" %>

<nav class="navbar navbar-expand-lg bg-white border-bottom px-4">
    <a class="navbar-brand fw-bold text-warning" href="index.jsp">
        <i class="fa-solid fa-book me-1"></i> Notesy
    </a>

    <form class="d-flex flex-grow-1 mx-4">
        <input class="form-control rounded-pill"
               placeholder="Search notes, subjects, authors...">
    </form>

    <ul class="navbar-nav ms-auto align-items-center">
        <li class="nav-item">
            <a class="nav-link" href="index.jsp">
                <i class="fa-solid fa-house me-1"></i> Home
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="explore.jsp">
                <i class="fa-solid fa-magnifying-glass me-1"></i> Explore
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link fw-semibold text-warning" href="upload.jsp">
                <i class="fa-solid fa-upload me-1"></i> Upload
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fa-solid fa-user me-1"></i> Profile
            </a>
        </li>

        <li class="nav-item ms-3">
            <i class="fa-solid fa-cart-shopping"></i>
            <span class="badge bg-warning text-dark ms-1">1</span>
        </li>

        <li class="nav-item ms-3 fw-semibold">Hi, Demo</li>

        <li class="nav-item ms-3">
            <a class="nav-link" href="#">Logout</a>
        </li>
    </ul>
</nav>
