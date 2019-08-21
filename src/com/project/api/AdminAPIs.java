package com.project.api;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import com.project.librarymanagement.Book;
import com.project.librarymanagement.BookManager;
import com.project.librarymanagement.User;
import com.project.librarymanagement.UserManager;

/**
 * @author vipulchasta
 *
 */
@Path("/admin")
public class AdminAPIs {

	@GET
	@Path("/getusers")
	@Produces(MediaType.APPLICATION_JSON)
	public List<User> restGetUsers() {
		return UserManager.getAllUsers();
	}

	@GET
	@Path("/getbooks")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Book> restGetBooks() {
		return BookManager.getAllBooks();
	}

	@GET
	@Path("/createuser")
	@Produces(MediaType.APPLICATION_JSON)
	public User restCreateUser(@QueryParam("username") String username, @QueryParam("password") String password,
			@QueryParam("enabled") String enabled) {
		Boolean enBool = true;
		User user = UserManager.getUserByUsername(username);
		if (user != null) {
			user.setUserId(-1);
			user.setUsername("Invalid Username Provided");
		} else {
			user = UserManager.addUser(username, password, enBool);
		}
		return user;
	}

	@Path("/createbook")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Book restCreateBook(@QueryParam("bookname") String bookname) {
		return BookManager.addBook(bookname);
	}

	@Path("/deleteuser")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public String restDeleteUser(@QueryParam("username") String username) {
		User user = UserManager.getUserByUsername(username);
		if (user == null) {
			return "{'message': 'Invalid User'}";
		}
		List<Book> books = BookManager.getBooksByUser(username);
		if (books != null && books.size() > 0) {
			return "{'message': 'User has books assigned to him, User Can't be deleted'}";
		}
		UserManager.removeUser(user);
		return "{'message': 'User Removed From Database'}";
	}

	@Path("/assignbook")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public String restAssignBook(@QueryParam("username") String username,
			@QueryParam("bookId") String bookId,
			@QueryParam("assignmentDate") String assignmentDate,
			@QueryParam("returnDate") String returnDate
			) {
		Integer bookIdInt;
		try {
			bookIdInt = Integer.parseInt(bookId);
			System.out.println("restAssignBook()=> bookIdInt: " + bookIdInt);
		} catch (Exception e) {
			return "{'message': 'BookId must be integer'}";
		}

		Book book = BookManager.getBookById(bookIdInt);
		if (book == null) {
			return "{'message': 'Book does not exist in the database'}";
		}

		if (book.getUsername() != null) {
			return "{'message': 'Book is Already Assigned to: " + book.getUsername() + "'}";
		}

		User user = UserManager.getUserByUsername(username);
		if (user == null) {
			return "{'message': 'User does not exist in the database'}";
		}

		Date dateOfAssignment;
		Date dateOfAssignmentExpire;
		try {
			System.out.println("assignmentDate: "+assignmentDate);
			System.out.println("returnDate: "+returnDate);
			dateOfAssignment = new SimpleDateFormat("yyyy-MM-dd").parse(assignmentDate);
			dateOfAssignmentExpire = new SimpleDateFormat("yyyy-MM-dd").parse(returnDate);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Exception: " + e);
			return "{'message': 'Invalid Date'}";
		}
		//TODO: both date validation
		book.setUsername(username);
		book.setDateOfAssignment(dateOfAssignment);
		book.setDateOfAssignmentExpire(dateOfAssignmentExpire);

		BookManager.updateBook(book);

		return "{'message': 'Updated User of the Book'}";
	}

	@Path("/returnbook")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public String restReturnBook(@QueryParam("bookId") String bookId) {
		Integer bookIdInt;
		try {
			bookIdInt = Integer.parseInt(bookId);
			System.out.println("restAssignBook()=> bookIdInt: " + bookIdInt);
		} catch (Exception e) {
			return "{'message': 'BookId must be integer'}";
		}

		Book book = BookManager.getBookById(bookIdInt);
		if (book == null) {
			return "{'message': 'Book does not exist in the database'}";
		}
		if (book.getUsername() == null) {
			return "{'message': 'Book is already with the library'}";
		}

		book.setUsername(null);
		book.setDateOfAssignment(null);
		book.setDateOfAssignmentExpire(null);
		BookManager.updateBook(book);

		return "{'message': 'Book returned to the library'}";
	}

	@Path("/deletebook")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public String restRemoveBook(@QueryParam("bookId") String bookId) {
		Integer bookIdInt;
		try {
			bookIdInt = Integer.parseInt(bookId);
			System.out.println("restAssignBook()=> bookIdInt: " + bookIdInt);
		} catch (Exception e) {
			return "{'message': 'BookId must be integer'}";
		}
		Book book = BookManager.getBookById(bookIdInt);
		if (book == null) {
			return "{'message': 'Book does not exist in the database'}";
		}
		if (book.getUsername() != null) {
			return "{'message': 'Book is assigned to: " + book.getUsername() + ", return to library before deleting}";
		}

		BookManager.removeBook(book);
		return "{'message': 'Book Removed From Database'}";
	}

	@GET
	@Produces(MediaType.TEXT_HTML)
	public String defaultRoute() {
		return "Not Supported";
	}

	@POST
	@Produces(MediaType.TEXT_HTML)
	public String defaultRoutePOST() {
		return "Not Supported";
	}
}
