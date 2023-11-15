package com.jacaranda.repository;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.query.NativeQuery;

import com.jacaranda.model.Employee;
import com.jacaranda.model.EmployeeProject;
import com.jacaranda.utility.DBUtility;

public class EmployeeRepository extends DbRepository{
	public static ArrayList<EmployeeProject> getEmployeeProjects(Integer idEmployee) throws Exception{
		ArrayList<EmployeeProject> listEmployeeProject = null;
		Session session = null;
		if(idEmployee==null) {
			throw new Exception("No hay id de empleado");
		}
		try {
			session = DBUtility.getSessionFactory().openSession();
			
			NativeQuery<EmployeeProject> queryEmployeeProject = session.createNativeQuery("Select * from employeeProject where idProject = ?1",EmployeeProject.class);
			queryEmployeeProject.setParameter(1,idEmployee);
			
			listEmployeeProject = (ArrayList<EmployeeProject>) queryEmployeeProject.getResultList();
		
		} catch (Exception e) {
			session.close();
			throw new Exception("Error al conectar con la base de datos. "+e.getMessage());
		}
		session.close();
		return listEmployeeProject;
	}
	
	public static void delete(Employee employee) {
		if(employee==null) {
			
		}
	}
}
