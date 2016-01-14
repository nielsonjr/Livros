<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Book</title>
<link rel="stylesheet" href="css/normalize.css">
<link rel="stylesheet" href="css/style.css">

<script
	type="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" />
</head>
<body>

	<script type="text/x-handlebars">
    <h2>Spring Framework & Ember.js</h2>

    {{outlet}}
  </script>

	<script type="text/x-handlebars" id="books">
<div class="list-group col-xs-3 ">
    {{#each book in model}}
			{{#link-to 'books.book' book class="list-group-item clearfix"}}
				{{book.name}} 
				<button class="btn btn-success btn-sm pull-right" {{action "save" book}}>Save Book</button>
			{{/link-to}}
			
    {{/each}}
</div>
<div class="col-xs-9">
	{{outlet}}
</div>
  </script>

	<script type="text/x-handlebars" id="books/author">
    <ul class="list-group">
    {{#each author in model.authors}}
      	<li class="list-group-item clearfix">{{author}}
		<button class="btn btn-success pull-right" {{action "save" post}}>Save Author</button>
		</li>
    {{/each}}
    </ul>
  </script>

	<script src="/js/libs/jquery-1.10.2.js"></script>
	<script src="/js/libs/handlebars-1.1.2.js"></script>
	<script src="/js/libs/ember.debug.js"></script>
	<script src="/js/libs/ember-data.js"></script>
	<script src="/js/app.js"></script>


</body>
</html>