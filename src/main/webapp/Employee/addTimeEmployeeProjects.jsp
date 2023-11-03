<%@page import="com.jacaranda.model.EmployeeProject"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.chrono.ChronoLocalDateTime"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.Date"%>
<%@page import="com.jacaranda.model.CompanyProject"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jacaranda.model.Project"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Add Time</title>
</head>
<body>
	<%if(session.getAttribute("rol")!=null){ 
		Employee e;
		ArrayList<Project> p;
		try{
			p = (ArrayList<Project>) DbRepository.findAll(Project.class);
			e = (Employee) session.getAttribute("employee");
		}catch(Exception r){
			response.sendRedirect(".././error.jsp?error="+r.getMessage());
			return;
		}
	
	%>
	<%@include file=".././nav.jsp"%>
		<div class="container px-5 my-5">
		  <div class="row justify-content-center">
		    <div class="col-lg-8">
		      <div class="card border-0 rounded-3 shadow-lg">
		        <div class="card-body p-4">
		          <div class="text-center">
		            <div class="h1 fw-light">Add Time Project</div>
		          </div>
				
		          <form method="get">
	
		            <div class="form-floating mb-3">
		    			<label for="exampleInputEmail1" class="form-label">Company</label>
		    			<input type="text" class="form-control" id="user" name="user" placeholder="Enter Id" value="<%=e.getCompany().getName() %>" readonly>
		            </div>
		
		            <div class="form-floating mb-3">
		                <label for="exampleInputEmail1" class="form-label">Project</label>
		    			<select id="companys" name="projects" required>
						<%
							for (CompanyProject c : e.getCompany().getCompanyProject()){
								if(c.getEnd().after(Date.valueOf(LocalDate.now()))){%>
						 			 <option value="<%=c.getProject().getId()%>"><%=c.getProject().getName()%></option>							
						 		<%
								}
							
							
						 	}%>
						</select>
		    	
		            </div>
		
		            <%if(request.getParameter("start")==null){%>
			            <div class="d-grid">
			              	<button class="btn btn-primary btn-lg" id="submitButton" type="submit" name="start">Start</button>
			            </div>		            	
		            <%} else {
		            	session.setAttribute("time", LocalDateTime.now());
		            	session.setAttribute("sec", 0);
		            	%>
		            	<div class="d-grid">
			              	<button class="btn btn-primary btn-lg" id="submitButton" type="submit" name="stop">Stop</button>
			            </div>
		     		<%}
		     		if(session.getAttribute("time")!=null && request.getParameter("stop")!=null){
		     			session.setAttribute("sec", (int) ChronoUnit.SECONDS.between((LocalDateTime) session.getAttribute("time"), LocalDateTime.now()));
		     			
		     			out.println(session.getAttribute("sec"));%>
		     			
		     			<div class="d-grid">
			              	<button class="btn btn-primary btn-lg" id="submitButton" type="submit" name="save">Save</button>
			            </div>
		     		<%} if(request.getParameter("save")!=null){
		     			EmployeeProject ep;
		     			
		     			try{
		     				int sec = (int) session.getAttribute("sec");
		     				int min = sec*60;
		     				ep = new EmployeeProject(e,DbRepository.find(Project.class,Integer.valueOf(request.getParameter("projects"))),min);
		     				
		     				if(DbRepository.find(ep)!=null){
		     					ep.setTime(DbRepository.find(ep).getTime()+min);
			     				DbRepository.editEntity(ep);
		     				} else {
			     				DbRepository.addEntity(ep);
		     					
		     				}
		     				
		     			}catch(Exception r){
		     				response.sendRedirect(".././error.jsp?error="+r.getMessage());
		     				return;
		     			}
			     		session.removeAttribute("time");
			     		session.removeAttribute("sec");
		     		}
		     		%>     		
		          </form>
		        
		          <!-- End of contact form -->
		        </div>
		      </div>
		    </div>
		  </div>
		</div>
        
		<%	
        } else {
        	response.sendRedirect(".././index.jsp");
        }
		%>
    </table>
</body>
</html>