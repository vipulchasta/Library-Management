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
    <script src="/resources/libs/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="/resources/libs/underscore.js" type="text/javascript"></script>
    <script src="/resources/libs/json2.js" type="text/javascript"></script>
    <script src="/resources/libs/backbone.js" type="text/javascript"></script>


  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

    <script src="/js/model.js" type="text/javascript"></script>
<script>

	function createUserModalLaunch() {
		$("#createUserModal").modal('show');
	}
	
	function createBookModalLaunch() {
		$("#createBookModal").modal('show');
	}

	function assignBookModalLaunch(bookId) {
		document.getElementById("assignBook_id").value = bookId;

		var assignmentDate = document.getElementById("assignBook_dateOfAssignment");
		var returnDate = document.getElementById("assignBook_dateOfAssignmentExpire");
		var date = ((new Date()).toISOString()).slice(0,10);
		var expireDate = ( new Date( new Date().getTime() + (30*24*60*60*1000) )).toISOString().slice(0,10);
		assignmentDate.value = date;
		returnDate.value = expireDate;

		$("#assignBookModal").modal('show');
	}

	function modifyUserModalLaunch(username) {
		var user = usersCollection.get(username);
		
		var eleForm = document.getElementById("modifyUserForm");
		eleForm.elements["modifyUser_password"].value = user.get("password");
		eleForm.elements["modifyUser_username"].value = username;
		eleForm.elements["modifyUser_enabled"].value = user.get("enabled");
		eleForm.elements["modifyUser_role"].value = user.get("role");
		
		
		//document.getElementById("modifyUser_username").value = username;
		
		$("#modifyUserModal").modal('show');
	}

	function createUserModalClose() {
		$("#createUserModal").modal('hide');
	}
	
	function createBookModalClose() {
		$("#createBookModal").modal('hide');
	}

	function assignBookModalClose() {
		$("#assignBookModal").modal('hide');
	}

	function modifyUserModalClose() {
		$("#modifyUserModal").modal('hide');
	}
	

	var booksCollection = new BooksCollection();
	var bookTableView = new BookTableView({ el: $("#bookTableViewEl"), model: booksCollection });

	var usersCollection = new UsersCollection();
	var userTableView = new UserTableView({ el: $("#userTableViewEl"), model: usersCollection });
	
	function loadingContent(status) {
		var eleImgLoading = document.getElementById("imgLoading");
		if(status == true) {
			eleImgLoading.style.display = "block";
		} else {
			eleImgLoading.style.display = "none";
		}
	}
	
	function loadBooks() {
		loadingContent(true);
		booksCollection = new BooksCollection();
		booksCollection.fetch({
            success: function (userResponse) {
            	bookTableView = new BookTableView({ el: $("#bookTableViewEl"), model: booksCollection });
            	bookTableView.render();
        		loadingContent(false);
            },
            error: function (model, xhr, options) {
            	alert(xhr.responseText);
        		loadingContent(false);
            }
        
        });
	}
	function loadUsers() {
		loadingContent(true);
		usersCollection = new UsersCollection();
		usersCollection.fetch({
            success: function (userResponse) {
				userTableView = new UserTableView({ el: $("#userTableViewEl"), model: usersCollection });
				userTableView.render();
        		loadingContent(false);
            },
            error: function (model, xhr, options) {
            	alert(xhr.responseText);
        		loadingContent(false);
            }
        
        });
	}
	

	function createUserCallByModal() {
		loadingContent(true);
		var username = document.getElementById("createUser_username").value;
		var password = document.getElementById("createUser_password").value;
		var user = new User({ username: username, password: password });
        user.save({}, {
            type: "POST",
            success: function (model, respose, options) {
    	        usersCollection.add(user);
    	        createUserModalClose();
        		loadingContent(false);
            },
            error: function (model, xhr, options) {
            	alert(xhr.responseText);
        		loadingContent(false);
            }
        });
	}
	function createBookCallByModal() {
		loadingContent(true);
		var bookname = document.getElementById("createBook_bookname").value;
		var book = new Book({ bookname: bookname });
		book.save({}, {
            type: "POST",
            success: function (model, respose, options) {
    	        booksCollection.add(book);
    	        createBookModalClose();
        		loadingContent(false);
            },
            error: function (model, xhr, options) {
            	alert(xhr.responseText);
        		loadingContent(false);
            }
        });
	}
	
	function deleteUsers(username) {
		loadingContent(true);
		var user = usersCollection.get(username);
	
        user.destroy({
            success: function (model, respose, options) {
        		loadingContent(false);
            },
            error: function (model, xhr, options) {
            	usersCollection.add(user);
            	alert(xhr.responseText);
        		loadingContent(false);
            }
        });

	}
	
	function deleteBook(bookId) {
		loadingContent(true);
		var book = booksCollection.get(bookId);
		
        book.destroy({
            success: function (model, respose, options) {
        		loadingContent(false);
            },
            error: function (model, xhr, options) {
            	booksCollection.add(book);
            	alert(xhr.responseText);
        		loadingContent(false);
            }
        });

	}

	function returnBook(bookId) {
		loadingContent(true);
		var book = booksCollection.get(bookId);
		book.fetch({
            success: function (bookResponse) {
                // Let us update this retreived book now (doing it in the callback) [UPDATE]
                bookResponse.set("dateOfAssignment", null);
                bookResponse.set("dateOfAssignmentExpire", null);
                bookResponse.set("username", null);
                bookResponse.save({}, {
                    success: function (model, respose, options) {
                		loadingContent(false);
                    },
                    error: function (model, xhr, options) {
    	            	alert(xhr.responseText);
    	        		loadingContent(false);
                    }
                });
            }
        });
	}

	function updateUserCallByModal() {
		loadingContent(true);
		
		var eleForm = document.getElementById("modifyUserForm");

		var username = eleForm.elements["modifyUser_username"].value;
		var password = eleForm.elements["modifyUser_password"].value;
		var enabled = eleForm.elements["modifyUser_enabled"].value;
		var role = eleForm.elements["modifyUser_role"].value;
		

		var user = usersCollection.get(username);
		user.fetch({
        	
            success: function (model, respose, options) {
                // Let us update this retreived book now (doing it in the callback) [UPDATE]
                user.set("password", password);
                user.set("enabled", enabled);
                user.set("role", role);
                user.save({}, {
                    success: function (model, respose, options) {
                    	modifyUserModalClose();
                		loadingContent(false);
                    },
                    error: function (model, xhr, options) {
    	            	alert(xhr.responseText);
    	        		loadingContent(false);
                    }
                });
            },
            error: function (model, xhr, options) {
            	alert(xhr.responseText);
        		loadingContent(false);
            }
        
        });
	}

	function assignBookCallByModal() {
		loadingContent(true);
		var username = document.getElementById("assignBook_username").value;
		var bookId = document.getElementById("assignBook_id").value;
		var assignmentDate = document.getElementById("assignBook_dateOfAssignment").value;
		var returnDate = document.getElementById("assignBook_dateOfAssignmentExpire").value;
		
		var book = booksCollection.get(bookId);
		book.fetch({
        	
            success: function (model, respose, options) {
                // Let us update this retreived book now (doing it in the callback) [UPDATE]
                book.set("dateOfAssignment", assignmentDate);
                book.set("dateOfAssignmentExpire", returnDate);
                book.set("username", username);
                book.save({}, {
                    success: function (model, respose, options) {
                    	assignBookModalClose();
                		loadingContent(false);
                    },
                    error: function (model, xhr, options) {
    	            	alert(xhr.responseText);
    	        		loadingContent(false);
                    }
                });
            },
            error: function (model, xhr, options) {
            	alert(xhr.responseText);
        		loadingContent(false);
            }
        
        });
	}

	
	function removeBook() {
		loadingContent(true);
		var bookId = document.getElementById("removeBook_bookId").value;
        var book2 = new Book({ id: bookId });
        book2.destroy({
            success: function (model, respose, options) {
        		loadingContent(false);
            },
            error: function (model, xhr, options) {
            	alert(xhr.responseText);
        		loadingContent(false);
            }
        });
	}
	

	function userEntryActionButton(action, username) {
		switch(action) {
			case "MODIFY":
				modifyUserModalLaunch(username);
				break;
			case "DELETE":
				deleteUsers(username);
				break;
		}
	}
	function bookEntryActionButton(action, id) {
		switch(action) {
			case "DELETE":
				deleteBook(id)
				break;
			case "ASSIGN":
				assignBookModalLaunch(id);
				break;
			case "RETURN":
				returnBook(id);
				break;
		}
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
	
     <!-- Modal: createUserModal -->
     <div class="modal fade" id="createUserModal" tabindex="-1" role="dialog" aria-hidden="true">
       <div class="modal-dialog modal-dialog-centered" role="document">
         <div class="modal-content">
           <div class="modal-header">
             <h5 class="modal-title" id="createUserModalTitle">Create User</h5>
           </div>
           <div class="modal-body" id="createUserModalBody" style="size: 6px; font-family: 'Times New Roman', Times, serif;">
             
             <form onsubmit="createUserCallByModal()" action="javascript:void(0);">
               <div class="form-group">
                 <label for="createUser_username">Username</label>
                 <input type="text" class="form-control" id="createUser_username" placeholder="username For User">
               </div>
               <div class="form-group">
                 <label for="createUser_password">User Password</label>
                 <input type="password" class="form-control" id="createUser_password" placeholder="Password For User">
               </div>
               <input type="submit" hidden=""/>
             </form>

           </div>
           <div class="modal-footer">
             <a id="createUserModalExitLink"  style="text-decoration: none;">
               <button type="button" class="btn btn-primary" data-dismiss="modal">Exit</button>
             </a>
             <a id="createUserModalLink" href="#" style="text-decoration: none;" onclick="createUserCallByModal()">
               <button type="button" class="btn btn-primary">Create User</button>
             </a>
           </div>
         </div>
       </div>
     </div>

     <!-- Modal: modifyUserModal -->
     <div class="modal fade" id="modifyUserModal" tabindex="-1" role="dialog" aria-hidden="true">
       <div class="modal-dialog modal-dialog-centered" role="document">
         <div class="modal-content">
           <div class="modal-header">
             <h5 class="modal-title" id="modifyUserModalTitle">Update User</h5>
           </div>
           <div class="modal-body" id="modifyUserModalBody" style="size: 6px; font-family: 'Times New Roman', Times, serif;">
             
             <form id="modifyUserForm" onsubmit="updateUserCallByModal()" action="javascript:void(0);">
               <div class="form-group">
                 <label for="modifyUser_username">User Name</label>
                 <input type="text" class="form-control" id="modifyUser_username" value="" placeholder="Username of the User" disabled>
               </div>
               <div class="form-group">
                 <label for="modifyUser_password">Password</label>
                 <input type="text" class="form-control" id="modifyUser_password" placeholder="Password for the User">
               </div>
               <hr>
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-default">
						<input type="radio" name="modifyUser_enabled" value="true" checked>ACTIVE
					</label>
					<label class="btn btn-default">
						<input type="radio" name="modifyUser_enabled" value="false" >INACTIVE
					</label>
				</div>
				<hr>
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-default">
						<input type="radio" name="modifyUser_role" value="ROLE_USER" checked>USER
					</label>
					<label class="btn btn-default">
						<input type="radio" name="modifyUser_role" value="ROLE_ADMIN">ADMIN
					</label>
				</div>
				<input type="submit" hidden=""/>
             </form>

           </div>
           <div class="modal-footer">
             <a id="modifyUserModalExitLink"  style="text-decoration: none;">
               <button type="button" class="btn btn-primary" data-dismiss="modal">Exit</button>
             </a>
             <a id="modifyUserModalLink" href="#" style="text-decoration: none;" onclick="updateUserCallByModal()">
               <button type="button" class="btn btn-primary">Update User</button>
             </a>
           </div>
         </div>
       </div>
     </div>


     <!-- Modal: createBookModal -->
     <div class="modal fade" id="createBookModal" tabindex="-1" role="dialog" aria-hidden="true">
       <div class="modal-dialog modal-dialog-centered" role="document">
         <div class="modal-content">
           <div class="modal-header">
             <h5 class="modal-title" id="createBookModalTitle">Add New Book</h5>
           </div>
           <div class="modal-body" id="createBookModalBody" style="size: 6px; font-family: 'Times New Roman', Times, serif;">
             
             <form onsubmit="createBookCallByModal()" action="javascript:void(0);">
               <div class="form-group">
                 <label for="createBook_username">Book Name</label>
                 <input type="text" class="form-control" id="createBook_bookname" placeholder="Name Of The Book">
               </div>
               <input type="submit" hidden=""/>
             </form>

           </div>
           <div class="modal-footer">
             <a id="createBookModalExitLink"  style="text-decoration: none;">
               <button type="button" class="btn btn-primary" data-dismiss="modal">Exit</button>
             </a>
             <a id="createBookModalLink" href="#" style="text-decoration: none;" onclick="createBookCallByModal()">
               <button type="button" class="btn btn-primary">Create Book</button>
             </a>
           </div>
         </div>
       </div>
     </div>

     <!-- Modal: assignBookModal -->
     <div class="modal fade" id="assignBookModal" tabindex="-1" role="dialog" aria-hidden="true">
       <div class="modal-dialog modal-dialog-centered" role="document">
         <div class="modal-content">
           <div class="modal-header">
             <h5 class="modal-title" id="assignBookModalTitle">Assign Book To User</h5>
           </div>
           <div class="modal-body" id="assignBookModalBody" style="size: 6px; font-family: 'Times New Roman', Times, serif;">
             
             <form onsubmit="assignBookCallByModal()" action="javascript:void(0);">
               <div class="form-group">
                 <label for="assignBook_id">Book ID</label>
                 <input type="text" class="form-control" id="assignBook_id" placeholder="ID Of The Book" value="" disabled>
               </div>
               <div class="form-group">
                 <label for="assignBook_username">User Name</label>
                 <input type="text" class="form-control" id="assignBook_username" placeholder="Name of the User">
               </div>
               <div class="form-group">
                 <label for="assignBook_dateOfAssignment">Date of Assignment</label>
                 <input type="date" class="form-control" id="assignBook_dateOfAssignment" placeholder="When User Was given the book?">
               </div>
               <div class="form-group">
                 <label for="assignBook_dateOfAssignmentExpire">Date of Expire</label>
                 <input type="date" class="form-control" id="assignBook_dateOfAssignmentExpire" placeholder="When User is supposed to return the book?">
               </div>
               <input type="submit" hidden=""/>
             </form>

           </div>
           <div class="modal-footer">
             <a id="createBookModalExitLink"  style="text-decoration: none;">
               <button type="button" class="btn btn-primary" data-dismiss="modal">Exit</button>
             </a>
             <a id="createBookModalLink" href="#" style="text-decoration: none;" onclick="assignBookCallByModal()">
               <button type="button" class="btn btn-primary">Assign Book</button>
             </a>
           </div>
         </div>
       </div>
     </div>


	<div class="container-fluid">
		<div class="row">
			<div class="col-md-8">
				<h2>User Collection</h2>
				<div style="min-height: 300px;">
					<table class="table table-bordered text-center" style="width:100%;">
						<thead>
							<tr>
								<th class="text-center"> Username </th>
								<th class="text-center"> Password </th>
								<th class="text-center"> Enabled </th>
								<th class="text-center"> Role </th>
								<th class="text-center"> Action </th>
							</tr>
						</thead>
						<tbody id="userTableViewEl">
						</tbody>
					</table>
				</div>
				<hr>
				<hr>
				<h2>Book Collection</h2>
				<div style="min-height: 300px;">
					<table class="table table-bordered text-center" style="width:100%;">
						<thead>
							<tr>
								<th class="text-center"> Book ID </th>
								<th class="text-center"> BookName </th>
								<th class="text-center"> Date </th>
								<th class="text-center"> Assignment </th>
								<th class="text-center"> Expire </th>
								<th class="text-center"> User </th>
								<th class="text-center"> Action </th>
							</tr>
						</thead>
						<tbody id="bookTableViewEl">
						</tbody>
					</table>
				</div>

			</div>
			<div class="col-md-4" style="position: fixed; top: 80px; right: 00px;">
				<h2>Admin APIs</h2>
				<div style="min-height: 300px; padding: 10px;" align="center">
					<div style="background-color: rgba(0, 50, 0, 0.3); min-height: 50px; padding: 10px; margin:10px;">
						<h4>New User</h4>
						<hr>
						<div align="center" style="padding: 10px;">
							<button class="btn btn-primary" onclick="createUserModalLaunch()"> Create New User </button>
						</div>
					</div>
					<hr>
					<hr>
					<div style="background-color: rgba(0, 50, 0, 0.3); min-height: 50px; padding: 10px; margin:10px;">
						<h4>Add New Book</h4>
						<hr>
						<div align="center" style="padding: 10px;">
							<button class="btn btn-info" onclick="createBookModalLaunch()"> Add New Book </button>
						</div>
					</div>
					<div id="imgLoading" hidden="">
						<img src="/resources/img/loading.gif" alt="loading image"/>
					</div>
					
				</div>
			</div>
		</div>
	</div>
	<script>
		loadUsers();
		loadBooks();
	</script>
</body>
</html>