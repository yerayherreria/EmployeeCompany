<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Navbar</title>
</head>
<body>
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
	    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
	      <div class="navbar-nav">
	      <form>
	      <div class="d-grid float-right">
	           <button class="btn btn-danger btn-lg " id="submitButton" type="submit" name="exit">Exit</button>
	      </div>	      
	      </form>
	        <a class=" nav-link" href="./listEmployee.jsp">List Employee</a>
	        <a class=" nav-link" href="./addTimeEmployeeProjects.jsp">Add Hours</a>
	        <a class=" nav-link" href="./addTimeEmployeeMultipleProjects.jsp">Add Hours Others Projects</a>
	      </div>
	    </div>
	</nav>
</body>
</html>
<%
if(request.getParameter("exit")!=null){
	response.sendRedirect(".././index.jsp");
}
%>