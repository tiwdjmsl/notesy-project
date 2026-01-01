<%@ page contentType="text/html; charset=UTF-8" %>
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

<!-- NAVBAR -->
<jsp:include page="components/navbar.jsp" />

        <!-- ===== MAIN AREA ===== -->
        <main class="col-md-9 col-lg-10" style="width: 90%; margin:30px;">

   			 <!-- SEARCH -->
		<div class="d-flex justify-content-between align-items-center mb-4" style="margin: 30px; align-items: center;">
			  <input class="form-control w-50"
			        placeholder="Search notes, subjects, authors...">
		
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
      
        <!-- ===== LEFT SIDEBAR SUBJECTS ===== -->
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
		  </main>
 
<!-- FOOTER -->
<jsp:include page="components/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
