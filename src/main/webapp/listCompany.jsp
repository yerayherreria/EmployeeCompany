<%@page import="java.util.ArrayList"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Company"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.model.CompanyProject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<% //Inicializamos una lista con todas las tareas
        ArrayList<Company> result = null;
        try{
            result = (ArrayList<Company>) DbRepository.findAll(Company.class);
            ArrayList<CompanyProject> resultAux = (ArrayList<CompanyProject>) DbRepository.findAll(CompanyProject.class);
        }catch(Exception e){

        }
    %>

    <table class="table">
        <thread>
            <tr>
                <th scope="col">Name</th>
                <th scope="col">Num Employee</th>
                <th scope="col">Num Project</th>
                <th scope="col">Employees</th>
				<th scope="col">Projects</th>
            </tr>
        </thread>
        <% for (Company c: result){//Recorremos la lista%>
                <tr>
                    <td><%=c.getName()%></td>
                    <td><%=c.getEmployees().size()%></td>
                    <td><%=c.getCompanyProject().size()%></td>
                    <td>
	                    <table class="table">
		                    <thread>
					            <tr>
					                <th scope="col">Id</th>
					                <th scope="col">Name</th>
					                <th scope="col">Last Name</th>
					            </tr>
					        </thread>
		                    <%for(Employee e : c.getEmployees()) {%>           		
							        <tr>
							        	<td><%=e.getId()%></td>
							       
							        	<td><%=e.getFirstName()%></td>
							        
							        	<td><%=e.getLastName()%></td>
							        </tr>
		                	<%}%>
		                </table>
	               	</td>
	               	<td>
	                    <table class="table">
		                    <thread>
					            <tr>
					                <th scope="col">Id</th>
					                <th scope="col">Name</th>
					                <th scope="col">Butget</th>
					            </tr>
					        </thread>
		                    <%for(CompanyProject cp : c.getCompanyProject()) {%>           		
							        <tr>
							        	<td><%=cp.getProject().getId()%></td>
							       
							        	<td><%=cp.getProject().getName()%></td>
							        
							        	<td><%=cp.getProject().getButget()%></td>
							        </tr>
		                	<%}%>
		                </table>
	               	</td>
                </tr>
                <tr>
                </tr>
        <% }%>
    </table>
</body>
</html>