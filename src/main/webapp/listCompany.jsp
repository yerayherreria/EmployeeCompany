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
                <th scope="col">id</th>
                <th scope="col">name</th>
                <th scope="col">address</th>
                <th scope="col">city</th>
                <th scope="col">employees</th>
               
               
            </tr>
        </thread>
        <% for (Company c: result){//Recorremos la lista
        %>
                <tr>
                    <td><%=c.getId()%></td>
                    <td><%=c.getName()%></td>
                    <td><%=c.getAddress()%></td>
                    <td><%=c.getCity()%></td>
                    <td><%=c.getEmployees().size()%></td>
                    <td><table class="table"><%for(Employee e : c.getEmployees()) {%>           		
             
					        <tr>
					        	<td><%=e.getFirstName()%></td>
					        </tr>
                	<% }%></table></td>
                </tr>
        <% }%>
    </table>
</body>
</html>