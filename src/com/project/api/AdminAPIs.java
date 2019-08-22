package com.project.api;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.project.librarymanagement.Book;
import com.project.librarymanagement.BookManager;
import com.project.librarymanagement.ClientResponse;
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

	@POST
	@Path("/createuser/{username}/{password}/{enabled}")
	@Produces(MediaType.APPLICATION_JSON)
	public User restCreateUser(@PathParam("username") String username, @PathParam("password") String password,
			@PathParam("enabled") String enabled) {
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

	@POST
	@Path("/createbook/{bookname}")
	@Produces(MediaType.APPLICATION_JSON)
	public Book restCreateBook(@PathParam("bookname") String bookname) {
		return BookManager.addBook(bookname);
	}

	@DELETE
	@Path("/deleteuser/{username}")
	@Produces(MediaType.APPLICATION_JSON)
	public ClientResponse restDeleteUser(@PathParam("username") String username) {

		ClientResponse clientResponse = new ClientResponse();
		User user = UserManager.getUserByUsername(username);

		if (user == null) {
			clientResponse.setMessage("Invalid User");
			return clientResponse;
		}

		List<Book> books = BookManager.getBooksByUser(username);
		if (books != null && books.size() > 0) {
			clientResponse.setMessage("User has books assigned to him, User Can't be deleted");
			return clientResponse;
		}

		UserManager.removeUser(user);
		clientResponse.setSuccess(true);
		clientResponse.setMessage("User Removed From Database");

		return clientResponse;
	}

	@PUT
	@Path("/assignbook/{bookId}/{username}/{assignmentDate}/{returnDate}")
	@Produces(MediaType.APPLICATION_JSON)
	public ClientResponse restAssignBook(@PathParam("bookId") String bookId, @PathParam("username") String username,
			@PathParam("assignmentDate") String assignmentDate, @PathParam("returnDate") String returnDate) {

		ClientResponse clientResponse = new ClientResponse();
		Integer bookIdInt;

		try {
			bookIdInt = Integer.parseInt(bookId);
			System.out.println("restAssignBook()=> bookIdInt: " + bookIdInt);
		} catch (Exception e) {
			clientResponse.setMessage("BookId must be integer");
			return clientResponse;
		}

		Book book = BookManager.getBookById(bookIdInt);
		if (book == null) {
			clientResponse.setMessage("Book does not exist in the database");
			return clientResponse;
		}

		if (book.getUsername() != null) {
			clientResponse.setMessage("Book is Already Assigned to: " + book.getUsername());
			return clientResponse;
		}

		User user = UserManager.getUserByUsername(username);
		if (user == null) {
			clientResponse.setMessage("User does not exist in the database");
			return clientResponse;
		}

		Date dateOfAssignment;
		Date dateOfAssignmentExpire;
		try {
			System.out.println("assignmentDate: " + assignmentDate);
			System.out.println("returnDate: " + returnDate);
			dateOfAssignment = new SimpleDateFormat("yyyy-MM-dd").parse(assignmentDate);
			dateOfAssignmentExpire = new SimpleDateFormat("yyyy-MM-dd").parse(returnDate);
		} catch (Exception e) {
			e.printStackTrace();
			clientResponse.setMessage("Invalid Date");
			return clientResponse;
		}
		// TODO: both date validation
		book.setUsername(username);
		book.setDateOfAssignment(dateOfAssignment);
		book.setDateOfAssignmentExpire(dateOfAssignmentExpire);

		BookManager.updateBook(book);

		clientResponse.setMessage("Updated User of the Book");
		clientResponse.setSuccess(true);
		return clientResponse;
	}

	@PUT
	@Path("/returnbook/{bookId}")
	@Produces(MediaType.APPLICATION_JSON)
	public ClientResponse restReturnBook(@PathParam("bookId") String bookId) {
		ClientResponse clientResponse = new ClientResponse();
		Integer bookIdInt;

		try {
			bookIdInt = Integer.parseInt(bookId);
			System.out.println("restAssignBook()=> bookIdInt: " + bookIdInt);
		} catch (Exception e) {
			clientResponse.setMessage("BookId must be integer");
			return clientResponse;
		}

		Book book = BookManager.getBookById(bookIdInt);
		if (book == null) {
			clientResponse.setMessage("Book does not exist in the database");
			return clientResponse;
		}
		if (book.getUsername() == null) {
			clientResponse.setMessage("Book is already with the library");
			return clientResponse;
		}

		book.setUsername(null);
		book.setDateOfAssignment(null);
		book.setDateOfAssignmentExpire(null);
		BookManager.updateBook(book);

		clientResponse.setSuccess(true);
		clientResponse.setMessage("Book returned to the library");
		return clientResponse;
	}

	@DELETE
	@Path("/deletebook/{bookId}")
	@Produces(MediaType.APPLICATION_JSON)
	public ClientResponse restRemoveBook(@PathParam("bookId") String bookId) {
		ClientResponse clientResponse = new ClientResponse();
		Integer bookIdInt;

		try {
			bookIdInt = Integer.parseInt(bookId);
			System.out.println("restAssignBook()=> bookIdInt: " + bookIdInt);
		} catch (Exception e) {
			clientResponse.setMessage("BookId must be integer");
			return clientResponse;
		}
		Book book = BookManager.getBookById(bookIdInt);
		if (book == null) {
			clientResponse.setMessage("Book does not exist in the database");
			return clientResponse;
		}
		if (book.getUsername() != null) {
			clientResponse
					.setMessage("Book is assigned to: " + book.getUsername() + ", return to library before deleting");
			return clientResponse;
		}

		BookManager.removeBook(book);
		clientResponse.setSuccess(true);
		clientResponse.setMessage("Book Removed From Database");
		return clientResponse;
	}

}
