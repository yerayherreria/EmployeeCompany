<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
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
<title>Add Time Other Projects</title>
</head>
<body>
	<%
	if(session.getAttribute("rol")!=null){ 
		Map<Integer,LocalDateTime> projectsMapeo=null;
		try {
			if(session.getAttribute("projectsMapeo")==null){
				projectsMapeo = new HashMap<Integer,LocalDateTime>();			
			} else {
				projectsMapeo = (HashMap<Integer,LocalDateTime>) session.getAttribute("projectsMapeo");
			}
		
		} catch (Exception r1){
			response.sendRedirect(".././error.jsp?error="+r1.getMessage());
		}
		
		Employee e;
		try{
			e = (Employee) session.getAttribute("employee");
			
		}catch(Exception r2){
			response.sendRedirect(".././error.jsp?error="+r2.getMessage());
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
		            <div class="h1 fw-light">Add Time Other Projects</div>
		          </div>
					<%
					if(request.getParameter("start")!=null){
						projectsMapeo.put(Integer.valueOf(request.getParameter("start")),LocalDateTime.now());
						session.setAttribute("projectsMapeo", projectsMapeo);
					
					} else if(request.getParameter("stop")!=null){
						int sec = (int) ChronoUnit.SECONDS.between(projectsMapeo.get(Integer.valueOf(request.getParameter("stop"))), LocalDateTime.now());
						
						Project p2;
		     			try{
		     				p2 = DbRepository.find(Project.class,Integer.valueOf(request.getParameter("stop")));

		     			}catch(Exception r){
		     				response.sendRedirect(".././error.jsp?error="+r.getMessage());
		     				return;
		     			}
		     			
		     			EmployeeProject ep;
		     			try{
		     				ep = new EmployeeProject(e,p2,sec);
		     				
		     			}catch(Exception r){
		     				response.sendRedirect(".././error.jsp?error="+r.getMessage());
		     				return;
		     			}
		     			
	     				if(DbRepository.find(ep)!=null){
	     					ep.setTime(DbRepository.find(ep).getTime()+sec);
		     				DbRepository.editEntity(ep);
	     				} else {
		     				DbRepository.addEntity(ep);
	     					
	     				}
						
	     				projectsMapeo.remove(Integer.valueOf(request.getParameter("stop")));
	     				session.setAttribute("projectsMapeo", projectsMapeo);
		     		}
					%> 
				
		          <form method="get">
	
		            <div class="form-floating mb-3">
		    			<label for="exampleInputEmail1" class="form-label">Company</label>
		    			<input type="text" class="form-control" id="user" name="user" placeholder="Enter Id" value="<%=e.getCompany().getName() %>" readonly>
		            </div>					
			            <div class="form-floating mb-3">
			                <table class="table">
								<%
									for (CompanyProject c : e.getCompany().getCompanyProject()){
										if(c.getEnd().after(Date.valueOf(LocalDate.now()))){
											%>
											<tr>
												<td><%=c.getProject().getName()%></td>
												<%if(!projectsMapeo.containsKey(c.getProject().getId())){ %>
													<td><button class="btn btn-primary" type="submit" name="start" value="<%=c.getProject().getId()%>">Start</button></td>  		
												<%}else{%>
													<td><button class="btn btn-danger" type="submit" value="<%=c.getProject().getId()%>" name="stop">Stop</button></td>  													
												<%}%>
											</tr>
									 		<%
										}
								 	}%>			                
			                </table>
			            </div>
		      
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