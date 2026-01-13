<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <title>Notesy | Explore</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
          rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/custom.css">
</head>
<style>
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
.subject-list li a {
    display: block;
    padding: 8px 10px;
    color: #333;
    text-decoration: none;
    border-radius: 8px;
}

.subject-list li a:hover {
    background: #f3e8ff;
    color: #6a1b9a;
}

.note-thumb {
    height: 160px;
    overflow: hidden;
    border-radius: 16px 16px 0 0;
}

.note-thumb img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.note-category {
    font-size: 12px;
    background: #f2e6fa;
    color: #6a1b9a;
    padding: 4px 10px;
    border-radius: 20px;
    width: fit-content;
    margin-bottom: 6px;
}

</style>
<script>
document.addEventListener("DOMContentLoaded", function () {
    const toastEl = document.getElementById("cartToast");
    if (toastEl) {
        const toast = new bootstrap.Toast(toastEl, {
            delay: 2500   // ⏱ disappears after 2.5 seconds
        });
        toast.show();
    }
});
</script>

<body class="bg-light">


<!-- 🔔 ADDED TO CART TOAST -->
<c:if test="${param.status == 'added_to_cart'}">
<div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 9999;">
    <div id="cartToast"
         class="toast align-items-center text-bg-success border-0"
         role="alert"
         aria-live="assertive"
         aria-atomic="true">

        <div class="d-flex">
            <div class="toast-body">
                ✅ Added to cart successfully!
            </div>
            <button type="button"
                    class="btn-close btn-close-white me-2 m-auto"
                    data-bs-dismiss="toast">
            </button>
        </div>

    </div>
</div>
</c:if>



<!-- NAVBAR -->
<jsp:include page="components/navbar.jsp" />

<!-- ===== MAIN AREA ===== -->
<main class="container-fluid my-4">

    <div class="row">

        <!-- ================= SIDEBAR ================= -->
        <aside class="col-md-3 col-lg-2 mb-4">

            <div class="subject-card shadow-sm rounded-4 p-3 bg-white">
                <h6 class="fw-bold mb-3">Subjects</h6>

                <ul class="list-unstyled subject-list">
                    <li><a href="Controller?page=explore">All Subjects</a></li>
                    <li><a href="Controller?page=explore&category=Mathematics">Mathematics</a></li>
                    <li><a href="Controller?page=explore&category=Physics">Physics</a></li>
                    <li><a href="Controller?page=explore&category=Chemistry">Chemistry</a></li>
                    <li><a href="Controller?page=explore&category=Computer%20Science">Computer Science</a></li>
                </ul>
            </div>

        </aside>

        <!-- ================= NOTES GRID ================= -->
        <section class="col-md-9 col-lg-10">

            <!-- SEARCH -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <form action="Controller" method="get" class="d-flex w-75">
                    <input type="hidden" name="page" value="search">
                    <input class="form-control me-2"
                           name="q"
                           placeholder="Search notes..."
                           value="${keyword}">
                    <button class="btn btn-primary">
                        <i class="fa fa-search"></i>
                    </button>
                </form>
            </div>

            <!-- NOTES -->
            <div class="row g-4">

                <c:if test="${empty notes}">
                    <p class="text-muted text-center">
                        No notes found.
                    </p>
                </c:if>

                <c:forEach var="n" items="${notes}">
                    <div class="col-md-6 col-lg-4 col-xl-3">

                        <div class="card note-card h-100 shadow-sm border-0">

                            <!-- IMAGE -->
                            <div class="note-thumb">
                                <img src="${pageContext.request.contextPath}/${n.picture}"
                                     onerror="this.src='${pageContext.request.contextPath}/assets/images/default.jpg'">

                                <span class="badge badge-price ${n.price > 0 ? 'paid' : 'free'}">
                                    ${n.price > 0 ? 'Paid' : 'Free'}
                                </span>
                            </div>

                            <div class="card-body d-flex flex-column">
                                <h6 class="fw-bold">${n.title}</h6>

                                <span class="note-category">${n.category}</span>

                                <p class="text-muted small flex-grow-1">
                                    ${fn:length(n.description) > 80
                                        ? fn:substring(n.description,0,80).concat("...")
                                        : n.description}
                                </p>

                                <div class="fw-bold mb-2">RM ${n.price}</div>

                                <div class="d-flex gap-2 mt-auto">
                                    <form action="Controller?page=addToCart" method="post">
                                        <input type="hidden" name="id" value="${n.noteId}">
                                        <button class="btn btn-outline-primary btn-sm">
                                            <i class="fa fa-cart-plus"></i>
                                        </button>
                                    </form>

                                    <form action="Controller?page=addFavorite" method="post">
                                        <input type="hidden" name="id" value="${n.noteId}">
                                        <button class="btn btn-outline-danger btn-sm">
                                            <i class="fa fa-heart"></i>
                                        </button>
                                    </form>

                                    <a href="Controller?page=open_download&id=${n.noteId}"
                                       class="btn btn-primary btn-sm w-100">
                                        Download
                                    </a>
                                </div>
                            </div>

                        </div>

                    </div>
                </c:forEach>

            </div>

        </section>

    </div>

</main>


     

<!-- FOOTER -->
<jsp:include page="components/footer.jsp" />


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

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
</body>
</html>
