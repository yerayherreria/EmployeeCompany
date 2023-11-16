<%@page import="org.hibernate.internal.build.AllowSysOut"%>
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
<title>Edit Employee</title>
</head>
<body>
	<%@include file="./nav.jsp"%>
	
	<%
	ArrayList<Company> companias = null;
	Employee e = null; 
	Employee e3 = (Employee) session.getAttribute("employee");
	if(session.getAttribute("check")==null){
		session.setAttribute("check", "false");
	}
	%>
	
	<%if(session.getAttribute("rol")!=null){ %>
		<%
		try{ 
			companias = (ArrayList<Company>) DbRepository.findAll(Company.class);
			
		}catch(Exception r1){
			response.sendRedirect("./error.jsp?error="+r1.getMessage());
			return;
		}
		
		try{
			e = DbRepository.find(Employee.class, Integer.valueOf(request.getParameter("idEmployee")));	
			
		}catch(Exception r2){
			response.sendRedirect("./error.jsp?error="+r2.getMessage());
			return;
		} 
		
		%>
		<%if(session.getAttribute("rol").equals("admin") || session.getAttribute("check").equals("true")) {%>
			
			<div class="container px-5 my-5">
			  <div class="row justify-content-center">
			    <div class="col-lg-8">
			      <div class="card border-0 rounded-3 shadow-lg">
			        <div class="card-body p-4">
			          <div class="text-center">
			            <div class="h1 fw-light">Edit Employee</div>
			          </div>
			
			          <form method="get">
						<input type="text" class="form-control" id="firstName" name="idEmployee" placeholder="Enter First Name" value="<%=request.getParameter("idEmployee")%>" hidden>
			            <div class="form-floating mb-3">
			    			<label for="exampleInputEmail1" class="form-label">First Name</label>
			    			<input type="text" class="form-control" id="firstName" name="firstName" placeholder="Enter First Name" value="<%=e.getFirstName()%>" required>
			            </div>
			
			            <div class="form-floating mb-3">
			                <label for="exampleInputEmail1" class="form-label">Last Name</label>
			    			<input type="text" class="form-control" id="lastName" name="lastName" placeholder="Enter Last Name" value="<%=e.getLastName()%>" required>
			            </div>
						<%if(session.getAttribute("rol").equals("admin")) {%>
				            <div class="form-floating mb-3">
								<label for="exampleInputEmail1" class="form-label">Email</label>
				    			<input type="email" class="form-control" id="email" name="email" placeholder="Enter Email" value="<%=e.getEmail()%>" required>
				            </div>						
						<%}else{ %>
							<div class="form-floating mb-3">
								<label for="exampleInputEmail1" class="form-label">Email</label>
				    			<input type="email" class="form-control" id="email" name="email" placeholder="Enter Email" value="<%=e.getEmail()%>" readonly>
				            </div>
						<%} %>
			            
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
			    			<input type="password" class="form-control" id="lastName" name="password" value="******" placeholder="Enter Password" required>
			            </div>
			             <div class="form-floating mb-3">
			                <label for="exampleInputEmail1" class="form-label">Confirm Password</label>
			    			<input type="password" class="form-control" id="lastName" name="passwordConfirm" value="******" placeholder="Enter Confirm Password" required>
			            </div>
			            
			            <%if(session.getAttribute("rol").equals("admin")) {%>
				           <div class="form-floating mb-3">
				                <label for="exampleInputEmail1" class="form-label">Confirm Password</label>
				    			<input type="text" class="form-control" id="role" name="role" value="<%=e.getRole() %>" required>
				            </div>					
						<%}else{ %>
							 <div class="form-floating mb-3">
				                <label for="exampleInputEmail1" class="form-label">Confirm Password</label>
				    			<input type="text" class="form-control" id="role" name="role" value="<%=e.getRole() %>" readonly>
				            </div>
						<%} %>
			        
			            <!-- Submit button -->
			            <div class="d-grid">
			              	<button class="btn btn-primary btn-lg" type="submit" name="edit">Edit</button>
			              	<%if(request.getParameter("edit") != null) {%>
			              		<a href="./listEmployee.jsp"><button class="btn btn-danger btn-lg" id="list" value="list" type="button" name="list">Return List</button></a>
			              	<%} %>
			            </div>
			          </form>
			          <!-- End of contact form -->
			        </div>
			      </div>
			    </div>
			  </div>
			</div>
		<%} else { %>
			<div class="container px-5 my-5">
				  <div class="row justify-content-center">
				    <div class="col-lg-8">
				      <div class="card border-0 rounded-3 shadow-lg">
				        <div class="card-body p-4">
				          <div class="text-center">
				            <div class="h1 fw-light">Enter password</div>
				          </div>
				          <form method="get">
				    		<input type="text" class="form-control" id="firstName" name="idEmployee" placeholder="Enter First Name" value="<%=request.getParameter("idEmployee")%>" hidden>
				    		<div class="form-floating mb-3">
				                <label for="exampleInputEmail1" class="form-label">Password</label>
				    			<input type="password" class="form-control" id="lastName" name="password" placeholder="******" required>
				            </div>
				            <!-- Submit button -->
				            <div class="d-grid">
				              	<button class="btn btn-primary btn-lg" type="submit" value = "checkPass" name="checkPass">Check</button>
				            </div>
				          </form>
				          <!-- End of contact form -->
				        </div>
				      </div>
				    </div>
				  </div>
				</div>
			<%if(request.getParameter("checkPass")!=null && DigestUtils.md5Hex(request.getParameter("password")).equals(e3.getPassword())){
				session.setAttribute("check", "true");
			}%>
		<%} %>
		<%if(request.getParameter("edit")!=null){
				try{
					Date dateOfBirth=null;
					try{
						dateOfBirth = Date.valueOf(request.getParameter("dateOfBirth"));
						
					}catch(Exception r3){
						response.sendRedirect("./error.jsp?error="+r3.getMessage());
					}
					
					String passwordConf=null;
					if(!request.getParameter("password").equals("******")){
					    try{
						    if(request.getParameter("password").equals(request.getParameter("passwordConfirm"))){
						    	passwordConf = DigestUtils.md5Hex(request.getParameter("password"));
						    }		    	
					    }catch(Exception ex4){
					    	response.sendRedirect(".././error.jsp?error="+ex4.getMessage());
				 			 return;
					    }
					} else {
						passwordConf=e.getPassword();
					}
		       
				 	e =  new Employee(Integer.valueOf(request.getParameter("idEmployee")),
				 			request.getParameter("firstName"),
	            	        request.getParameter("lastName"),
	                        request.getParameter("email"),
	                        request.getParameter("gender"),
	                        passwordConf,
	                        request.getParameter("role"),
	                        dateOfBirth,
	                        DbRepository.lookCompany(request.getParameter("companys")));
		        
		        	DbRepository.editEntity(e);
				}catch (Exception r5){
					response.sendRedirect("./error.jsp?error="+r5.getMessage());
				}
	
				
			}
		 %>
	<%}else{
		response.sendRedirect("./index.jsp");
		return;
	} %>
</body>

</html>