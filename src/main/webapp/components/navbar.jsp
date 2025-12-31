<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar navbar-expand-lg bg-white border-bottom px-4">

    <!-- Brand -->
    <a class="navbar-brand fw-bold text-warning"
       href="Controller?page=explore">
        <i class="fa-solid fa-book me-1"></i> Notesy
    </a>

    <!-- SEARCH -->
    <form class="d-flex flex-grow-1 mx-4"
          action="Controller" method="get">
        <input type="hidden" name="page" value="search">

        <input class="form-control rounded-pill"
               name="q"
               value="${keyword}"
               placeholder="Search notes, subjects, authors...">
    </form>

    <ul class="navbar-nav ms-auto align-items-center">

        <li class="nav-item">
            <a class="nav-link"
               href="Controller?page=explore">
                <i class="fa-solid fa-magnifying-glass me-1"></i>
                Explore
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link fw-semibold text-warning"
               href="upload.jsp">
                <i class="fa-solid fa-upload me-1"></i>
                Upload
            </a>
        </li>

        <!-- LOGGED-IN USER -->
        <c:if test="${not empty sessionScope.user}">
            <li class="nav-item">
                <a class="nav-link"
                   href="Controller?page=mynotes">
                    <i class="fa-solid fa-note-sticky me-1"></i>
                    My Notes
                </a>
            </li>

            <li class="nav-item ms-3 fw-semibold">
                Hi, ${sessionScope.user}
            </li>

            <li class="nav-item ms-3">
                <a class="nav-link"
                   href="Controller?page=logout">
                    Logout
                </a>
            </li>
        </c:if>

        <!-- GUEST USER -->
        <c:if test="${empty sessionScope.user}">
            <li class="nav-item">
                <a class="nav-link"
                   href="login.jsp">
                    Login
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link"
                   href="register.jsp">
                    Register
                </a>
            </li>
        </c:if>

    </ul>
</nav>
