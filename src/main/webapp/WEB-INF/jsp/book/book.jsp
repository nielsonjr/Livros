<!DOCTYPE html>
<html ng-app="bookManagerApp" lang="en">
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
	<nav class="navbar navbar-default navbar-static-top">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
				</button>
				<a class="navbar-brand" href="/">Home</a>
			</div>
			
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href="/user">User</a></li>
					<li class="active"><a href="/book">Book</a></li>
				</ul>
			</div>
		</div>
	</nav>
	
	<div ng-controller="bookManagerController"  style="width: 50%; padding-bottom: 60px">		
		<form ng-submit="salvar(book, authors)" class="form-horizontal" role="form" name="form" >
			<fieldset>
				<div class="alert alert-success" role="alert" ng-show="success"> {{success}}</div>
				<div class="alert alert-error" role="alert" ng-show="error"> {{error}}</div>
				<!-- Form Name -->
				<legend>Create Book</legend>

				<!-- Text input-->
				<div class="form-group">
					<label class="control-label col-md-1" for="Title">Title</label>
					<div class="col-md-11">
						<input id="Title" name="Title" type="text"
							placeholder="Enter the title fo the book"
							class="form-control input-md" ng-model="book.name" required="required">

					</div>
				</div>

				<!-- Text input-->
				<div class="form-group" ng-class="{'has-error': form.year.$error.isanumber}">
					<label class="col-md-1 control-label" for="year">Year</label>
					<div class="col-md-5">
						<input id="Year" name="year" type="text"
							placeholder="Enter the year of the book"
							class="form-control input-md" ng-model="book.year" required isanumber>
						<p class="help-block" ng-if="form.year.$error.isanumber">Please, enter a number</p>
					</div>
				</div>

				<div class="form-group">
					<div class="col-md-offset-6">
						<label> Authors <a href="#" class="btn btn-success btn-xs"
							ng-click="addAuthor()" title="Add Author"> <span
								class="glyphicon glyphicon-plus-sign" />
						</a>
						</label>
					</div>
				</div>
				<div class="form-group" ng-repeat="authorEntity in authors">
					<div class="col-md-offset-1 col-md-11" >
						<div class="input-group">
							<input type="text" ng-model="authorEntity.name"
								placeholder="Enter the Author's name" class="form-control" /> 
								
							<span class="input-group-btn">								
								<a class="pull-right btn btn-danger" title="Remove Author" ng-click="removeAuthor($index)"> 
									<span class="glyphicon glyphicon-remove-circle"></span>
								</a>
							</span>
						</div>
					</div>
				</div>

				<!-- Button -->
				<div class="form-group">
					<div class="col-md-offset-9">
						<input type="hidden" ng-model="book.id">
						<button id="btnSave" type="submit" class="btn btn-success" ng-disabled="form.year.$error.isanumber">
							<span class="glyphicon glyphicon-floppy-save"/>  Save
						</button>
						<button id="btnReset" type="reset" class="btn btn-success" ng-disabled="form.year.$error.isanumber">
							  <span class="glyphicon glyphicon-erase"/>  Reset
						</button>
					</div>
				</div>

			</fieldset>

		</form>

		
		<table class="table table-hover">
			<thead>
				<tr>
					<h3>Saved Books</h3>
				</tr>
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
	<footer>
		<div class="navbar navbar-default navbar-fixed-bottom">
			<div class="container">
				<div class="navbar-collapse collapse" id="footer-body">
					<ul class="nav navbar-nav">
						<li>Developed by Nielson da Silva Jr.<br> 
							E-mail: nielsondasilvajr@gmail.com
						</li>
					</ul>
				</div>
			</div>
		</div>
	</footer>
	<script>
		var bookManagerApp = angular.module('bookManagerApp', ['ngAnimate']);
		
		//directive
		bookManagerApp.directive('isanumber', function(){
			return {
				restrict: 'A',
				require: 'ngModel',
				
				link: function(scope, element, attrs, controller) {
					controller.$validators.isanumber = function(modelValue, viewValue) {
						isNull = (typeof viewValue === 'undefined' || viewValue === null) ;
						checkNumber = isNull || !isNaN(viewValue)
						
						
						return checkNumber;
				      };
				}
			}
		})
		
		//Services
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
		        }).error(function (data){
		        	$scope.error = "It was not possible to save the book";
		        });
		    }
		    
		    function deleteBook(book, callback) {
		        $http({
		            method:'POST',
		            url:'/book/delete',
		            data: JSON.stringify(book)  
		        }).success(function (data) {
		            if (callback) callback(data)
		        }).error(function (data){
		        	$scope.error = "It was not possible to delete the book";
		        });
		    }

		    return {
		        listar:listar,
		        salvar:salvar,
		        deleteBook: deleteBook
		    };

		}])
		
		//Controller
		bookManagerApp.controller('bookManagerController', ['$scope', 'bookService',function($scope, bookService) {
			$scope.authors = [{name:''}];
			$scope.success = "";
			$scope.error = "";
			
			bookService.listar(function(books) {
		        $scope.books = books;
		    });
			
			$scope.salvar = function(book, authors) {
		       bookService.salvar(book, authors, function(book) {
		    	   bookService.listar(function(books) {
				        $scope.books = books;
				    });
		    	   
		    	   $scope.success = 'The book ' + book.name + ' was saved with success!';
		       })
			}
			
			$scope.deleteBook = function(book) {
				var isRemove = confirm('Are you sure you want to delete this book?')
				
				if(isRemove) {
			       	bookService.deleteBook(book, function(book) {
			    	   bookService.listar(function(books) {
					        $scope.books = books;
					    });
			    	   
			    	   $scope.success = 'The book was deleted with success!';
			       })
				}
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