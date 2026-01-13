<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Notesy | Home</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/landing.css">
    <style>
    
/* HERO */
.hero {
    text-align: center;
    padding: 80px 20px 60px;
}

.hero-badge {
    font-size: 14px;
    color: #eba7dc;
    margin-bottom: 10px;
}

.hero-title {
    font-size: 56px;
    font-weight: 700;
    margin-bottom: 20px;
}

.hero-title span {
    color: #eba7dc;
}

.hero-subtitle {
    max-width: 700px;
    margin: 0 auto 30px;
    color: #555;
    font-size: 16px;
}

.hero-actions {
    display: flex;
    justify-content: center;
    gap: 15px;
}

/* STATS */
.stats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
    max-width: 900px;
    margin: 50px auto;
    padding: 0 20px;
}

.stat-card {
    background: white;
    border-radius: 16px;
    padding: 20px;
    text-align: center;
    box-shadow: 0 10px 20px rgba(0,0,0,0.05);
}

.stat-card h3 {
    color: #eba7dc;
    font-weight: 700;
}

/* SUCCESS STORIES */
.stories {
    background: #eba7dc;
    border-radius: 20px;
    padding: 30px;
    max-width: 900px;
    margin: 40px auto;
    text-align: center;
}

/* DAILY KNOWLEDGE */
.daily-knowledge {
    display: flex;
    align-items: center;
    gap: 20px;
    max-width: 900px;
    margin: 40px auto 80px;
    padding: 20px;
    background: white;
    border-radius: 16px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.05);
}

.dk-icon {
    background: #eba7dc;
    color: white;
    font-size: 28px;
    padding: 20px;
    border-radius: 12px;
}


/* =========================
   ANIMATIONS
   ========================= */

