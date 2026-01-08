<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Notesy | Upload</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

    <style>
        body { background:#fafafa; }
        .hidden { display:none; }

        .step-circle{width:36px;height:36px;border-radius:50%;
            display:flex;align-items:center;justify-content:center;
            font-weight:bold}
        .step-active{background:#eba7dc;color:#fff}
        .step-inactive{background:#eee;color:#777}

        .upload-box{border:2px dashed #eba7dc;border-radius:16px;
            padding:50px;text-align:center;background:#f9edfa}
        .btn-warning{background:#eba7dc!important;border:#eba7dc!important;color:#000!important}
    </style>
</head>

<body>

<jsp:include page="components/navbar.jsp" />

<div class="container my-5">
<div class="mx-auto" style="max-width:900px;">



<!-- ================= STEP PROGRESS ================= -->
<div class="d-flex justify-content-center align-items-center gap-3 mb-5">
    <div id="step1-ind" class="step-circle step-active">1</div>
    <div class="border-top" style="width:120px;"></div>

    <div id="step2-ind" class="step-circle step-inactive">2</div>
    <div class="border-top" style="width:120px;"></div>

    <div id="step3-ind" class="step-circle step-inactive">3</div>
</div>



<!-- =================================================== -->
<!--  ONE FORM for ALL STEPS (multipart for file upload) -->
<!-- =================================================== -->
<form id="uploadForm"
      action="Controller?page=addnote"
      method="post"
      enctype="multipart/form-data">



<!-- =============== STEP 1 — SELECT PDF =============== -->
<div id="step1">

    <h1 class="text-center fw-bold">Upload Your Notes</h1>
    <p class="text-center text-muted mb-4">PDF only</p>

    <div class="card shadow-sm rounded-4 p-4">
        <div class="upload-box">

            <i class="fa-solid fa-file-arrow-up fa-3x text-warning mb-3"></i>
            <h5>Select a PDF file</h5>

            <input type="file"
                   class="form-control mt-3"
                   id="fileInput"
                   name="file"
                   accept="application/pdf"
                   required>

            <p id="fileName" class="mt-3 fw-semibold"></p>

            <button type="button"
                    class="btn btn-warning px-4 mt-3"
                    onclick="goStep2()">Continue →</button>
        </div>
    </div>
</div>



<!-- =============== STEP 2 — NOTE DETAILS =============== -->
<div id="step2" class="hidden">

    <h1 class="text-center fw-bold">Add information about your notes</h1>
    <p class="text-center text-muted mb-4">
        Help students discover your notes
    </p>

    <div class="card shadow-sm rounded-4 p-4">

        <div class="mb-3">
            <label class="fw-semibold">Title</label>
            <input name="title" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="fw-semibold">Description</label>
            <textarea name="description" class="form-control" rows="4" required></textarea>
        </div>

        <div class="mb-3">
            <label class="fw-semibold">Category</label>
            <select name="category" class="form-select" required>
                <option value="">Select a subject</option>
                <option>Mathematics</option>
                <option>Physics</option>
                <option>Chemistry</option>
                <option>Computer Science</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="fw-semibold">Price (RM)</label>
            <input name="price" type="number" step="0.01"
                   class="form-control" value="0">
        </div>

        <!-- ========= THUMBNAIL UPLOAD (OPTIONAL) ========= -->
        <div class="mb-3">
            <label class="fw-semibold">Thumbnail Image (optional)</label>
            <input type="file"
                   name="thumb"
                   class="form-control"
                   accept="image/*">
            <small class="text-muted">Shown as card preview</small>
        </div>

        <input type="hidden" name="likes" value="0">

        <div class="d-flex justify-content-between">
            <button type="button"
                    class="btn btn-outline-secondary"
                    onclick="goStep1()">Back</button>

            <button type="submit"
                    class="btn btn-warning px-4"
                    onclick="goStep3()">Upload Notes →</button>
        </div>
    </div>
</div>



</form>



<!-- =============== STEP 3 — SUCCESS =============== -->
<div id="step3" class="hidden text-center">

    <i class="fa-solid fa-circle-check fa-4x text-success mb-4"></i>

    <h1 class="fw-bold">Upload Successful!</h1>
    <p class="text-muted mb-4">
        Your notes are now live and ready to download.
    </p>

    <a href="Controller?page=explore" class="btn btn-warning px-4">
        View My Notes →
    </a>
</div>



</div>
</div>



<jsp:include page="components/footer.jsp" />





<script>
function goStep1(){ showStep(1); }

function goStep2(){
    if(document.getElementById("fileInput").files.length === 0){
        alert("Please select a PDF file first");
        return;
    }
    showStep(2);
}

function goStep3(){ showStep(3); }

function showStep(step){
    ["step1","step2","step3"].forEach(id =>
        document.getElementById(id).classList.add("hidden"));

    ["step1-ind","step2-ind","step3-ind"].forEach(id =>
        document.getElementById(id).className="step-circle step-inactive");

    document.getElementById("step"+step).classList.remove("hidden");
    document.getElementById("step"+step+"-ind").className="step-circle step-active";
}

document.getElementById("fileInput").addEventListener("change",function(){
    if(this.files.length>0){
        document.getElementById("fileName").innerText =
            this.files[0].name + " (" +
            (this.files[0].size/1024).toFixed(2)+" KB)";
    }
});
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
