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

<!-- NAVBAR -->
<jsp:include page="components/navbar.jsp" />

        <!-- ===== MAIN AREA ===== -->
        <main class="col-md-9 col-lg-10" style="width: 90%; margin:30px;">

   			 <!-- SEARCH -->
		<div class="d-flex justify-content-between align-items-center mb-4" style="margin: 30px; align-items: center;">
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
		    
<!-- ===== NOTES LIST / GRID ===== -->
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

                    <p>
                        <strong>RM ${n.price}</strong>
                    </p>

                   <a href="Controller?page=open_download&id=${n.noteId}"
   class="btn btn-primary">
   Download
</a>

                </div>

            </div>
        </div>
    </c:forEach>

</div>

		  </main>
 
<!-- FOOTER -->
<jsp:include page="components/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>