<%@page import="java.util.ArrayList"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Employee"%>
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
        ArrayList<Employee> result = null;
        try{
            result = (ArrayList<Employee>) DbRepository.findAll(Employee.class);
        }catch(Exception e){

        }
    %>

    <table class="table">
        <thread>
            <tr>
                <th scope="col">id</th>
                <th scope="col">firstName</th>
                <th scope="col">lastName</th>
                <th scope="col">email</th>
                <th scope="col">gender</th>
                <th scope="col">dateOfBirth</th>
                <th scope="col">nameCompany</th>
               
            </tr>
        </thread>
        <% for (Employee e: result){//Recorremos la lista
        %>
                <tr>
                    <td><%=e.getId()%></td>
                    <td><%=e.getFirstName()%></td>
                    <td><%=e.getLastName()%></td>
                    <td><%=e.getEmail()%></td>
                    <td><%=e.getGender()%></td>
                    <td><%=e.getDateOfBirth()%></td>
                    <td><%=e.getCompany().getName()%></td>
                    
                </tr>
        <% }%>
    </table>
</body>
</html>