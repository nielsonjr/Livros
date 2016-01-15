<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Book</title>
<link rel="stylesheet"
	href="https://dl.dropboxusercontent.com/u/65027933/css/normalize.css">
<link rel="stylesheet"
	href="https://dl.dropboxusercontent.com/u/65027933/css/style.css">

<script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
<script
	src="http://builds.emberjs.com.s3.amazonaws.com/beta/daily/20140325/ember-template-compiler.js"></script>

<script
	src="https://dl.dropboxusercontent.com/u/65027933/js/libs/handlebars-1.1.2.js"></script>
<script
	src="https://dl.dropboxusercontent.com/u/65027933/js/libs/ember.debug.js"></script>
<script
	src="https://dl.dropboxusercontent.com/u/65027933/js/libs/ember-data.js"></script>
<script
	type="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<link rel="stylesheet"
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" />
</head>
<body>
	<script type="text/x-handlebars">
    <h2>Creating a Book</h2>

    {{outlet}}
  </script>

	<script type="text/x-handlebars" data-template-name="book" >
<div class="list-group col-xs-3 ">
    {{#each book in model}}
		<button class="btn btn-success btn-sm pull-right" {{action "save" book}}>Save Book</button>
		
		{{#link-to 'books.book' book class="list-group-item clearfix"}}
			{{book.name}} 
		{{/link-to}}
			
    {{/each}}
</div>
<div class="col-xs-9">
	{{outlet}}
</div>
  </script>

  <script>		
		App = Ember.Application.create();

		

		//Spring Serializer
		App.SpringSerializer = DS.RESTSerializer.extend({
			serializeIntoHash : function(hash, type, record, options) {
				var serialized = this.serialize(record, options);
				//Include the id in the payload
				serialized.id = record.id;

				//remove the root element
				Ember.merge(hash, serialized);
			}
		});

		//Application Serializer
		App.ApplicationSerializer = App.SpringSerializer.extend();

		//Book Serializer
		App.BookSerializer = App.SpringSerializer.extend(
				DS.EmbeddedRecordsMixin, {
					//Force embedding the authors array into the payload to the server
					attrs : {
						authors : {
							serialize : 'records'
						}
					}
				});
		
		//Adapter
		App.ApplicationAdapter = DS.RESTAdapter.extend({
			namespace : 'book'
		});

		//Models
		App.Book = DS.Model.extend({
			name : DS.attr('string'),
			year : DS.attr('number'),
			authors : DS.hasMany('author', {
				async : true
			})
		});

		App.User = DS.Model.extend({
			name : DS.attr('string'),
			books : DS.hasMany('book', {
				async : true
			})
		});

		//Router
		App.Router.map(function() {
			this.resource('book', function() {
				this.route('bookEmber', {
					path : '/:book_id'
				});
			});
		});

		//Routes
		App.BooksRoute = Ember.Route.extend({
			model : function() {
				return this.store.find('book');
			}
		});

		//Controllers
		App.BooksController = Ember.ObjectController.extend({

			actions : {
				save : function(book) {
					var self = this;
					book.save().then(function() {
						alert(self.store.metadataFor("book").serverSaid);
					});
				}
			}

		});

		App.AuthorsBookController = Ember.ObjectController.extend({
			actions : {
				save : function(author) {
					var self = this;
					author.save().then(function() {
						alert(self.store.metadataFor("author").serverSaid);
					});
				}
			}
		});
	</script>


</body>
</html>