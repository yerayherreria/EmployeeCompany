<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Company"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Employee</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../style/style.css">
</head>

	<%
		ArrayList<Company> result = null;
			try{
				result = (ArrayList<Company>) DbRepository.findAll(Company.class);
			}catch(Exception e){
		
			}
	%>
	
<body>
	<div class="container px-5 my-5">
	  <div class="row justify-content-center">
	    <div class="col-lg-8">
	      <div class="card border-0 rounded-3 shadow-lg">
	        <div class="card-body p-4">
	          <div class="text-center">
	            <div class="h1 fw-light">Add Employee</div>
	          </div>
	
	          <form method="get">

	            <div class="form-floating mb-3">
	    			<label for="exampleInputEmail1" class="form-label">First Name</label>
	    			<input type="text" class="form-control" id="fisrtName" name="firstName" placeholder="Enter First Name" required>
	            </div>
	
	            <div class="form-floating mb-3">
	                <label for="exampleInputEmail1" class="form-label">Last Name</label>
	    			<input type="text" class="form-control" id="lastName" name="lastName" placeholder="Enter Last Name" required>
	            </div>
	
	            <div class="form-floating mb-3">
					<label for="exampleInputEmail1" class="form-label">Email</label>
	    			<input type="email" class="form-control" id="email" name="email" placeholder="Enter Email" required>
	            </div>
	            
	            <div class="form-floating mb-3">
					<label for="exampleInputEmail1" class="form-label">Gender</label>
	    			<input type="text" class="form-control" id="gender" name="gender" placeholder="Enter Gender" required>
	            </div>
	            
	            <div class="form-floating mb-3">
					<label for="exampleInputEmail1" class="form-label">Date of Birth</label>
	    			<input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" placeholder="Enter Date of Birth" required>
	            </div>
	            
	            <div class="form-floating mb-3">
					<label for="exampleInputEmail1" class="form-label">Company's</label>
						<select id="companys" name="companys" required>
						<%
							for (Company c : result ){
						%>
						  <option><%=c.getName()%></option>
						 <%}%>
						</select>
	            </div>
	            <!-- Submit button -->
	            <div class="d-grid">
	              	<button class="btn btn-primary btn-lg" id="submitButton" type="submit" name="submit">Save</button>
	            </div>
	          <%
	          if(request.getParameter("submit") != null && request.getParameter("firstName")!=null && request.getParameter("lastName")!=null && request.getParameter("email")!=null && request.getParameter("gender")!=null && request.getParameter("dateOfBirth")!=null && request.getParameter("companys")!=null){ 
	        	 ArrayList<Employee> employes = (ArrayList<Employee>) DbRepository.findAll(Employee.class); 
	        	  if(employes!=null){
	          		Employee e = new Employee(employes.get(employes.size()-1).getId()+1,request.getParameter("firstName"),request.getParameter("lastName"),request.getParameter("email"),request.getParameter("gender"),Date.valueOf(request.getParameter("dateOfBirth")),DbRepository.lookCompany(request.getParameter("companys")));
	        	  	
	          		DbRepository.addEntity(e);	        	    	
	        	    }
	          }%>
	          </form>
	          <!-- End of contact form -->
	        </div>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>