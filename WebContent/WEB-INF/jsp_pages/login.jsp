<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>User Login</title>
<meta name="description" content="User Login">
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
	      <li><a href="/">Home</a></li>  
	      <li><a href="/admin">Admin</a></li>  
	      <li><a href="/user">User</a></li>    
	    </ul>  
	    <ul class="nav navbar-nav navbar-right">
	      <li class="active"><a href="/login"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
	    </ul>
	  </div>  
	</nav>   

	<div style="min-height: 200px;"> </div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4" style="background-color: rgba(0, 50, 0, 0.3);">
				<h2>User Login</h2>
				<%
					String msg = (String) request.getAttribute("msg");
					String error = (String) request.getAttribute("error");
					if(msg == null) {
						msg = "";
					}
					if(error == null) {
						error = "";
					}
				%>
				<div style="color:red"><%=error%></div>
				<div style="color:green"><%=msg%></div>
				<form class="form-horizontal" action="/j_spring_security_check" method="POST">
					<div class="form-group">
						<label class="control-label col-sm-2" for="username">UserName:</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="username"
								placeholder="Enter UserName" name="username">
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="password">Password:</label>
						<div class="col-sm-10">
							<input type="password" class="form-control" id="password"
								placeholder="Enter password" name="password">
						</div>
					</div>
					
				  <input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="submit" class="btn btn-default">Submit</button>
						</div>
					</div>
				</form>
			</div>
			<div class="col-md-4"></div>
		</div>
	</div>

</body>
</html>