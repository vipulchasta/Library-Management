var Book = Backbone.Model.extend({
	defaults : {
		id : "",
		bookname : "",
		dateOfAddition : new Date(),
		dateOfAssignment : null,
		dateOfAssignmentExpire : null,
		username : null
	},
	idAttribute : "id",
	initialize : function() {
		this.on("invalid", function(model, error) {
			console.log("DeXter, we have a problem: " + error)
		});
	},
	constructor : function(attributes, options) {
		Backbone.Model.apply(this, arguments);
	},
	validate : function(attr) {
		if (!attr.bookname) {
			return "Invalid bookname supplied."
		}
	},
	urlRoot : '/rest/admin/Book'
});

var BooksCollection = Backbone.Collection.extend({
    model: Book,
	url : '/rest/admin/Books'
});

var BookView = Backbone.View.extend({
    tagName: "tr",
    model: Book,

    initialize: function() {
        // lets listen to model change and update ourselves
        this.listenTo(this.model, "change", this.render);
    },

    render: function (){
    	this.$el.html('');
        this.$el.append('<td>' + this.model.get("id") + '</td>');
        this.$el.append('<td>' + this.model.get("bookname") + '</td>');
        this.$el.append('<td>' + new Date(this.model.get("dateOfAddition")).toLocaleDateString() + '</td>');
        if(null == this.model.get("username")) {
            this.$el.append('<td> - </td>');
            this.$el.append('<td> - </td>');
            this.$el.append('<td> - </td>');
            this.$el.append('<td><div class=\'btn-group\'>' + 
            		"<button onclick='assignBookModalLaunch( " + this.model.id + " )' class='btn btn-default'>Assign</button>" +
            		"<button onclick=\"deleteBook( " + this.model.id + " )\" class='btn btn-danger'>Delete</button>" +
            		'</div></td>');
        } else {
            this.$el.append('<td>' + new Date(this.model.get("dateOfAssignment")).toLocaleDateString() + '</td>');
            this.$el.append('<td>' + new Date(this.model.get("dateOfAssignmentExpire")).toLocaleDateString() + '</td>');
            this.$el.append('<td>' + this.model.get("username") + '</td>');
            this.$el.append('<td><div class=\'btn-group\'>' + 
            		"<button onclick=\"bookEntryActionButton('RETURN', " + this.model.id + ")\" class='btn btn-default'>Return</button>" +
            		"<button onclick=\"bookEntryActionButton('DELETE', " + this.model.id + ")\" class='btn btn-danger'>Delete</button>" +
            		'</div></td>');
        }
        return this;
    }
});

var BookTableView = Backbone.View.extend({
    model: BooksCollection,

    initialize: function() {
        // lets listen to model change and update ourselves
        this.listenTo(this.model, "add", this.modelUpdated);
        this.listenTo(this.model, "remove", this.modelUpdated);
    },

    modelUpdated: function() {
        this.render();
    },

    render: function() {
    	this.$el.html(''); // blank the content of the div
        for(var i = 0; i < this.model.length; ++i) {

            // lets create a book view to render
            var bookView = new BookView( {model: this.model.at(i)} );

            // lets add this book view to this list view
            this.$el.append(bookView.$el); 
            bookView.render(); // lets render the book           
        } 

         return this;
    }
});








var User = Backbone.Model.extend({
	defaults : {
		userId : null,
		username : "",
		password : "",
		enabled : true,
		role : "ROLE_USER"
	},
	idAttribute : "username",
	initialize : function() {
		this.on("invalid", function(model, error) {
			console.log("DeXter, we have a problem: " + error)
		});
	},
	constructor : function(attributes, options) {
		Backbone.Model.apply(this, arguments);
	},
	validate : function(attr) {
		if (!attr.username) {
			return "Invalid username supplied."
		}
	},
	urlRoot : '/rest/admin/User'
});

var UsersCollection = Backbone.Collection.extend({
    model: User,
	url : '/rest/admin/Users'
});

var UserView = Backbone.View.extend({
    tagName: "tr",
    model: User,

    initialize: function() {
        // lets listen to model change and update ourselves
        this.listenTo(this.model, "change", this.render);
    },

    render: function (){
    	this.$el.html('');
        this.$el.append('<td>' + this.model.get("username") + '</td>');
        this.$el.append('<td>' + this.model.get("password") + '</td>');
        this.$el.append('<td>' + this.model.get("enabled") + '</td>');
        this.$el.append('<td>' + this.model.get("role") + '</td>');
        this.$el.append('<td><div class=\'btn-group\'>' + 
        		"<button onclick=\"userEntryActionButton('MODIFY', '" + this.model.id + "')\" class='btn btn-default'>Modify</button>" +
        		"<button onclick=\"userEntryActionButton('DELETE', '" + this.model.id + "')\" class='btn btn-danger'>Delete</button>" +
        		'</div></td>');
        return this;
    }
});

var UserTableView = Backbone.View.extend({
    model: UsersCollection,

    initialize: function() {
        // lets listen to model change and update ourselves
        this.listenTo(this.model, "add", this.modelUpdated);
        this.listenTo(this.model, "remove", this.modelUpdated);
    },

    modelUpdated: function() {
        this.render();
    },

    render: function() {
    	this.$el.html(''); // blank the content of the div
        for(var i = 0; i < this.model.length; ++i) {

            // lets create a book view to render
            var userView = new UserView( {model: this.model.at(i)} );

            // lets add this book view to this list view
            this.$el.append(userView.$el); 
            userView.render(); // lets render the book           
        } 

         return this;
    }
});