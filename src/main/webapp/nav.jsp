<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Navbar</title>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-dark">
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">	
	    <span class="navbar-toggler-icon"></span>	
	  </button>
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">	
	    <ul class="navbar-nav mr-auto">	
	      <li class="nav-item">	
	        <a class="nav-link text-white" href="./listEmployee.jsp">List Employee</a>	
	      </li>
	      <li class="nav-item">
	        <a class="nav-link text-white" href="./addTimeEmployeeProjects.jsp">Add Hours</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link text-white" href="./addTimeEmployeeMultipleProjects.jsp">Add Hours Others Projects</a>
	      </li>
	    </ul>
		<form class="align-items-end">
	      <div class="justify-content-end">
	           <button class="btn btn-danger" id="submitButton" type="submit" name="exit">Exit</button>
	      </div>	      
	    </form>	
	  </div>
	</nav>
</body>
</html>
<%
if(request.getParameter("exit")!=null){
	response.sendRedirect("./index.jsp");
}
%>