@keyframes fadeUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes fadeDown {
    from {
        opacity: 0;
        transform: translateY(-20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes popIn {
    from {
        opacity: 0;
        transform: scale(0.9);
    }
    to {
        opacity: 1;
        transform: scale(1);
    }
}
/* Navbar animation */
.navbar {
    animation: fadeDown 0.6s ease forwards;
}

/* Hero section */
.hero-badge {
    animation: fadeUp 0.6s ease forwards;
}

.hero-title {
    animation: fadeUp 0.7s ease forwards;
}

.hero-subtitle {
    animation: fadeUp 0.8s ease forwards;
}

.hero-actions {
    animation: fadeUp 0.9s ease forwards;
}

/* Stats cards stagger */
.stat-card {
    opacity: 0;
    animation: popIn 0.6s ease forwards;
}

.stat-card:nth-child(1) { animation-delay: 0.2s; }
.stat-card:nth-child(2) { animation-delay: 0.4s; }
.stat-card:nth-child(3) { animation-delay: 0.6s; }
.stat-card:nth-child(4) { animation-delay: 0.8s; }

/* Stories */
.stories {
    animation: fadeUp 0.8s ease forwards;
}

/* Daily knowledge */
.daily-knowledge {
    opacity: 0;
    animation: fadeUp 0.9s ease forwards;
    animation-delay: 0.5s;
}
.stat-card,
.daily-knowledge {
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.stat-card:hover,
.daily-knowledge:hover {
    transform: translateY(-6px);
    box-shadow: 0 16px 30px rgba(0,0,0,0.08);
}

/* ===== NOTE PREVIEW ===== */
.preview-image {
    transition: filter 0.3s ease;
}

.preview-image.locked {
    filter: blur(12px);
    pointer-events: none;
}
    /* Remove link styling */
.note-card-link {
    text-decoration: none;
    color: inherit;
}

/* Card hover animation */
.note-card {
    transition: all 0.25s ease;
    cursor: pointer;
}

.note-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 18px 40px rgba(0,0,0,0.12);
}

/* Thumbnail */
.note-thumb {
    position: relative;
    height: 160px;
    overflow: hidden;
    border-radius: 16px 16px 0 0;
}

.note-thumb img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

/* Price badge */
.badge-price {
    position: absolute;
    top: 12px;
    right: 12px;
    padding: 6px 10px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
}

.badge-price.paid {
    background: #dc3545;
    color: white;
}

.badge-price.free {
    background: #198754;
    color: white;
}
    
    </style>
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
        <a href="Controller?page=explore" class="btn btn-warning btn-lg" style="background: #eba7dc; border: #000;">Start Browsing →</a>
        <a href="upload.jsp" class="btn btn-outline-dark btn-lg">Upload Notes</a>
    </div>
</section>


<!-- ================= STATS ================= -->
<section class="stats">
    <div class="stat-card"><h3>7,000+</h3><p>Notes Shared</p></div>
    <div class="stat-card"><h3>5,000+</h3><p>Active Students</p></div>
    <div class="stat-card"><h3>500+</h3><p>Downloads</p></div>
    <div class="stat-card"><h3>2,500+</h3><p>5-Star Reviews</p></div>
</section>


<!-- ================= FEATURED NOTES ================= -->
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

        <a href="Controller?page=open_download&id=${n.noteId}"
           class="note-card-link">

            <div class="card note-card h-100 shadow-sm border-0 rounded-4">

                <!-- Thumbnail -->
                <div class="note-thumb">
                    <img src="${pageContext.request.contextPath}/${n.picture}"
                         onerror="this.src='${pageContext.request.contextPath}/assets/images/default.jpg'">

                    <!-- Paid / Free badge -->
                    <span class="badge badge-price ${n.price > 0 ? 'paid' : 'free'}">
                        ${n.price > 0 ? 'Paid' : 'Free'}
                    </span>
                </div>

                <div class="card-body">
                    <h6 class="fw-bold mb-1">${n.title}</h6>

                    <p class="text-muted small mb-2">
                        ${n.description}
                    </p>

                    <small class="text-secondary">
                        Uploaded by User #${n.userId}
                    </small>
                </div>

            </div>
        </a>

    </div>
</c:forEach>

    </div>
</section>


<!-- FOOTER -->
<jsp:include page="components/footer.jsp" />


<!-- =========================================================
     AI CHATBOT (HIDDEN UNTIL BUTTON CLICK)
========================================================= -->

<c:if test="${not empty sessionScope.user}">
    
<!-- Floating Button -->
<button id="chatToggle" class="chat-fab">🤖</button>

<!-- Chat Window -->
<div id="chatContainer" class="chat-window hidden">

    <div class="chat-header">
         Notesy Bot
        <span id="closeChat" class="close-btn">×</span>
    </div>

    <div id="chatBody" class="chat-body">
        <div class="bot-msg">
            👋 <b>Hi ${sessionScope.user}!</b><br>
            I’m your study assistant. Ask me anything about Notesy or your studies.
        </div>
    </div>

    <div class="chat-input">
        <input id="chatMessage" type="text" placeholder="Type a message...">
        <button id="sendBtn">Send</button>
    </div>
</div>

<style>
.hidden{ opacity:0; pointer-events:none; transform:translateY(20px); }
.chat-window{ position:fixed; bottom:95px; right:25px; width:320px; height:380px;
    background:#fff; border-radius:18px; box-shadow:0 15px 40px rgba(0,0,0,.25);
    display:flex; flex-direction:column; overflow:hidden; z-index:9999; transition:.25s; }
.chat-header{ background:#ffd6f4; padding:10px 14px; font-weight:bold; }
.close-btn{ float:right; cursor:pointer; }
.chat-body{ flex:1; padding:10px; overflow-y:auto; font-size:14px; }
.chat-input{ display:flex; border-top:1px solid #ddd; }
.chat-input input{ flex:1; border:none; padding:8px; }
.chat-input button{ border:none; padding:8px 12px; background:#ffb800; }
.chat-fab{ position:fixed; bottom:25px; right:25px; width:60px; height:60px;
    border-radius:50%; font-size:24px; border:none; background:#ffd75e;
    box-shadow:0 8px 25px rgba(0,0,0,.25); cursor:pointer; z-index:9999; }
.user-msg{ background:#e3f1ff; padding:6px; border-radius:10px; margin-bottom:6px; }
.bot-msg{ background:#fff0fb; padding:6px; border-radius:10px; margin-bottom:6px; }
.typing{ font-style:italic; opacity:.6; }
</style>

<script>
const chatBtn = document.getElementById("chatToggle");
const chatBox = document.getElementById("chatContainer");
const closeBtn = document.getElementById("closeChat");
const input = document.getElementById("chatMessage");
const chatBody = document.getElementById("chatBody");

chatBtn.onclick = () => {
    chatBox.classList.toggle("hidden");
    chatBody.scrollTop = chatBody.scrollHeight;
};
closeBtn.onclick = () => chatBox.classList.add("hidden");

document.getElementById("sendBtn").onclick = sendMessage;
input.addEventListener("keypress", e => { if(e.key==="Enter") sendMessage(); });

function sendMessage(){
    const msg = input.value.trim();
    if(!msg) return;
    addMessage("user", msg);
    input.value = "";

    const typing = addTyping();

    fetch("Controller?page=chatbot",{
        method:"POST",
        headers:{ "Content-Type":"application/x-www-form-urlencoded" },
        body:"message="+encodeURIComponent(msg)
    })
    .then(r=>r.text())
    .then(reply=>{
        typing.remove();
        addMessage("bot", reply);
    })
    .catch(()=>{
        typing.remove();
        addMessage("bot","⚠️ Sorry, I couldn't connect right now.");
    });
}

function addMessage(type,text){
    const div = document.createElement("div");
    div.className = type==="user" ? "user-msg" : "bot-msg";
    div.innerHTML = text;
    chatBody.appendChild(div);
    chatBody.scrollTop = chatBody.scrollHeight;
}

function addTyping(){
    const t = document.createElement("div");
    t.className = "bot-msg typing";
    t.innerText = "Bot is typing...";
    chatBody.appendChild(t);
    chatBody.scrollTop = chatBody.scrollHeight;
    return t;
}
</script>

</c:if>




<!-- Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
