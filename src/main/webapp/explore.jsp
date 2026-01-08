<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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

<body class="bg-light">


<!-- 🔔 ADDED TO CART TOAST -->
<c:if test="${param.status == 'added_to_cart'}">
<div class="toast-container position-fixed top-0 end-0 p-3">
  <div class="toast show bg-success text-white">
    <div class="toast-body">
      Added to cart successfully!
    </div>
  </div>
</div>
</c:if>


<!-- NAVBAR -->
<jsp:include page="components/navbar.jsp" />

<!-- ===== MAIN AREA ===== -->
<main class="col-md-9 col-lg-10" style="width: 90%; margin:30px;">

    <!-- SEARCH -->
    <div class="d-flex justify-content-between align-items-center mb-4" style="margin: 30px;">
        <form action="Controller" method="get" class="d-flex w-50">
            <input type="hidden" name="page" value="search">

            <input class="form-control" name="q"
                   placeholder="Search notes, subjects, authors..."
                   value="${keyword}">

            <button class="btn btn-primary ms-2">
                <i class="fa fa-search"></i>
            </button>
        </form>

        <div class="d-flex gap-2">
            <select class="form-select">
                <option>Most Popular</option>
                <option>Newest</option>
                <option>Price: Low to High</option>
            </select>
            <button class="btn btn-warning">
                <i class="fa-solid fa-grip"></i>
            </button>
            <button class="btn btn-outline-secondary">
                <i class="fa-solid fa-list"></i>
            </button>
        </div>
    </div>

    <!-- ===== SUBJECT SIDEBAR ===== -->
    <div class="col-md-3" style="width: 100%;">
        <aside class="col-md-3 col-lg-2">
            <div class="subject-card">
                <h6 class="subject-title">Subjects</h6>

                <ul class="subject-list">
                    <li class="${empty param.category ? 'active' : ''}">
                        <a href="Controller?page=explore">All Subjects</a>
                    </li>

                    <li class="${param.category == 'Mathematics' ? 'active' : ''}">
                        <a href="Controller?page=explore&category=Mathematics">Mathematics</a>
                    </li>

                    <li class="${param.category == 'Physics' ? 'active' : ''}">
                        <a href="Controller?page=explore&category=Physics">Physics</a>
                    </li>

                    <li class="${param.category == 'Chemistry' ? 'active' : ''}">
                        <a href="Controller?page=explore&category=Chemistry">Chemistry</a>
                    </li>

                    <li class="${param.category == 'Computer Science' ? 'active' : ''}">
                        <a href="Controller?page=explore&category=Computer%20Science">
                            Computer Science
                        </a>
                    </li>
                </ul>

            </div>
        </aside>
    </div>

    <!-- ===== NOTES GRID ===== -->
    <div class="row mt-4">

        <c:if test="${empty notes}">
            <p class="text-muted text-center">
                No notes found for this category or search.
            </p>
        </c:if>

        <c:forEach var="n" items="${notes}">
            <div class="col-md-4 mb-4">
                <div class="card shadow-sm">

                    <div class="card-body">
                        <h5 class="card-title">${n.title}</h5>

                        <p class="text-muted small mb-2">
                            ${n.category}
                        </p>

                        <p class="card-text" style="min-height:60px;">
                            ${n.description}
                        </p>

                        <p><strong>RM ${n.price}</strong></p>

                        <!-- ===== BUTTONS ROW ===== -->
                        <div class="d-flex align-items-center gap-2 mt-2">

                            <!-- 🛒 ADD TO CART -->
                            <form action="Controller?page=addToCart" method="post" class="m-0">
                                <input type="hidden" name="id" value="${n.noteId}">
                                <button type="submit" class="btn btn-outline-primary btn-sm w-100">
                                    <i class="fa fa-cart-plus"></i> Add to Cart
                                </button>
                            </form>

                            <!-- ❤️ FAVORITE -->
                            <form action="Controller?page=addFavorite" method="post" class="m-0">
                                <input type="hidden" name="id" value="${n.noteId}">
                                <button type="submit" class="btn btn-outline-danger btn-sm w-100">
                                    <i class="fa fa-heart"></i> Favorite
                                </button>
                            </form>

                            <!-- ⬇ DOWNLOAD -->
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

</main>

<!-- FOOTER -->
<jsp:include page="components/footer.jsp" />


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</script>
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
