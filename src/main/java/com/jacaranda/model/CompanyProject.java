package com.jacaranda.model;

import java.util.Date;
import java.util.Objects;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name="companyProject")
public class CompanyProject {
	
	@Id
	@ManyToOne
	@JoinColumn(name="idCompany")
	private Company company;
	@Id
	@ManyToOne
	@JoinColumn(name="idProject")
	private Project project;
	@Id
	private Date begin;
	
	private Date end;

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	public Date getBegin() {
		return begin;
	}

	public void setBegin(Date begin) {
		this.begin = begin;
	}

	public Date getEnd() {
		return end;
	}

	public void setEnd(Date end) {
		this.end = end;
	}

	@Override
	public int hashCode() {
		return Objects.hash(begin, company, project);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CompanyProject other = (CompanyProject) obj;
		return Objects.equals(begin, other.begin) && Objects.equals(company, other.company)
				&& Objects.equals(project, other.project);
	}
}
