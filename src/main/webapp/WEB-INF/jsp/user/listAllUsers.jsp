
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Page</title>
</head>
<body>
	<ul class="menu">
		<li><a href="/user/form">Create new User</a></li>
		<li><a href="/book/form">Create new Book</a></li>
	</ul>
	<br>
	
	<h2>Saved Users</h2>
	<table>
		<tr>
			<td>Name</td>
			<td>Book</td>
			<td></td>
			<td></td>
		</tr>
		<c:forEach items="${usuarios}" var="usuario">
			<tr>
				<td>
					${usuario.name} 
				</td>
				<td>
					<ul>
						<c:forEach items="${usuario.books}" var="book">
							<li> ${book.name}</li>
						</c:forEach>
					</ul>
				</td>
				<td>
					<a href="/user/${usuario.id}/update">Update</a>
				</td>
				<td>
					<a href="/user/${usuario.id}/excluir" onclick="return confirm('Do you really want to delete this user?')">Delete</a>
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>