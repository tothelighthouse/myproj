<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="/portfolio/test/t11" method="post">
	<!-- <form action="t10" method="post"> -->
		<input type="text" id="name" name="name" value="${person.name }">
		<input type="text" id="age" name="age" value="${person.age }">
		
		<input type="submit" value="제출">
	</form>
</body>
</html>