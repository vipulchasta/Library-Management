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
	<div style="min-height: 100px;"> </div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4" align="center">
				<h2>No Access For You</h2>
				<div id="content" style="background-color: rgba(0, 0, 0, 0.3); min-height: 300px;">
				</div>
			</div>
			<div class="col-md-4"></div>
		</div>
	</div>

</body>
</html>