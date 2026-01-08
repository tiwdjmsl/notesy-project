<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<jsp:include page="components/navbar.jsp"/>

<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<div class="container mt-5">

    <h2 class="fw-bold mb-4">
        🛒 My Cart
    </h2>

    <!-- EMPTY CART -->
    <c:if test="${empty cartItems}">
        <div class="text-center p-5 bg-light rounded shadow-sm">
            <i class="fa fa-cart-arrow-down fa-3x text-muted mb-3"></i>
            <h5 class="text-muted">Your cart is empty</h5>

            <a href="Controller?page=explore" class="btn btn-primary mt-3">
                Browse Notes
            </a>
        </div>
    </c:if>

    <!-- CART LIST -->
    <c:if test="${not empty cartItems}">

        <div class="row">
            <div class="col-lg-8">

                <c:set var="total" value="0" />

                <c:forEach var="n" items="${cartItems}">
                    <c:set var="total" value="${total + n.price}" />

                    <div class="card shadow-sm mb-3">
                        <div class="card-body d-flex justify-content-between">

                            <div>
                                <h5 class="mb-1">${n.title}</h5>
                                <span class="text-muted small">${n.category}</span>
                                <div class="fw-bold mt-1">RM ${n.price}</div>
                            </div>

                            <form action="Controller?page=removeCart" method="post">
                                <input type="hidden" name="id" value="${n.noteId}">
                                <button class="btn btn-outline-danger btn-sm">
                                    <i class="fa fa-trash"></i> Remove
                                </button>
                            </form>

                        </div>
                    </div>
                </c:forEach>

            </div>

            <!-- SUMMARY PANEL -->
            <div class="col-lg-4">
                <div class="card shadow-sm p-3 sticky-top" style="top: 100px;">
                    <h5 class="fw-bold mb-3">Order Summary</h5>

                    <div class="d-flex justify-content-between mb-2">
                        <span>Items</span>
                        <span>${fn:length(cartItems)}</span>
                    </div>

                    <div class="d-flex justify-content-between fw-bold fs-5 border-top pt-2">
                        <span>Total</span>
                        <span>RM ${total}</span>
                    </div>
<c:forEach var="item" items="${cartItems}">
    <form action="Controller" method="get">
        <input type="hidden" name="page" value="open_download">
        <input type="hidden" name="id" value="${item.noteId}">
        <button class="btn btn-success">
            Checkout
        </button>
    </form>
</c:forEach>





                    <a href="Controller?page=explore"
                       class="btn btn-outline-secondary w-100 mt-2">
                        Continue Shopping
                    </a>
                </div>
            </div>
        </div>
    </c:if>

</div>

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