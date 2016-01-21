<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html ng-app="userManagerApp" lang="en">
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
<title>Manage Users</title>
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
					<li class="active"><a href="/user">User</a></li>
					<li><a href="/book">Book</a></li>
				</ul>
			</div>
		</div>
	</nav>
	
	<div ng-controller="userManagerController"  style="width: 50%">		
		<form ng-submit="salvar(user, selectedBooks)" class="form-horizontal" role="form" name="form" >
			<fieldset>
				<div class="alert alert-success" role="alert" ng-show="success"> {{success}}</div>
				<div class="alert alert-error" role="alert" ng-show="error"> {{error}}</div>
				<!-- Form Name -->
				<legend>Create User</legend>

				<!-- Text input-->
				<div class="form-group">
					<label class="control-label col-md-1" for="name">Name</label>
					<div class="col-md-11">
						<input id="name" name="name" type="text"
							placeholder="Enter the user's name"
							class="form-control input-md" ng-model="user.name" required>

					</div>
				</div>

				<!-- Selected Books -->
				<div class="form-group">
					<label class="col-md-1 control-label" for="books">Choose the Books</label>
					<div class="col-md-5">
						<select id="books" name="books" multiple="true" ng-model="selectedBooks" required>
							<option ng-repeat="book in books track by $index" value="{{book}}" ng-selected="checkSelected(book)" />{{ book.name }}</option>
						</select>
					</div>
				</div>			

				<!-- Button -->
				<div class="form-group">
					<div class="col-md-offset-9">
						<input type="hidden" ng-model="book.id">
						<button id="btnSave" type="submit" class="btn btn-success">
							<span class="glyphicon glyphicon-floppy-save"/>  Save
						</button>
						<button id="btnReset" type="reset" class="btn btn-success" ng-click="clearAll(form)">
							  <span class="glyphicon glyphicon-erase"/>  Reset
						</button>
					</div>
				</div>

			</fieldset>

		</form>

		
		<table class="table table-hover">
			<thead>
				<tr>
					<h3>Saved Users</h3>
				</tr>
				<tr>
					<th>Name</th>
					<th>Books</th>
					<th></th>
				</tr>
			</thead>
			<tr ng-repeat="user in users">
				<td>{{user.name}}</td>
				<td>
					<ul ng-repeat="userBook in user.books track by $index">
						<li>{{userBook.name}}</li>
					</ul>
				</td>
				<td>
					<button type="submit" class="pull-right btn btn-danger" 
						title="Update" ng-click="updateUser(user)">
						<span class="glyphicon glyphicon-refresh"></span>
					</button>
					<button type="submit" class="pull-right btn btn-danger" 
						title="Delete" ng-click="deleteUser(user)" onclick="confirm(Are you sure you want to delete this user?)">
						<span class="glyphicon glyphicon-trash"></span>
					</button>
				</td>
			</tr>
		</table>

	</div>
	<script>
		var userManagerApp = angular.module('userManagerApp', ['ngAnimate']);
		
		//Services
		userManagerApp.factory('userService', ['$http', function($http) {

		    function listar(callback) {
		        $http({
		            method:'GET',
		            url:'user/listAll'
		        }).success(function (data) {
		            if (callback) callback(data)
		        });
		    }
			
		    function salvar(user, selectedBooks, callback) {
		        $http({
		            method:'POST',
		            url:'/user/save',
		            data: {user: angular.toJson(user), selectedBooks: selectedBooks} 
		        }).success(function (data) {
		            if (callback) callback(data)
		        }).error(function (data){
		        	$scope.error = "It was not possible to save the user";
		        });
		    }
		    
		    function deleteUser(user, callback) {
		        $http({
		            method:'POST',
		            url:'/user/delete',
		            data: JSON.stringify(user)  
		        }).success(function (data) {
		            if (callback) callback(data)
		        }).error(function (data){
		        	$scope.error = "It was not possible to delete the user";
		        });
		    }
		    
		    function listAllBooks(callback) {
		        $http({
		            method:'GET',
		            url:'user/listAllBooks'
		        }).success(function (data) {
		            if (callback) callback(data)
		        });
		    }

		    return {
		        listar:listar,
		        salvar:salvar,
		        deleteUser: deleteUser,
		        listAllBooks: listAllBooks
		    };

		}])
		
		//Controller
		userManagerApp.controller('userManagerController', ['$scope', 'userService',function($scope, userService) {
			$scope.success = "";
			$scope.error = "";
			
			var initialForm = angular.copy($scope.form);
			
			userService.listar(function(users) {
		        $scope.users = users;
		    });
			
			userService.listAllBooks(function(books) {
		        $scope.books = books;
		        
		    });
			
			$scope.salvar = function(user, selectedBooks) {
		       userService.salvar(user, selectedBooks, function(user) {
		    	   userService.listar(function(users) {
				        $scope.users = users;
				    });
		    	   
		    	   $scope.success = 'The user ' + user.name + ' was saved with success!';
		    	   
		    	   $scope.clearAll();
		    	   
		       })
			}
			
			$scope.deleteUser = function(user) {
				var isRemove = confirm('Are you sure you want to delete this user?')
				
				if(isRemove) {
			       	userService.deleteUser(user, function(user) {
			    	   userService.listar(function(users) {
			    		   $scope.users = users;
					    });
			    	   
			    	   $scope.success = 'The user was deleted with success!';
			       })
				}
			}
			
			$scope.updateUser = function(user) {				
				$scope.user = user;
			}
			
			$scope.checkSelected = function(book) {
				var isSelected = false;
				
				if($scope.user != null) {
		        	var selectedBooks = $scope.user.books;
		        	
		        	for (index = 0; index < selectedBooks.length; index++) {
		        		var selectedBook = selectedBooks[index];
		        		
		        		if(selectedBook.id == book.id) {
	        				isSelected = true; 
	        				return isSelected;
		        		}
					}
				}
				 
				 return isSelected;
			}
			
			$scope.clearAll = function() {
				$scope.user = null;
				$scope.selectedBooks = null;
			}
			
		}]);
		
	</script>
</body>
</html>