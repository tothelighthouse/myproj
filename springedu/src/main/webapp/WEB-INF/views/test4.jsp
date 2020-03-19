<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form:form modelAttribute="per">
	<!-- <form action="t10" method="post"> -->
		<form:input type="text" path="name"/>
		<form:errors path="name"/>
		<form:input type="text" path="age" />
		<form:errors path="age"/>
		
		<input type="submit" value="제출">
	</form:form>
</body>
</html>