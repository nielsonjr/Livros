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
	<spring:url value="/user" var="userActionUrl" />
	
	<form:form method="post" commandName="user" enctype="multipart/form-data" action="${userActionUrl}">
    	<p>Nome: <form:input path="name" /></p>
        <p><input type="submit" value="Submit" /> <input type="reset" value="Reset" /></p>
    </form:form>
</body>
</html>