<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cadastrar Usuário</title>
</head>
<body>	 
	<spring:url value="/user/save" var="userActionUrl" />
	
	<form:form method="post" commandName="user" enctype="multipart/form-data" action="${userActionUrl}">
		<table>
		<tr>
			<td>Name: </td>
			<td><form:input path="name" /></td>			
		</tr>
		<tr>
			<td>Choose the Book: </td>
			<td>
				<form:select path="books" multiple="true"
					items="${books}" itemLabel="name" itemValue="id" cssStyle="min-width: 100%"/>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="right"><input type="submit" value="Save" /> <input type="reset" value="Reset" /></td>
		</tr>
		<tr>
			<td><a href="/user">&lt;&lt;Back</a></td>
		</tr>
    </form:form>
</body>
</html>