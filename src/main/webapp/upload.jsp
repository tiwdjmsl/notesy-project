<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Notesy | Upload</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
          rel="stylesheet">

    <style>
        body { background: #fafafa; }

		.step1 {
		max-width: 70%;
    	margin: 0 auto;
		}
        .step-circle {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        .step-active {
            background: #eba7dc;
            color: white;
        }

        .step-inactive {
            background: #eee;
            color: #777;
        }

        .upload-box {
            border: 2px dashed #eba7dc;
            border-radius: 16px;
            padding: 50px;
            text-align: center;
            background: #f9edfa;
        }

        .hidden {
            display: none;
        }
		.btn-warning {
		    background-color: #eba7dc !important;
		    border-color: #eba7dc !important;
		    color: #000 !important;
		}
		
		.text-warning {
		    color: #eba7dc !important;
		}
		
		.bg-warning {
		    background-color: #eba7dc !important;
		}
		        
    </style>
</head>

<body>

<!-- NAVBAR -->
<jsp:include page="components/navbar.jsp" />

<!-- ================= STEPS ================= -->
<div class="container my-5">
    <div class="mx-auto" style="max-width: 900px;">


    <!-- Step indicator -->
    <div class="d-flex justify-content-center align-items-center gap-3 mb-5"
	     style="max-width: 600px; margin: 0 auto;">
	
	    <div class="step-circle step-active" id="step1-ind">1</div>
	    <div class="border-top" style="width: 120px;"></div>
	
	    <div class="step-circle step-inactive" id="step2-ind">2</div>
	    <div class="border-top" style="width: 120px;"></div>
	
	    <div class="step-circle step-inactive" id="step3-ind">3</div>
	</div>


    <!-- ================= STEP 1 ================= -->
    <div id="step1">
        <h1 class="text-center fw-bold">Upload Your Notes</h1>
        <p class="text-center text-muted mb-4">
            Share your knowledge with students around the world
        </p>

        <div class="card shadow-sm rounded-4 p-4" style="max-width: 800px; margin: 0 auto;">

            <div class="upload-box" style="max-width: 700px; margin: 20px auto;">
                <i class="fa-solid fa-file-arrow-up fa-3x text-warning mb-3"></i>
                <h5>Select a file to upload</h5>
                <p class="text-muted">PDF only</p>

                <input type="file" class="form-control mt-3" id="fileInput">

                <p class="mt-3 fw-semibold" id="fileName"></p>

                <button class="btn btn-warning px-4 mt-3"
                        onclick="goStep2()">Continue →</button>
            </div>
        </div>
    </div>
</div>

    <!-- ================= STEP 2 ================= -->
<form id="uploadForm"
      action="Controller?page=addnote"
      method="post">

<div id="step2" class="hidden">
    <h1 class="text-center fw-bold">Note Details</h1>
    <p class="text-center text-muted mb-4">
        Add information to help students find your notes
    </p>

    <div class="card shadow-sm rounded-4 p-4">

        <div class="mb-3">
            <label class="form-label fw-semibold">Title</label>
            <input name="title" class="form-control"
                   placeholder="e.g., Complete Calculus I Notes" required>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold">Description</label>
            <textarea name="description" class="form-control"
                      rows="4"
                      placeholder="Describe what's covered in your notes..."
                      required></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold">Category</label>
            <select name="category" class="form-select" required>
                <option value="">Select a subject</option>
                <option>Mathematics</option>
                <option>Physics</option>
                <option>Chemistry</option>
                <option>Computer Science</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold">Author</label>
            <input name="author" class="form-control"
                   placeholder="Your name" required>
        </div>

        <div class="form-check form-switch mb-3">
            <input class="form-check-input" type="checkbox"
                   id="paidSwitch" onchange="togglePrice()">
            <label class="form-check-label">
                Paid Note
            </label>
        </div>

        <div class="mb-4" id="priceBox" style="display:none;">
            <label class="form-label fw-semibold">Price (RM)</label>
            <input name="price" type="number" step="0.01"
                   class="form-control" value="0">
        </div>

        <!-- hidden values -->
        <input type="hidden" name="paid" id="paidInput" value="false">
        <input type="hidden" name="filePath" value="uploads/sample.pdf">

        <div class="d-flex justify-content-between">
            <button type="button"
                    class="btn btn-outline-secondary"
                    onclick="goStep1()">Back</button>

            <button type="submit"
                    class="btn btn-warning px-4">
                Upload Notes →
            </button>
        </div>

    </div>
</div>
</form>


    <!-- ================= STEP 3 ================= -->
    <div id="step3" class="hidden text-center">
        <i class="fa-solid fa-circle-check fa-4x text-success mb-4"></i>

        <h1 class="fw-bold">Upload Successful!</h1>
        <p class="text-muted mb-4">
            Your notes are now live and available for students to discover.
        </p>

        <div class="d-flex justify-content-center gap-3">
            <button class="btn btn-outline-secondary">
                Upload Another
            </button>
            <button class="btn btn-warning px-4">
                View My Notes →
            </button>
        </div>
    </div>

</div>

<!-- FOOTER -->
<jsp:include page="components/footer.jsp" />

<!-- ================= JS ================= -->
<script>
    function goStep1() {
        showStep(1);
    }

    function goStep2() {
        showStep(2);
    }

    function goStep3() {
        showStep(3);
    }

    function showStep(step) {
        document.getElementById("step1").classList.add("hidden");
        document.getElementById("step2").classList.add("hidden");
        document.getElementById("step3").classList.add("hidden");

        document.getElementById("step1-ind").className = "step-circle step-inactive";
        document.getElementById("step2-ind").className = "step-circle step-inactive";
        document.getElementById("step3-ind").className = "step-circle step-inactive";

        document.getElementById("step" + step).classList.remove("hidden");
        document.getElementById("step" + step + "-ind").className =
            "step-circle step-active";
    }

    document.getElementById("fileInput").addEventListener("change", function () {
        if (this.files.length > 0) {
            document.getElementById("fileName").innerText =
                this.files[0].name + " (" + (this.files[0].size / 1024).toFixed(2) + " KB)";
        }
    });
    
    function togglePrice() {
        const checked = document.getElementById("paidSwitch").checked;
        document.getElementById("priceBox").style.display = checked ? "block" : "none";
        document.getElementById("paidInput").value = checked;
    }
   
</script>

</body>
</html>
