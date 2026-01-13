<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.notesy.beans.Note" %>

<%
    Note note = (Note) request.getAttribute("note");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Payment | Notesy</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body { background:#f7f7f7; }
        .card { border-radius:18px; }
        .method-box:hover { border-color:#0d6efd; cursor:pointer; }
    </style>
</head>

<body>

<jsp:include page="components/navbar.jsp"/>

<div class="container py-5">

    <div class="card shadow p-4 mx-auto" style="max-width:650px">

        <h3 class="fw-bold mb-2">Confirm Purchase</h3>
        <p class="text-muted">Review the note details and choose a payment method.</p>
        <hr>

        <% if (note == null) { %>

            <p class="text-danger fw-bold">
                ⚠ Invalid or missing note information.
            </p>

            <a href="Controller?page=explore"
               class="btn btn-secondary w-100 mt-2">
                Back to Explore
            </a>

        <% } else { %>

            <!-- NOTE DETAILS -->
            <div class="mb-3">
                <b>Title:</b> <%= note.getTitle() %><br>
                <b>Category:</b> <%= note.getCategory() %><br>
                <b>Price:</b> RM <%= note.getPrice() %>
            </div>

            <!-- DEMO PAYMENT METHOD -->
            <h6 class="fw-bold mt-2 mb-2">Select Payment Method (Demo)</h6>

            <form action="fakecheckout.jsp" method="post">

                <input type="hidden" name="id" value="<%= note.getNoteId() %>">
                <input type="hidden" name="title" value="<%= note.getTitle() %>">
                <input type="hidden" name="amount" value="<%= note.getPrice() %>">

                <div class="card p-3 mb-3">

                    <label class="method-box border rounded p-2 d-flex align-items-center mb-2">
                        <input type="radio" name="method" value="FPX Online Banking" checked>
                        <span class="ms-2">FPX Online Banking</span>
                    </label>

                    <label class="method-box border rounded p-2 d-flex align-items-center mb-2">
                        <input type="radio" name="method" value="Credit / Debit Card">
                        <span class="ms-2">Credit / Debit Card</span>
                    </label>

                    <label class="method-box border rounded p-2 d-flex align-items-center">
                        <input type="radio" name="method" value="E-Wallet">
                        <span class="ms-2">E-Wallet (Boost / TnG / GrabPay)</span>
                    </label>

                </div>

                <button class="btn btn-warning w-100">
                    Proceed to Checkout →
                </button>
            </form>

            <!-- CANCEL -->
            <a href="Controller?page=explore"
               class="btn btn-outline-secondary mt-3 w-100">
                Cancel
            </a>

        <% } %>

    </div>
</div>

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



