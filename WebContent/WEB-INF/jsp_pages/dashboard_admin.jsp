<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>Admin Dashboard</title>
<meta name="description" content="Admin Dashboard">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<script>
	function loadBooks() {
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				document.getElementById("content").innerHTML = this.responseText;
			} else if(this.readyState == 4) {
				document.getElementById("content").innerHTML = "<span style='color:red;'>ERROR</span>";
			} else {
				document.getElementById("content").innerHTML = "<span style='color:blue;'>Loading ...</span>";
			}
		};
		xhttp.open("GET", "/rest/admin/getbooks", true);
		xhttp.setRequestHeader("Accept", "application/json");
		xhttp.send();
	}
	function loadUsers() {
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				document.getElementById("content").innerHTML = this.responseText;
			} else if(this.readyState == 4) {
				document.getElementById("content").innerHTML = "<span style='color:red;'>ERROR</span>";
			} else {
				document.getElementById("content").innerHTML = "<span style='color:blue;'>Loading ...</span>";
			}
		};
		xhttp.open("GET", "/rest/admin/getusers", true);
		xhttp.setRequestHeader("Accept", "application/json");
		xhttp.send();
	}
	function createBook() {
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				document.getElementById("content").innerHTML = this.responseText;
			} else if(this.readyState == 4) {
				document.getElementById("content").innerHTML = "<span style='color:red;'>ERROR</span>";
			} else {
				document.getElementById("content").innerHTML = "<span style='color:blue;'>Loading ...</span>";
			}
		};
		var bookname = document.getElementById("createBook_bookname").value;
		var restAPI = "/rest/admin/createbook";
		restAPI += "/" + bookname;
		xhttp.open("POST", restAPI, true);
		xhttp.setRequestHeader("Accept", "application/json");
		xhttp.send();
	}
	function deleteUsers() {
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				document.getElementById("content").innerHTML = this.responseText;
			} else if(this.readyState == 4) {
				document.getElementById("content").innerHTML = "<span style='color:red;'>ERROR</span>";
			} else {
				document.getElementById("content").innerHTML = "<span style='color:blue;'>Loading ...</span>";
			}
		};
		var username = document.getElementById("deleteUsers_username").value;
		var restAPI = "/rest/admin/deleteuser";
		restAPI += "/" + username;
		xhttp.open("DELETE", restAPI, true);
		xhttp.setRequestHeader("Accept", "application/json");
		xhttp.send();
	}
	function createUsers() {
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				document.getElementById("content").innerHTML = this.responseText;
			} else if(this.readyState == 4) {
				document.getElementById("content").innerHTML = "<span style='color:red;'>ERROR</span>";
			} else {
				document.getElementById("content").innerHTML = "<span style='color:blue;'>Loading ...</span>";
			}
		};
		var username = document.getElementById("createUsers_username").value;
		var password = document.getElementById("createUsers_password").value;
		var enabled = "TRUE";
		var restAPI = "/rest/admin/createuser";
		restAPI += "/" + username;
		restAPI += "/" + password;
		restAPI += "/" + enabled;
		xhttp.open("POST", restAPI, true);
		xhttp.setRequestHeader("Accept", "application/json");
		xhttp.send();
	}

	function assignBook() {
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				document.getElementById("content").innerHTML = this.responseText;
			} else if(this.readyState == 4) {
				document.getElementById("content").innerHTML = "<span style='color:red;'>ERROR</span>";
			} else {
				document.getElementById("content").innerHTML = "<span style='color:blue;'>Loading ...</span>";
			}
		};
		var username = document.getElementById("assignBook_username").value;
		var bookId = document.getElementById("assignBook_bookId").value;
		var assignmentDate = document.getElementById("assignBook_assignmentDate").value;
		var returnDate = document.getElementById("assignBook_returnDate").value;
		var restAPI = "/rest/admin/assignbook";
		restAPI += "/" + bookId;
		restAPI += "/" + username;
		restAPI += "/" + assignmentDate;
		restAPI += "/" + returnDate;
		xhttp.open("PUT", restAPI, true);
		xhttp.setRequestHeader("Accept", "application/json");
		xhttp.send();
	}

	function returnBook() {
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				document.getElementById("content").innerHTML = this.responseText;
			} else if(this.readyState == 4) {
				document.getElementById("content").innerHTML = "<span style='color:red;'>ERROR</span>";
			} else {
				document.getElementById("content").innerHTML = "<span style='color:blue;'>Loading ...</span>";
			}
		};
		var bookId = document.getElementById("returnBook_bookId").value;
		var restAPI = "/rest/admin/returnbook";
		restAPI += "/" + bookId;
		xhttp.open("PUT", restAPI, true);
		xhttp.setRequestHeader("Accept", "application/json");
		xhttp.send();
	}

	function removeBook() {
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				document.getElementById("content").innerHTML = this.responseText;
			} else if(this.readyState == 4) {
				document.getElementById("content").innerHTML = "<span style='color:red;'>ERROR</span>";
			} else {
				document.getElementById("content").innerHTML = "<span style='color:blue;'>Loading ...</span>";
			}
		};
		var bookId = document.getElementById("removeBook_bookId").value;
		var restAPI = "/rest/admin/deletebook";
		restAPI += "/" + bookId;
		xhttp.open("DELETE", restAPI, true);
		xhttp.setRequestHeader("Accept", "application/json");
		xhttp.send();
	}
	
	function initPage() {

		var assignmentDate = document.getElementById("assignBook_assignmentDate");
		var returnDate = document.getElementById("assignBook_returnDate");
		var date = ((new Date()).toISOString()).slice(0,10);
		var expireDate = ( new Date( new Date().getTime() + (30*24*60*60*1000) )).toISOString().slice(0,10);
		assignmentDate.value = date;
		returnDate.value = expireDate;
	}
