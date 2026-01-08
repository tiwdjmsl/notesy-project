<%@ page contentType="text/html; charset=UTF-8" %>

<!-- Floating Chatbot Button -->
<button id="chat-toggle-btn" class="chat-fab">
    <i class="fa-solid fa-robot"></i>
</button>

<!-- Chatbot Panel -->
<div id="chatbot-box" class="chatbox">
    <div class="chat-header">
        AI Help Bot
        <span id="chat-close">✖</span>
    </div>

    <div id="chatMessages" class="chat-body"></div>

    <div class="chat-footer">
        <input id="chatInput" type="text" placeholder="Type a message…">
        <button id="sendBtn">Send</button>
    </div>
</div>

<style>
.chat-fab{
  position:fixed;
  bottom:22px;
  right:22px;
  width:58px;
  height:58px;
  border-radius:50%;
  background:#ffc107;
  color:#000;
  border:none;
  box-shadow:0 10px 25px rgba(0,0,0,.2);
  font-size:22px;
  display:flex;
  align-items:center;
  justify-content:center;
  cursor:pointer;
  z-index:9999 !important;
}

.chatbox{
  position:fixed;
  bottom:90px;
  right:20px;
  width:320px;
  background:#fff;
  border-radius:18px;
  box-shadow:0 10px 30px rgba(0,0,0,.25);
  display:none;
  z-index:9999 !important;
}

.chatbox.open{ display:block; }

.chat-header{
  padding:10px 12px;
  background:#ffd7f3;
  border-radius:18px 18px 0 0;
  font-weight:600;
  display:flex;
  justify-content:space-between;
}

.chat-body{
  height:260px;
  overflow-y:auto;
  padding:10px;
}

.chat-footer{
  display:flex;
  gap:6px;
  padding:10px;
}
</style>

<script>
document.addEventListener("DOMContentLoaded", () => {

  const btn = document.getElementById("chat-toggle-btn");
  const box = document.getElementById("chatbot-box");
  const closeBtn = document.getElementById("chat-close");
  const input = document.getElementById("chatInput");
  const messages = document.getElementById("chatMessages");
  const sendBtn = document.getElementById("sendBtn");

  btn.onclick = () => box.classList.toggle("open");
  closeBtn.onclick = () => box.classList.remove("open");

  function addMsg(sender,text){
    const p=document.createElement("p");
    p.innerHTML=`<b>${sender}:</b> ${text}`;
    messages.appendChild(p);
    messages.scrollTop = messages.scrollHeight;
  }

  function sendMessage(){
    const msg = input.value.trim();
    if(!msg) return;

    addMsg("You",msg);

    fetch("Controller?page=chatbot",{
      method:"POST",
      headers:{ "Content-Type":"application/x-www-form-urlencoded" },
      body:"message="+encodeURIComponent(msg)
    })
    .then(r=>r.text())
    .then(reply=> addMsg("Bot",reply));

    input.value="";
  }

  sendBtn.onclick = sendMessage;
  input.addEventListener("keypress",e=>{
    if(e.key === "Enter") sendMessage();
  });

});
</script>
