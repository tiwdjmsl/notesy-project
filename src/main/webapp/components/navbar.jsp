<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="currentPage" value="${param.page}" />

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
      rel="stylesheet">

<style>
/* ===== NAV LINK BASE ===== */
.nav-link {
    color: #444;
    padding: 8px 16px;
    border-radius: 999px;
    transition: all 0.25s ease;
    display: flex;
    align-items: center;
    gap: 6px;
}

/* ===== ACTIVE (PINK) ===== */
.nav-link.active {
    background-color: #fde7f3;
    color: #e054a8 !important;
    font-weight: 600;
}

/* ===== HOVER ===== */
.nav-link:hover {
    background-color: #fff0fa;
    color: #e054a8;
}

/* ===== CART BADGE ===== */
.cart-badge {
    background: #ffcc00;
    color: #000;
    font-size: 11px;
    padding: 2px 6px;
    border-radius: 50%;
    margin-left: 4px;
}
</style>

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
    <ul class="navbar-nav ms-auto align-items-center gap-2">

        <!-- HOME -->
        <li class="nav-item">
            <a class="nav-link ${currentPage == 'home' || empty currentPage ? 'active' : ''}"
               href="Controller?page=home">
                <i class="fa-solid fa-house"></i> Home
            </a>
        </li>

        <!-- EXPLORE -->
        <li class="nav-item">
            <a class="nav-link ${currentPage == 'explore' ? 'active' : ''}"
               href="Controller?page=explore">
                <i class="fa-solid fa-magnifying-glass"></i> Explore
            </a>
        </li>

        <!-- UPLOAD -->
        <li class="nav-item">
            <a class="nav-link ${currentPage == 'upload' ? 'active' : ''}"
               href="Controller?page=upload">
                <i class="fa-solid fa-cloud-arrow-up"></i> Upload
            </a>
        </li>

        <!-- CART -->
        <li class="nav-item">
            <a class="nav-link ${currentPage == 'cart' ? 'active' : ''}"
               href="Controller?page=cart">
                <i class="fa-solid fa-cart-shopping"></i> Cart
                <c:if test="${cartCount > 0}">
                    <span class="cart-badge">${cartCount}</span>
                </c:if>
            </a>
        </li>

        <!-- ===== NOT LOGGED IN ===== -->
        <c:if test="${empty sessionScope.user}">
            <li class="nav-item">
                <a class="nav-link"
                   href="login.jsp">
                    <i class="fa-solid fa-right-to-bracket"></i> Login
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link"
                   href="register.jsp"
                   style="background:#eba7dc;color:#000;">
                    Register
                </a>
            </li>
        </c:if>

        <!-- ===== LOGGED IN ===== -->
        <li class="nav-item text-muted small">
                Hi, <strong>${sessionScope.user}</strong>
            </li>
   <c:if test="${not empty sessionScope.user}">
            <li class="nav-item">
                <a class="nav-link ${currentPage == 'profile' ? 'active' : ''}"
                   href="Controller?page=profile&tab=my">
                    <i class="fa-solid fa-user"></i> Profile
                </a>
            </li>
        </c:if>
            <li class="nav-item">
                <a class="nav-link"
                   href="Controller?page=logout">
                    <i class="fa-solid fa-right-from-bracket"></i>
                </a>
            </li>
        

    </ul>
</nav>

<!-- ==============================
     NOTESY AI CHATBOT (DEMO)
     ============================== -->

<!-- Floating Chat Button -->
<div id="chatbot-btn"
     style="position:fixed; right:25px; bottom:25px;
     background:#ffc107; padding:14px 16px; border-radius:50%;
     box-shadow:0 4px 12px rgba(0,0,0,.2); cursor:pointer;
     font-size:20px; font-weight:700; z-index:999;">
🤖
</div>

<!-- Chat Window -->
<div id="chatbot-box"
     style="display:none; position:fixed; right:25px; bottom:95px;
     width:340px; background:white; border-radius:14px;
     box-shadow:0 10px 28px rgba(0,0,0,.25); z-index:999;">

  <div style="padding:12px; font-weight:600;
              background:#f8f9fa; border-radius:14px 14px 0 0;">
      Notesy AI Assistant
  </div>

  <div id="chat-messages"
       style="height:280px; padding:10px; overflow-y:auto; font-size:14px;">
       <div style="color:#0d6efd"><b>Bot:</b> Hi! I’m Notesy AI 🤖<br>
       I can help you with uploads, purchases, or browsing notes.</div>
  </div>

  <div style="padding:10px; display:flex; gap:6px;">
      <input id="chat-input" class="form-control" placeholder="Ask me anything…">
      <button id="chat-send" class="btn btn-warning">Send</button>
  </div>
</div>

<script>
const btn = document.getElementById("chatbot-btn");
const box = document.getElementById("chatbot-box");

btn.onclick = () => {
  box.style.display = box.style.display === "none" ? "block" : "none";
};

document.getElementById("chat-send").onclick = async () => {
  const input = document.getElementById("chat-input");
  const msgBox = document.getElementById("chat-messages");

  const userMsg = input.value.trim();
  if (!userMsg) return;

  msgBox.innerHTML += `<div><b>You:</b> ${userMsg}</div>`;
  input.value = "";

  // Temporary demo response
 const response = await fetch("Controller?page=chatbot", {
  method:"POST",
  headers:{ "Content-Type":"application/x-www-form-urlencoded" },
  body:"message=" + encodeURIComponent(userMsg)
});
const data = await response.json();

msgBox.innerHTML += `<div style='color:#0d6efd'><b>Bot:</b> ${data.reply}</div>`;

</script>