</script>
<body class="h-100">
	<nav class="navbar navbar-default">  
	  <div class="container-fluid">  
	    <div class="navbar-header">  
	      <a class="navbar-brand" href="/">Library</a>  
	    </div>  
	    <ul class="nav navbar-nav">  
	      <li><a href="/">Home</a></li>  
	      <li class="active"><a href="/admin">Admin</a></li>  
	      <li><a href="/user">User</a></li>    
	    </ul>  
	    <ul class="nav navbar-nav navbar-right">
	      <li><a href="/logout"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
	    </ul>
	  </div>  
	</nav>  
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-4">
				<h2>Admin APIs</h2>
				<div style="background-color: rgba(0, 0, 0, 0.3); min-height: 300px; padding: 10px;">
					
					
					<div style="background-color: rgba(0, 50, 0, 0.3); min-height: 50px; padding: 10px; margin:10px;">
						<h4>User Data</h4>
						<hr>
						<div align="center" style="padding: 10px;">
							<button class="btn btn-default" onclick="loadUsers()"> Load All User Data </button>
						</div>
					</div>
					
					<div style="background-color: rgba(0, 50, 0, 0.3); min-height: 50px; padding: 10px; margin:10px;">
						<h4>User Creation</h4>
						<hr>					
						<div class="form-horizontal" >
							<div class="form-group">
								<label class="control-label col-sm-2" for="createUsers_username">UserName:</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="createUsers_username"
										placeholder="Enter UserName" name="createUsers_username">
								</div> 
							</div>
							<div class="form-group">
								<label class="control-label col-sm-2" for="createUsers_password">Password:</label>
								<div class="col-sm-10">
									<input type="password" class="form-control" id="createUsers_password"
										placeholder="Enter password" name="createUsers_password">
								</div>
							</div>
							
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10">
									<button onclick="createUsers()" class="btn btn-default">Create</button>
								</div>
							</div>
						</div>
					</div>
					
					
					<div style="background-color: rgba(0, 50, 0, 0.3); min-height: 50px; padding: 10px; margin:10px;">
						<h4>User Deletion</h4>
						<hr>					
						<div class="form-horizontal" >
							<div class="form-group">
								<label class="control-label col-sm-2" for="deleteUsers_username">UserName:</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="deleteUsers_username"
										placeholder="Enter UserName" name="deleteUsers_username">
								</div> 
							</div>
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10">
									<button onclick="deleteUsers()" class="btn btn-default">Delete</button>
								</div>
							</div>
						</div>
					</div>
					<hr>
					<hr>
					
					<div style="background-color: rgba(0, 50, 0, 0.3); min-height: 50px; padding: 10px; margin:10px;">
						<h4>Book Data</h4>
						<hr>
						<div align="center" style="padding: 10px;">
							<button class="btn btn-default" onclick="loadBooks()"> Load All Book Data </button>
						</div>
					</div>
					
					<div style="background-color: rgba(0, 50, 0, 0.3); min-height: 50px; padding: 10px; margin:10px;">
						<h4>Book Insertion In DB</h4>
						<hr>
						<div class="form-horizontal" >
							<div class="form-group">
								<label class="control-label col-sm-2" for="book">Book:</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="createBook_bookname"
										placeholder="Enter Book Name" name="createBook_bookname">
								</div>
							</div>
							
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10">
									<button onclick="createBook()" class="btn btn-default">Insert</button>
								</div>
							</div>
						</div>
					</div>
					<div style="background-color: rgba(0, 50, 0, 0.3); min-height: 50px; padding: 10px; margin:10px;">
						<h4>Book Assignment</h4>
						<hr>
						<div class="form-horizontal" >
							<div class="form-group">
								<label class="control-label col-sm-2" for="assignBook_bookId">BookId:</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="assignBook_bookId"
										placeholder="Which Book?" name="assignBook_bookId">
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-2" for="assignBook_username">UserName</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="assignBook_username"
										placeholder="Who is taking the book?" name="assignBook_username">
								</div> 
							</div>
							<div class="form-group">
								<label class="control-label col-sm-2" for="assignBook_assignmentDate">Assignment Date</label>
								<div class="col-sm-10">
									<input type="date" class="form-control" id="assignBook_assignmentDate"
										placeholder="When he took the book?" name="assignBook_assignmentDate">
								</div> 
							</div>
							<div class="form-group">
								<label class="control-label col-sm-2" for="assignBook_returnDate">Return Date</label>
								<div class="col-sm-10">
									<input type="date" class="form-control" id="assignBook_returnDate"
										placeholder="When he will return?" name="assignBook_returnDate">
								</div> 
							</div>
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10">
									<button onclick="assignBook()" class="btn btn-default">Assign</button>
								</div>
							</div>
						</div>
					</div>
					
					<div style="background-color: rgba(0, 50, 0, 0.3); min-height: 50px; padding: 10px; margin:10px;">
						<h4>Book Return To Library</h4>
						<hr>
						<div class="form-horizontal" >
							<div class="form-group">
								<label class="control-label col-sm-2" for="book">BookId:</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="returnBook_bookId"
										placeholder="Enter BookId" name="returnBook_bookId">
								</div>
							</div>
							
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10">
									<button onclick="returnBook()" class="btn btn-default">Return</button>
								</div>
							</div>
						</div>
					</div>
					
					<div style="background-color: rgba(0, 50, 0, 0.3); min-height: 50px; padding: 10px; margin:10px;">
						<h4>Book Deletion</h4>
						<hr>					
						<div class="form-horizontal" >
							<div class="form-group">
								<label class="control-label col-sm-2" for="removeBook_bookId">BookId:</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="removeBook_bookId"
										placeholder="Enter UserName" name="removeBook_bookId">
								</div> 
							</div>
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10">
									<button onclick="removeBook()" class="btn btn-default">Remove</button>
								</div>
							</div>
						</div>
					</div>
					<hr>
					
				</div>
			</div>
			<div class="col-md-8" style="position: fixed; top:80px; right:00px;">
				<h2>API Response</h2>
				<div id="content" style="background-color: rgba(0, 0, 0, 0.3); min-height: 500px; overflow:auto;">
				</div>
			</div>
		</div>
	</div>
	<script>

		initPage();
	</script>
</body>
</html>