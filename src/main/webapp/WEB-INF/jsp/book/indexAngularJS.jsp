<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html ng-app="bookManagerApp">
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script data-require="angular.js@*" data-semver="1.3.0-beta.14"
	src="http://code.angularjs.org/1.3.0-beta.14/angular.js"></script>
<script data-require="angular-animate@*" data-semver="1.3.0-beta.14"
	src="http://code.angularjs.org/1.3.0-beta.14/angular-animate.js"></script>
<title>Create Book</title>
</head>
<body>
	<div ng-controller="bookManagerController"  style="width: 50%">
		<h1>Manage Books</h1>
		<br>
		<form ng-submit="salvar(book, authors)" >
			<table>
				<tr>
					<td><label for="titulo">Title: </label></td>
					<td><input type="text" id="titulo" name="titulo"
						ng-model="book.name" class="form-control" placeholder="Enter the book's name"/></td>
				</tr>
				<tr>
					<td><label for="dataPublicacao">Year: </label></td>
					<td><input type="text" id="dataPublicacao"
						name="dataPublicacao" ng-model="book.year" class="form-control" placeholder="Enter the book's year"/></td>
				</tr>
				<tr>
					<td colspan="2" align="center">Autores 
						<a href="#" class="btn btn-success btn-xs" ng-click="addAuthor()">
	          				<span class="glyphicon glyphicon-plus-sign"/>  
	        			</a>
        			</td>
				</tr>
				<tr ng-repeat="authorEntity in authors">
					<td colspan="2">
						<div class="input-group">
							<input type="text" ng-model="authorEntity.name"
								placeholder="Enter the Author's name" class="form-control" /> 
								
							<span class="input-group-btn">								
								<a class="pull-right btn btn-danger" title="Remove Author" ng-click="removeAuthor($index)"> 
									<span class="glyphicon glyphicon-remove-circle"></span>
								</a>
							</span>
						</div>
						
					</td>
				</tr>
				
				
				<tr>
					<td colspan="2" align="right">
						<input type="hidden" ng-model="book.id">
						<button id="btnSalvar" type="submit" class="btn btn-success">
							<span class="glyphicon glyphicon-floppy-save"/>  Save
						</button>
					</td>
				</tr>
			</table>
		</form>

		<h1>Saved Books</h1>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>Name</th>
					<th>Year</th>
					<th>Authors</th>
					<th></th>
				</tr>
			</thead>
			<tr ng-repeat="book in books">
				<td>{{book.name}}</td>
				<td>{{book.year}}</td>
				<td>
					<ul ng-repeat="author in book.authors track by $index">
						<li>{{author}}</li>
					</ul>
				</td>
				<td>
					<button type="submit" class="pull-right btn btn-danger" 
						title="Update" ng-click="updateBook(book)">
						<span class="glyphicon glyphicon-refresh"></span>
					</button>
					<button type="submit" class="pull-right btn btn-danger" 
						title="Delete" ng-click="deleteBook(book)" onclick="confirm(Are you sure you want to delete this book?)">
						<span class="glyphicon glyphicon-trash"></span>
					</button>
				</td>
			</tr>
		</table>

	</div>
	<script>
		var bookManagerApp = angular.module('bookManagerApp', ['ngAnimate']);
		
		bookManagerApp.factory('bookService', ['$http', function($http) {

		    function listar(callback) {
		        $http({
		            method:'GET',
		            url:'book/listAll'
		        }).success(function (data) {
		            if (callback) callback(data)
		        });
		    }
			
		    function salvar(book, authors, callback) {
		        $http({
		            method:'POST',
		            url:'/book/save',
		            data:{bookJSON : angular.toJson(book), authorsJSON: authors}  
		        }).success(function (data) {
		            if (callback) callback(data)
		        });
		    }
		    
		    function deleteBook(book, callback) {
		        $http({
		            method:'POST',
		            url:'/book/delete',
		            data: JSON.stringify(book)  
		        }).success(function (data) {
		            if (callback) callback(data)
		        });
		    }

		    return {
		        listar:listar,
		        salvar:salvar,
		        deleteBook: deleteBook
		    };

		}])
		.controller('bookManagerController', ['$scope', 'bookService',function($scope, bookService) {
			$scope.authors = [{name:''}];
			
			bookService.listar(function(books) {
		        $scope.books = books;
		    });
			
			$scope.salvar = function(book, authors) {
		       bookService.salvar(book, authors, function(book) {
		    	   bookService.listar(function(books) {
				        $scope.books = books;
				    });
		       })
			}
			
			$scope.deleteBook = function(book) {
		       bookService.deleteBook(book, function(book) {
		    	   bookService.listar(function(books) {
				        $scope.books = books;
				    });
		       })
			}
			
			$scope.updateBook = function(book) {
				$scope.book = book;
				$scope.authors = [];
				
				for (index = 0; index < book.authors.length; index++) {
				    $scope.authors.push({name: book.authors[index]});
				}
			}
			
			$scope.addAuthor = function() {
				$scope.authors.push({name:''});
		    }
			
			$scope.removeAuthor = function(index) {
				var isRemove = confirm('Are you sure you want to delete this author?')
				
				if(isRemove) {
					$scope.authors.splice(index, 1);
				}
		    }

		}]);
		
	</script>
</body>
</html>