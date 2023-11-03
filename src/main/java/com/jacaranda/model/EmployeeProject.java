package com.jacaranda.model;

import java.util.Objects;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="employeeProject")
public class EmployeeProject {
	
	@Id
	private int idEmployee;
	@Id
	private int idProject;
	private int time;
	
	public EmployeeProject(int idEmployee, int idProject, int time) {
		super();
		this.idEmployee = idEmployee;
		this.idProject = idProject;
		this.time = time;
	}
	public EmployeeProject() {
		super();
	}
	
	public int getIdEmployee() {
		return idEmployee;
	}
	public void setIdEmployee(int idEmployee) {
		this.idEmployee = idEmployee;
	}
	public int getIdProject() {
		return idProject;
	}
	public void setIdProject(int idProject) {
		this.idProject = idProject;
	}
	public int getTime() {
		return time;
	}
	public void setTime(int time) {
		this.time = time;
	}
	
	@Override
	public int hashCode() {
		return Objects.hash(idEmployee, idProject);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		EmployeeProject other = (EmployeeProject) obj;
		return idEmployee == other.idEmployee && idProject == other.idProject;
	}
}
