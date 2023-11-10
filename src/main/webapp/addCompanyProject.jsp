<%@page import="com.jacaranda.model.CompanyProject"%>
<%@page import="com.jacaranda.model.Project"%>
<%@page import="com.jacaranda.model.Company"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Date"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Employee"%>
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
		ArrayList<Company> companies = null;
		ArrayList<Project> projects = null;
			try{
				companies = (ArrayList<Company>) DbRepository.findAll(Company.class);
				projects = (ArrayList<Project>) DbRepository.findAll(Project.class);
			}catch(Exception e){
				response.sendRedirect("error.jsp?error="+e.getMessage());
				return;
			}
	%>
	
<body>
	<div class="container px-5 my-5">
	  <div class="row justify-content-center">
	    <div class="col-lg-8">
	      <div class="card border-0 rounded-3 shadow-lg">
	        <div class="card-body p-4">
	          <div class="text-center">
	            <div class="h1 fw-light">Add CompanyProject</div>
	          </div>
	
	          <form method="get">
				  <div class="form-floating mb-3">
					<label for="exampleInputEmail1" class="form-label">Company's</label>
						<select id="companys" name="companys" required>
						<%
							for (Company c : companies ){
						%>
						  <option value="<%=c.getId()%>"><%=c.getName()%></option>
						 <%}%>
						</select>
	           		</div>
					<div class="form-floating mb-3">
						<label for="exampleInputEmail1" class="form-label">Projects</label>
							<select id="projects" name="projects" required>
							<%
								for (Project p : projects ){
							%>
							  <option value="<%=p.getId()%>"><%=p.getName()%></option>
							 <%}%>
							</select>
	           		</div>
		            <div class="form-floating mb-3">
						<label for="exampleInputEmail1" class="form-label">Date begin</label>
		    			<input type="date" class="form-control" id="dateBegin" name="dateBegin" placeholder="Enter Date Begin" required>
		            </div>
		            <div class="form-floating mb-3">
						<label for="exampleInputEmail1" class="form-label">Date end</label>
		    			<input type="date" class="form-control" id="dateEnd" name="dateEnd" placeholder="Enter Date End" required>
		            </div>
	           
	            <!-- Submit button -->
	            <div class="d-grid">
	              	<button class="btn btn-primary btn-lg" id="submitButton" type="submit" name="submit">Save</button>
	            </div>
	         <%
				if (request.getParameter("submit") != null) {
				   	Company company = DbRepository.find(Company.class, Integer.valueOf(request.getParameter("companys")));
				   	Project project = DbRepository.find(Project.class, Integer.valueOf(request.getParameter("projects")));
				   	
				   	Date begin=null;
				   	Date end=null;
				   	
				   	try{
				   		begin= Date.valueOf(request.getParameter("dateBegin"));
				   		end= Date.valueOf(request.getParameter("dateEnd"));
				   	}catch(Exception e){
				   		response.sendRedirect("error.jsp?error="+e.getMessage());
						return;
				   	}
				   	
				   	CompanyProject cp = new CompanyProject(company,project,begin,end);
				   	
				    DbRepository.addEntity(cp);
				 
				}
				%>

	          </form>
	          <!-- End of contact form -->
	        </div>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>