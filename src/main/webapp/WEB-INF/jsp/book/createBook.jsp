<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Book</title>
</head>
<body>
	
	<spring:url value="/book" var="userActionUrl" />

	<form:form method="post" commandName="book"
		enctype="multipart/form-data" action="${userActionUrl}">
		<table>
			<tr>
				<td>Name:</td>
				<td><form:input path="name" /></td>
			</tr>
			<tr>
				<td>Year:</td>
				<td><form:input path="year" /></td>
			</tr>
			<tr>
				<td colspan="2" align="right"><input type="submit" value="Save" />
					<input type="reset" value="Reset" /></td>
			</tr>
			<tr>
				<td><a href="/user">&lt;&lt;Back</a></td>
			</tr>
		</table>
	</form:form>



	<h2>Livros Cadastrados</h2>
	<table>
		<tr>
			<td>Nome</td>
			<td>Ano</td>
			<td>Autores</td>
		</tr>
		<c:forEach items="${books}" var="book">
			<tr>
				<td>${book.name}</td>
				<td>${book.year}</td>
				<td>
					<ul>
						<c:forEach items="${book.authors}" var="author">
							<li>${author}</li>
						</c:forEach>
					</ul>
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>