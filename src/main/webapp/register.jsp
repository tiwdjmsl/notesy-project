<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Notesy | Sign Up</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
          rel="stylesheet">

    <style>
        body {
            min-height: 100vh;
            background: #fff6fb;
        }

        .signup-container {
            min-height: 100vh;
        }

        /* LEFT SIDE (INFO) */
        .signup-left {
            background: #5a2448;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 60px;
        }

        .info-icon {
            width: 96px;
            height: 96px;
            border-radius: 50%;
            background: rgba(255,255,255,0.15);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px;
        }

        /* RIGHT SIDE (FORM) */
        .signup-right {
            padding: 60px;
            background: #fff6fb;
        }

        .brand-icon {
            width: 48px;
            height: 48px;
            background: #eba7dc;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .form-control {
            border-radius: 12px;
            padding: 12px 14px;
        }

        .btn-signup {
            background: linear-gradient(135deg, #eba7dc, #e68ac9);
            border: none;
            border-radius: 14px;
            padding: 12px;
            font-weight: 600;
            color: #2b0f23;
            transition: all 0.25s ease;
        }

        .btn-signup:hover {
            background: linear-gradient(135deg, #e68ac9, #eba7dc);
            color: #7a1f63;
        }

        @media (max-width: 768px) {
            .signup-left {
                display: none;
            }
        }
    </style>
</head>

<body>

<div class="container-fluid">
    <div class="row signup-container">

        <!-- ================= LEFT: INFO ================= -->
        <div class="col-md-6 signup-left">
            <div>
                <div class="info-icon">
                    <i class="fa-solid fa-graduation-cap fa-2x"></i>
                </div>

                <h2 class="fw-bold mb-3">
                    Create Your Notesy Account
                </h2>

                <p class="opacity-75 fs-5">
                    Share notes, discover resources, and learn
                    together with thousands of students worldwide.
                </p>
            </div>
        </div>

        <!-- ================= RIGHT: SIGN UP FORM ================= -->
        <div class="col-md-6 d-flex align-items-center">
            <div class="signup-right w-100">

                <!-- LOGO -->
                <div class="d-flex align-items-center gap-2 mb-5">
                    <div class="brand-icon">
                        <i class="fa-solid fa-book text-dark"></i>
                    </div>
                    <h4 class="mb-0 fw-bold">Notesy</h4>
                </div>

                <h2 class="fw-bold mb-2">Create account</h2>
                <p class="text-muted mb-4">
                    Join Notesy and start sharing knowledge
                </p>

                <!-- SIGN UP FORM -->
                <form action="Controller?page=register" method="post">

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Username</label>
                        <div class="input-group">
                            <span class="input-group-text bg-white">
                                <i class="fa-solid fa-user"></i>
                            </span>
                            <input name="username"
                                   class="form-control"
                                   placeholder="Enter a username"
                                   required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold">Password</label>
                        <div class="input-group">
                            <span class="input-group-text bg-white">
                                <i class="fa-solid fa-lock"></i>
                            </span>
                            <input name="password"
                                   type="password"
                                   class="form-control"
                                   placeholder="Create a password"
                                   required>
                        </div>
                    </div>

                    <c:if test="${not empty message}">
                        <p class="text-success">${message}</p>
                    </c:if>

                    <button type="submit"
                            class="btn btn-signup w-100">
                        Register →
                    </button>
                </form>

                <p class="text-center mt-4 text-muted">
                    Already have an account?
                    <a href="login.jsp" class="fw-semibold text-decoration-none">
                        Login
                    </a>
                </p>

            </div>
        </div>

    </div>
</div>

</body>
</html>
