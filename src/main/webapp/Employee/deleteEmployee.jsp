<%@page import="com.jacaranda.model.Company"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Date"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	
		Employee e = null;
	
		try{
			e = DbRepository.find(Employee.class, Integer.valueOf(request.getParameter("idEmployee")));	
			
		}catch(Exception r2){
			response.sendRedirect("error.jsp?error="+r2.getMessage());
		}
		
		if(request.getParameter("submit")!=null){
			try{
	        	DbRepository.deleteEntity(Employee.class,Integer.valueOf(request.getParameter("idEmployee"))); 
			}catch (Exception r5){
				response.sendRedirect("error.jsp?error="+r5.getMessage());
			}
			
		}
%>
	<div class="container px-5 my-5">
	  <div class="row justify-content-center">
	    <div class="col-lg-8">
	      <div class="card border-0 rounded-3 shadow-lg">
	        <div class="card-body p-4">
	          <div class="text-center">
	            <div class="h1 fw-light">Delete Employee</div>
	          </div>
	
	          <form method="get">
				<input type="text" class="form-control" id="firstName" name="idEmployee" placeholder="Enter First Name" value="<%=request.getParameter("idEmployee")%>" hidden>
	            <div class="form-floating mb-3">
	    			<label for="exampleInputEmail1" class="form-label">First Name</label>
	    			<input type="text" class="form-control" id="firstName" name="firstName" placeholder="Enter First Name" value="<%=e.getFirstName()%>" readonly>
	            </div>
	
	            <div class="form-floating mb-3">
	                <label for="exampleInputEmail1" class="form-label">Last Name</label>
	    			<input type="text" class="form-control" id="lastName" name="lastName" placeholder="Enter Last Name" value="<%=e.getLastName()%>" readonly>
	            </div>
	
	            <div class="form-floating mb-3">
					<label for="exampleInputEmail1" class="form-label">Email</label>
	    			<input type="email" class="form-control" id="email" name="email" placeholder="Enter Email" value="<%=e.getEmail()%>" readonly>
	            </div>
	            
	            <div class="form-floating mb-3">
					<label for="exampleInputEmail1" class="form-label">Gender</label>
	    			<input type="text" class="form-control" id="gender" name="gender" placeholder="Enter Gender" value="<%=e.getGender()%>" readonly>
	            </div>
	            
	            <div class="form-floating mb-3">
					<label for="exampleInputEmail1" class="form-label">Date of Birth</label>
	    			<input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" placeholder="Enter Date of Birth" value="<%=e.getDateOfBirth()%>" readonly>
	            </div>
	            <div class="form-floating mb-3">
					<label for="exampleInputEmail1" class="form-label">Company's</label>
					<input type="text" class="form-control" id="company" name="company" value="<%=e.getCompany().getName()%>" readonly>
	            </div>
	            
	            <!-- Submit button -->
	            <div class="d-grid">
	              	<button class="btn btn-primary btn-lg" id="submitButton" type="submit" name="submit">Delete</button>
	            </div>

	          </form>
	          <!-- End of contact form -->
	        </div>
	      </div>
	    </div>
	  </div>
	</div>
</body>

</html>