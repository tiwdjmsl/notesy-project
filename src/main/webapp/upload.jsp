<%@ page contentType="text/html; charset=UTF-8" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<body class="bg-light">

<jsp:include page="/components/navbar.jsp" />

<div class="container my-4">

    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-7">

            <div class="card shadow-sm border-0 rounded-4">
                <div class="card-body p-4">

                    <h4 class="fw-bold mb-3">
                        <i class="fa-solid fa-upload text-warning"></i> Upload New Note
                    </h4>
                    <p class="text-muted mb-4">
                        Fill in the details below to upload and share your study notes.
                    </p>

                   <form action="upload-note" method="post" enctype="multipart/form-data">


                        <div>
                            <label class="form-label fw-semibold">Title</label>
                            <input type="text" name="title" class="form-control" placeholder="Enter note title" required>
                        </div>

                        <div>
                            <label class="form-label fw-semibold">Author</label>
                            <input type="text" name="author" class="form-control" placeholder="Author name">
                        </div>

                        <div>
                            <label class="form-label fw-semibold">Category / Subject</label>
                            <input type="text" name="category" class="form-control" placeholder="e.g., Mathematics, Biology">
                        </div>

                        <div>
                            <label class="form-label fw-semibold">Is this a paid note?</label>
                            <select name="isPaid" class="form-select">
                                <option value="0">Free</option>
                                <option value="1">Paid</option>
                            </select>
                        </div>

                        <div>
                            <label class="form-label fw-semibold">Price (RM)</label>
                            <input type="number" step="0.01" name="price" class="form-control" placeholder="0.00">
                        </div>

                        <div>
                            <label class="form-label fw-semibold">Upload File</label>
                            <input type="file" name="file" class="form-control" required>
                        </div>

                        <button class="btn btn-warning fw-semibold rounded-3">
                            <i class="fa-solid fa-cloud-arrow-up"></i> Upload Note
                        </button>

                    </form>
                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
