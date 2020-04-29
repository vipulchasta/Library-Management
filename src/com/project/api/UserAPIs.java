package com.project.api;

import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import com.project.librarymanagement.Book;
import com.project.librarymanagement.BookManager;
import com.project.librarymanagement.User;
import com.project.librarymanagement.UserManager;

@Path("/user")
public class UserAPIs {

	@Path("/getbooks")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public List<Book> restGetUserBooks() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		List<Book> books = BookManager.getBooksByUser(authentication.getName());
		return books;
	}

	@Path("/getuser")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public User restGetUserDetail() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = UserManager.getUserByUsername(authentication.getName());
		return user;
	}

	@Path("/getexpirebooks")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public List<Book> restGetExpiringBooks() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		List<Book> books = BookManager.getExpiringBooksByUser(authentication.getName(), 5);
		return books;
	}

	@GET
	@Produces(MediaType.TEXT_HTML)
	public String defaultRoute() {
		return "Not Supported";
	}

}
