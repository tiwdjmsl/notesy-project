<%@ page contentType="text/html; charset=UTF-8" %>
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

</body>
</html>
