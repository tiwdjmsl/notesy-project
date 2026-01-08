<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="username" value="${sessionScope.user}" />
<c:set var="tab" value="${param.tab != null ? param.tab : 'my'}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Profile | Notesy</title>

    <!-- Bootstrap -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

    <!-- Global Styles -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/custom.css">

    <!-- Profile Page Styles -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/profile.css">
</head>

<body class="bg-light">

<jsp:include page="/components/navbar.jsp" />

<main class="profile-container">

    <!-- ================= PROFILE HEADER ================= -->
    <section class="profile-header">

        <div class="profile-left">
            <div class="avatar">
                ${fn:substring(username, 0, 1)}
            </div>
        </div>

        <div class="profile-center">
            <h1 class="profile-name">${username}</h1>
            <p class="profile-bio">No bio yet</p>

            <div class="profile-meta">
                <span>Not set</span>
                <span>🎓 Not set</span>
                <span>📧 ${username}@gmail.com</span>
            </div>
        </div>

        <div class="profile-right">
            <a href="edit-profile" class="btn-outline">Edit Profile</a>
        </div>

    </section>

    <!-- ================= STATS ================= -->
    <section class="profile-stats">

        <div class="stat-card">
    <div class="stat-value">${statsNotes}</div>
    <div class="stat-label">Notes Uploaded</div>
</div>

<div class="stat-card">
    <div class="stat-value">RM ${statsSales}</div>
    <div class="stat-label">Total Sales</div>
</div>


        <div class="stat-card">
            <div class="stat-value">${stats.followers}</div>
            <div class="stat-label">Followers</div>
        </div>

        <div class="stat-card">
            <div class="stat-value">${stats.rating}</div>
            <div class="stat-label">Avg. Rating</div>
        </div>

    </section>

    <!-- ================= TABS ================= -->
    <section class="profile-tabs">

        <a href="Controller?page=profile&tab=my"
           class="tab ${tab == 'my' ? 'active' : ''}">
            My Notes
        </a>

        <a href="Controller?page=profile&tab=purchased"
           class="tab ${tab == 'purchased' ? 'active' : ''}">
            Purchased
        </a>

        <a href="Controller?page=profile&tab=favorites"
           class="tab ${tab == 'favorites' ? 'active' : ''}">
            Favorites
        </a>

    </section>

    <!-- ================= NOTES GRID ================= -->
    <section class="notes-grid">

        <!-- ========= MY NOTES ========= -->
        <c:if test="${tab == 'my'}">
            <c:choose>
                <c:when test="${empty myNotes}">
                    <p class="empty-state">No notes uploaded yet.</p>
                </c:when>

                <c:otherwise>
                    <c:forEach var="note" items="${myNotes}">
                        <div class="note-card">
                            <h3>${note.title}</h3>
                            <p>${note.description}</p>
                            <span class="note-price">RM ${note.price}</span>
                             <!-- DELETE BUTTON -->
        <form action="Controller?page=deleteNote"
              method="post"
              onsubmit="return confirm('Delete this note?');">

            <input type="hidden" name="id" value="${note.noteId}" />

            <button class="btn btn-danger btn-sm" type="submit">
                Delete
            </button>
        </form>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </c:if>


        <!-- ========= PURCHASED NOTES ========= -->
        <c:if test="${tab == 'purchased'}">
            <c:choose>
                <c:when test="${empty purchasedNotes}">
                    <p class="empty-state">No purchased notes yet.</p>
                </c:when>

                <c:otherwise>
                    <c:forEach var="note" items="${purchasedNotes}">
                        <div class="note-card">
                            <h3>${note.title}</h3>
                            <p>${note.description}</p>
                            <span class="note-price">RM ${note.price}</span>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </c:if>


        <!-- ========= FAVORITE NOTES ========= -->
        <c:if test="${tab == 'favorites'}">
            <c:choose>
                <c:when test="${empty favoriteNotes}">
                    <p class="empty-state">No favorites yet.</p>
                </c:when>

                <c:otherwise>
                    <c:forEach var="note" items="${favoriteNotes}">
                        <div class="note-card">
                            <h3>${note.title}</h3>
                            <p>${note.description}</p>
                            <span class="note-price">RM ${note.price}</span>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </c:if>

    </section>

</main>

<jsp:include page="/components/footer.jsp" />
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
