<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>My Notes</title>
</head>

<body>

<h2>My Notes</h2>

<c:if test="${empty notes}">
    <p>You have not uploaded any notes yet.</p>
</c:if>

<c:forEach var="n" items="${notes}">
    <div class="note-card" style="border:1px solid #ccc; padding:10px; margin-bottom:10px">

        <h3>${n.title}</h3>
        <p>${n.description}</p>

        <p>Category: ${n.category}</p>
        <p>Author: ${n.author}</p>

        <p>
            ${n.isPaid ? 'Paid' : 'Free'}
            <c:if test="${n.isPaid}">
                — RM ${n.price}
            </c:if>
        </p>

        <p>
            Views: ${n.views}
            | Downloads: ${n.downloads}
        </p>

    </div>
</c:forEach>

</body>
</html>
