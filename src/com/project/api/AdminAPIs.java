package com.project.api;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.project.exceptions.ExBookIsNotWithLibrary;
import com.project.exceptions.ExBookNotFound;
import com.project.exceptions.ExInvalidBook;
import com.project.exceptions.ExInvalidUser;
import com.project.exceptions.ExUserHasBook;
import com.project.exceptions.ExUserNotFound;
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
	@Path("/Users")
	@Produces(MediaType.APPLICATION_JSON)
	public List<User> restGetUsers() {

		List<User> users = UserManager.getAllUsers();

		return users;
	}

	@GET
	@Path("/Books")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Book> restGetBooks() {

		List<Book> books = BookManager.getAllBooks();

		return books;
	}

	/*
	 * ************************************************************************
	 * ********************* API Implementation For User **********************
	 * ************************************************************************
	 */

	@GET
	@Path("/User/{username}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public User restGetUser(@PathParam("username") String username) {
		User user = UserManager.getUserByUsername(username);

		if (null == user) {
			throw new ExUserNotFound();
		}

		return user;
	}

	@PUT
	@Path("/User/{username}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public User restUpdateUser(@PathParam("username") String username, User user) {

		User dbUser = UserManager.getUserByUsername(username);

		if (null == dbUser) {
			throw new ExUserNotFound();
		}

		// TODO: both date validation
		UserManager.updateUser(user);

		return user;
	}

	@POST
	@Path("/User/{username}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public User restCreateUser(@PathParam("username") String username, User user) {

		Boolean enBool = true;
		User dbUser = UserManager.getUserByUsername(username);

		if (null != dbUser) {
			throw new ExInvalidUser();
		}

		// TODO: Username Validation, It should not be 'null', 'admin', 'system' etc
		// TODO: Password Validation
		user = UserManager.addUser(username, user.getPassword(), enBool);

		if (null == user) {
			throw new ExInvalidUser();
		}

		return user;
	}

	@DELETE
	@Path("/User/{username}")
	@Produces(MediaType.APPLICATION_JSON)
	public User restDeleteUser(@PathParam("username") String username) {

		User dbUser = UserManager.getUserByUsername(username);

		if (dbUser == null) {
			throw new ExUserNotFound();
		}

		List<Book> books = BookManager.getBooksByUser(username);
		if (books != null && books.size() > 0) {
			throw new ExUserHasBook();
		}

		UserManager.removeUser(dbUser);

		return dbUser;
	}

	/*
	 * ************************************************************************
	 * ********************* API Implementation For Book **********************
	 * ************************************************************************
	 */

	@GET
	@Path("/Book/{bookId}")
	@Produces(MediaType.APPLICATION_JSON)
	public Book restGetBook(@PathParam("bookId") Integer bookId) {

		Book book = BookManager.getBookById(bookId);

		if (null == book) {
			throw new ExBookNotFound();
		}

		return book;
	}

	@POST
	@Path("/Book/")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Book restCreateBook(Book book) {

		String bookName = book.getBookname();

		Book newBook = BookManager.addBook(bookName);

		if (null == newBook) {
			throw new ExInvalidBook();
		}

		return newBook;
	}

	@PUT
	@Path("/Book/{bookId}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Book restUpdateBook(@PathParam("bookId") Integer bookId, Book book) {

		String username = book.getUsername();

		Book dbBook = BookManager.getBookById(bookId);
		if (dbBook == null) {
			throw new ExBookNotFound();
		}

		if (username != null) {
			User user = UserManager.getUserByUsername(username);
			if (user == null) {
				throw new ExUserNotFound();
			}
		} else {
			book.setDateOfAssignment(null);
			book.setDateOfAssignmentExpire(null);
		}

		// TODO: both date validation
		BookManager.updateBook(book);

		return book;
	}

	@DELETE
	@Path("/Book/{bookId}")
	@Produces(MediaType.APPLICATION_JSON)
	public Book restRemoveBook(@PathParam("bookId") Integer bookId) {

		Book dbBook = BookManager.getBookById(bookId);
		if (dbBook == null) {
			throw new ExBookNotFound();
		}

		if (dbBook.getUsername() != null) {
			throw new ExBookIsNotWithLibrary();
		}

		BookManager.removeBook(dbBook);

		return dbBook;
	}

}
