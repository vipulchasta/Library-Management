package com.project.librarymanagement;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "User")
public class User {

	int userId;
	String username;
	String password;
	Boolean enabled;
	String role = "ROLE_USER";

	public User() {

	}

	public User(String username2, String password2, boolean enabled2) {
		this.username = username2;
		this.password = password2;
		this.enabled = enabled2;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

}
