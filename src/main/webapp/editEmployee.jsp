<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="com.jacaranda.model.Company"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Date"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file="./nav.jsp"%>
<%
		if(session.getAttribute("rol")==null){response.sendRedirect("./index.jsp");}

		ArrayList<Company> companias = null;
		Employee e = null;
		try{ 
			companias = (ArrayList<Company>) DbRepository.findAll(Company.class);
			

		}catch(Exception r1){
			response.sendRedirect("../error.jsp?error="+r1.getMessage());
		}
		
		try{
			e = DbRepository.find(Employee.class, Integer.valueOf(request.getParameter("idEmployee")));	
			
		}catch(Exception r2){
			if(request.getParameter("submit2")!=null){
				response.sendRedirect("listEmployee.jsp");
			} else {
				
			response.sendRedirect("../error.jsp?error="+r2.getMessage()+"hola");
			}
		}
		if(request.getParameter("submit2")!=null){
			try{
				Date dateOfBirth=null;
				try{
					dateOfBirth = Date.valueOf(request.getParameter("dateOfBirth"));
					
				}catch(Exception r3){
					response.sendRedirect("../error.jsp?error="+r3.getMessage());
				}
				
			 	String passwordConf=null;
			 	try{
			 		passwordConf=DigestUtils.md5Hex(request.getParameter("password"));
			 	}catch(Exception r6){
			 		response.sendRedirect("../error.jsp?error="+r6.getMessage());
			 		return;
			 	}
	       
			 	e =  new Employee(request.getParameter("firstName"),
            	       request.getParameter("lastName"),
                        request.getParameter("email"),
                        request.getParameter("gender"),
                        passwordConf,
                        dateOfBirth,
                        DbRepository.lookCompany(request.getParameter("companys")));
	        
	        	DbRepository.editEntity(e);
			}catch (Exception r5){
				response.sendRedirect("../error.jsp?error="+r5.getMessage());
			}

			
		}
		
		
%>
	<div class="container px-5 my-5">
	  <div class="row justify-content-center">
	    <div class="col-lg-8">
	      <div class="card border-0 rounded-3 shadow-lg">
	        <div class="card-body p-4">
	          <div class="text-center">
	            <div class="h1 fw-light">Edit Employee</div>
	          </div>
	
	          <form method="get">
				<input type="text" class="form-control" id="firstName" name="id" placeholder="Enter First Name" value="<%=request.getParameter("idEmployee")%>" hidden>
	            <div class="form-floating mb-3">
	    			<label for="exampleInputEmail1" class="form-label">First Name</label>
	    			<input type="text" class="form-control" id="firstName" name="firstName" placeholder="Enter First Name" value="<%=e.getFirstName()%>" required>
	            </div>
	
	            <div class="form-floating mb-3">
	                <label for="exampleInputEmail1" class="form-label">Last Name</label>
	    			<input type="text" class="form-control" id="lastName" name="lastName" placeholder="Enter Last Name" value="<%=e.getLastName()%>" required>
	            </div>
	
	            <div class="form-floating mb-3">
					<label for="exampleInputEmail1" class="form-label">Email</label>
	    			<input type="email" class="form-control" id="email" name="email" placeholder="Enter Email" value="<%=e.getEmail()%>" required>
	            </div>
	            
	            <div class="form-floating mb-3">
					<label for="exampleInputEmail1" class="form-label">Gender</label>
	    			<input type="text" class="form-control" id="gender" name="gender" placeholder="Enter Gender" value="<%=e.getGender()%>" required>
	            </div>
	            
	            <div class="form-floating mb-3">
					<label for="exampleInputEmail1" class="form-label">Date of Birth</label>
	    			<input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" placeholder="Enter Date of Birth" value="<%=e.getDateOfBirth()%>" required>
	            </div>
	            <div class="form-floating mb-3">
					<label for="exampleInputEmail1" class="form-label">Company's</label>
						<select id="companys" name="companys" required>
						<%
							for (Company c : companias ){
								if(c.getId()==e.getCompany().getId()){
								%>	<option selected><%=c.getName()%></option>
								<% 
								}else{%>
						 			 <option><%=c.getName()%></option>
						 		<%}
						 	}%>
						</select>
	            </div>
	    		<div class="form-floating mb-3">
	                <label for="exampleInputEmail1" class="form-label">Password</label>
	    			<input type="password" class="form-control" id="lastName" name="password" placeholder="******" required>
	            </div>
	            <!-- Submit button -->
	            <div class="d-grid">
	              	<button class="btn btn-primary btn-lg" type="submit" value = "inma" name="submit2">Edit</button>
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