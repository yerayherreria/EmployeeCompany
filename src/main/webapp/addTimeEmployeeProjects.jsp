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
<link rel="stylesheet" href="./style/styleNav.css">
<title>Add Time</title>
</head>
<body>
	<%if(session.getAttribute("rol")!=null){ 
		Employee e;
		ArrayList<Project> p;
		int idProjectSelect=0;
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
					<%if(request.getParameter("start")==null && session.getAttribute("time") == null) {
						%>						
			            <div class="form-floating mb-3">
			                <label for="exampleInputEmail1" class="form-label">Project</label>
			    			<select id="companys" name="projects" required>
							<%
								for (CompanyProject c : e.getCompany().getCompanyProject()){
									if(c.getEnd().after(Date.valueOf(LocalDate.now()))){
																			
										%>
								 			 <option value="<%=c.getProject().getId()%>"><%=c.getProject().getName()%></option>							
								 		<%
										
									}
							
							 	}%>
							</select>
			    	
			            </div>
			            <%
					}else if(request.getParameter("start") != null || session.getAttribute("time") != null) {
		            	if(session.getAttribute("project") == null){
			            	session.setAttribute("project", DbRepository.find(Project.class, Integer.valueOf(request.getParameter("projects"))));
		            	}
		            %>
			            <div class="form-floating mb-3">
							<label for="exampleInputEmail1" class="form-label">Project</label>
			            	<input type="text" class="form-control" id="idProject" name="projectId" value="<%=((Project)session.getAttribute("project")).getId()%>" hidden>
			    			<input type="text" class="form-control" id="project" name="project" value="<%=((Project)session.getAttribute("project")).getName()%>" readonly>
			            </div>
		            <%}%>
					
						 
		            <%if(request.getParameter("start")==null && session.getAttribute("time")==null){%>
			            <div class="d-grid">
			              	<button class="btn btn-primary btn-lg" id="submitButton" type="submit" name="start">Start</button>
			            </div>		            	
		            <%
		            } else {
		            	if(session.getAttribute("time")==null){
			            	session.setAttribute("time", LocalDateTime.now());	            			            		
		            	}
		            	%>
		            	<%if(request.getParameter("stop") == null) {%>
		            	<div class="d-grid">
			              	<button class="btn btn-primary btn-lg" id="submitButton" type="submit" name="stop">Stop</button>
			            </div>		            	
			            <%}%>
		     		<%}
		     		if(session.getAttribute("time")!=null && request.getParameter("stop")!=null){
		     			if(session.getAttribute("sec")==null){
		     				session.setAttribute("sec", 0);
		     			}
		     			
		     			session.setAttribute("sec",(int) session.getAttribute("sec") +(int) ChronoUnit.SECONDS.between((LocalDateTime) session.getAttribute("time"), LocalDateTime.now()));
		     			session.removeAttribute("time");
		     			out.println(session.getAttribute("sec"));%>
		     			
		     			<div class="d-grid">
			              	<button class="btn btn-primary btn-lg" id="submitButton" type="submit" name="save">Save</button>
			            </div>
			            
		     		<%} if(request.getParameter("save")!=null){
		     			Project p2;
		     			try{
		     				p2 = DbRepository.find(Project.class,Integer.valueOf(request.getParameter("projectId")));
		     				
		     				
		     			}catch(Exception r){
		     				response.sendRedirect(".././error.jsp?error="+r.getMessage());
		     				return;
		     			}
		     			
		     			EmployeeProject ep;
		     			int min=0;
		     			try{
		     				int sec = (int) session.getAttribute("sec");
		     				min = sec;
		     				ep = new EmployeeProject(e,p2,min);
		     				
		     				
		     			}catch(Exception r){
		     				response.sendRedirect(".././error.jsp?error="+r.getMessage());
		     				return;
		     			}
		     			
	     				if(DbRepository.find(ep)!=null){
	     					ep.setTime(DbRepository.find(ep).getTime()+min);
		     				DbRepository.editEntity(ep);
	     				} else {
		     				DbRepository.addEntity(ep);
	     					
	     				}
			     		session.removeAttribute("sec");
			     		session.removeAttribute("project");
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
        	response.sendRedirect("./index.jsp");
        }
		%>
    </table>
</body>
</html>