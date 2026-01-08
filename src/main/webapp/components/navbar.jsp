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
        <a href="Controller?page=cart" class="nav-link">
  <i class="fa fa-cart-shopping"></i>

  <c:if test="${cartCount > 0}">
    <span class="badge bg-warning text-dark">${cartCount}</span>
  </c:if>

  Cart
</a>

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
                <a class="nav-link" href="Controller?page=profile&tab=my">
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