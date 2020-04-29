<%@page import="com.project.librarymanagement.BookManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="com.project.librarymanagement.User" %>
<%@ page import="com.project.librarymanagement.UserManager" %>
<%@ page import="com.project.librarymanagement.Book" %>
<%@ page import="com.project.librarymanagement.BookManager" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>User Dashboard</title>
<meta name="description" content="Admin Dashboard">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body class="h-100">
	<nav class="navbar navbar-default">  
	  <div class="container-fluid">  
	    <div class="navbar-header">  
	      <a class="navbar-brand" href="/">Library</a>  
	    </div>  
	    <ul class="nav navbar-nav">  
	      <li class="active"><a href="/">Home</a></li>  
	      <li><a href="/admin">Admin</a></li>  
	      <li><a href="/user">User</a></li>    
	    </ul>  
	    <ul class="nav navbar-nav navbar-right">
	      <li><a href="/logout"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
	    </ul>
	  </div>  
	</nav>  
	<div style="min-height: 100px;"> </div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4" align="center">
				<h2>Logged In</h2>
				<%
					Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
					User user = UserManager.getUserByUsername(authentication.getName());
					
					List<Book> books = BookManager.getBooksByUser(user.getUsername());
					List<Book> booksExpiring = BookManager.getExpiringBooksByUser(authentication.getName(), 5);
				%>
				<div id="content" style="background-color: rgba(0, 50, 0, 0.3); font-size: 20px; padding: 20px;">
					<table class="table table-bordered">
						<tr>
							<th> Username: </th>
							<td> <%=user.getUsername()%> </td>
						</tr>
						<tr>
							<th> Role: </th>
							<td> <%=user.getRole()%> </td>
						</tr>
						<tr>
							<th> Books Assigned: </th>
							<td> <%=books.size()%> </td>
						</tr>
						<tr>
							<th> Books To Be Return in 5 Days: </th>
							<td> <%=booksExpiring.size()%> </td>
						</tr>
					</table>
				</div>
			</div>
			<div class="col-md-4"></div>
		</div>
	</div>

</body>
</html>