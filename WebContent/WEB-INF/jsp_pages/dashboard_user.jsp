<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script>
	function loadUser() {
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
		xhttp.open("GET", "/rest/user/getuser", true);
		xhttp.setRequestHeader("Accept", "application/json");
		xhttp.send();
	}
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
		xhttp.open("GET", "/rest/user/getbooks", true);
		xhttp.setRequestHeader("Accept", "application/json");
		xhttp.send();
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
	      <li><a href="/admin">Admin</a></li>  
	      <li class="active"><a href="/user">User</a></li>    
	    </ul>  
	    <ul class="nav navbar-nav navbar-right">
	      <li><a href="/logout"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
	    </ul>
	  </div>  
	</nav>  
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-4">
				<h2>User APIs</h2>
				<div style="background-color: rgba(0, 0, 0, 0.3); min-height: 300px; padding: 10px;">
					
					<div style="background-color: rgba(0, 50, 0, 0.3); min-height: 50px; padding: 10px; margin:10px;">
						<h4>My Profile Data</h4>
						<hr>
						<div align="center" style="padding: 10px;">
							<button class="btn btn-default" onclick="loadUser()"> Load My Profile Data </button>
						</div>
					</div>
					<hr>
					
					<div style="background-color: rgba(0, 50, 0, 0.3); min-height: 50px; padding: 10px; margin:10px;">
						<h4>Book Data {Assigned to me}</h4>
						<hr>
						<div align="center" style="padding: 10px;">
							<button class="btn btn-default" onclick="loadBooks()"> Load All Book Data </button>
						</div>
					</div>
					<hr>
					
				</div>
			</div>
			<div class="col-md-8">
				<h2>API Response</h2>
				<div id="content" style="background-color: rgba(0, 0, 0, 0.3); min-height: 500px;">
				</div>
			</div>
		</div>
	</div>

</body>
</html>