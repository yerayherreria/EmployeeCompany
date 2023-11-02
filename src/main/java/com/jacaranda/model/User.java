package com.jacaranda.model;

import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="User")
public class User {
	
	@Id
	@Column(name="user")
	private String userr;
	private String password;
	private String role;
	
	public User(String user, String password, String role) {
		super();
		this.userr = user;
		this.password = password;
		this.role = role;
	}
	
	public User() {
		super();
	}

	public String getUser() {
		return userr;
	}

	public void setUser(String user) {
		this.userr = user;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRole() {
		return role;
	}

	@Override
	public int hashCode() {
		return Objects.hash(userr);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		return Objects.equals(userr, other.userr);
	}

	public void setRole(String role) {
		this.role = role;
	}
}
