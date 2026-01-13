<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<script src="https://www.google.com/recaptcha/api.js" async defer></script>

<head>
    <title>Notesy | Login</title>

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

        .login-container {
            min-height: 100vh;
        }

        /* LEFT SIDE (INFO) */
        .login-left {
            background: #4a0a52;
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
        .login-right {
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

        .btn-login {
		    background: #eba7dc;
		    border: none;
		    border-radius: 14px;
		    padding: 15px;
		    width: 20px;
		    font-weight: 700;
		    color: #2b0f23;
		    
		}
		
		.btn-login:hover {
		    background: #bd4fa5;
		    color: #7a1f63;
		}

        @media (max-width: 768px) {
            .login-left {
                display: none;
            }
        }
    </style>
</head>

<body>

<div class="container-fluid">
    <div class="row login-container">

        <!-- ================= LEFT: INFO ================= -->
        <div class="col-md-6 login-left">
            <div>
                <div class="info-icon">
                    <i class="fa-solid fa-book-open fa-2x"></i>
                </div>

                <h2 class="fw-bold mb-3">
                    Join the Learning Community
                </h2>

                <p class="opacity-75 fs-5">
                    Connect with 5,000+ students sharing notes,
                    insights, and helping each other succeed
                    in their academic journey.
                </p>
            </div>
        </div>

        <!-- ================= RIGHT: LOGIN FORM ================= -->
        <div class="col-md-6 d-flex align-items-center">
            <div class="login-right w-100">

                <!-- LOGO -->
                <div class="d-flex align-items-center gap-2 mb-5">
                    <div class="brand-icon">
                        <i class="fa-solid fa-book text-dark"></i>
                    </div>
                    <h4 class="mb-0 fw-bold">Notesy</h4>
                </div>

                <h2 class="fw-bold mb-2">Welcome back</h2>
                <p class="text-muted mb-4">
                    Sign in to continue to your account
                </p>

                <!-- LOGIN FORM -->
                <form action="Controller?page=login" method="post">

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Username</label>
                        <div class="input-group">
                            <span class="input-group-text bg-white">
                                <i class="fa-solid fa-user"></i>
                            </span>
                            <input name="username"
                                   class="form-control"
                                   placeholder="Enter your username"
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
                                   placeholder="••••••••"
                                   required>
                        </div>
                    </div>
<!-- ✅ reCAPTCHA -->
    <div class="mb-3">
        <div class="g-recaptcha"
             data-sitekey="6LfkMkQsAAAAAEKhp0ymUhHwyX2kK678aJhHLLfC"></div>
             
                    <c:if test="${not empty error}">
                        <p class="text-danger">${error}</p>
                    </c:if>

                    <button type="submit"
                            class="btn btn-login w-100 text-dark">
                        Login →
                    </button>
                </form>
					 <p class="text-center mt-4 text-muted">
					  Don't have an account?
						<a href="register.jsp" class="fw-semibold text-decoration-none">
					        Register
					  </a>
					   </p>
            </div>
        </div>

    </div>
</div>

</body>
</html>