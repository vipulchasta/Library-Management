package com.project.librarymanagement;

import java.util.Date;

import javax.xml.bind.annotation.XmlRootElement;

/**
 * @author vipulchasta
 *
 */
@XmlRootElement(name = "Book")
public class Book {

	int id;
	String bookname;
	Date dateOfAddition = new Date(System.currentTimeMillis());
	Date dateOfAssignment = null;
	Date dateOfAssignmentExpire = null;
	String username = null;

	public Book() {
	}

	public Book(String bookname) {
		this.bookname = bookname;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getBookname() {
		return bookname;
	}

	public void setBookname(String bookname) {
		this.bookname = bookname;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Date getDateOfAddition() {
		return dateOfAddition;
	}

	public void setDateOfAddition(Date dateOfAddition) {
		this.dateOfAddition = dateOfAddition;
	}

	public Date getDateOfAssignment() {
		return dateOfAssignment;
	}

	public void setDateOfAssignment(Date dateOfAssignment) {
		this.dateOfAssignment = dateOfAssignment;
	}

	public Date getDateOfAssignmentExpire() {
		return dateOfAssignmentExpire;
	}

	public void setDateOfAssignmentExpire(Date dateOfAssignmentExpire) {
		this.dateOfAssignmentExpire = dateOfAssignmentExpire;
	}

}
