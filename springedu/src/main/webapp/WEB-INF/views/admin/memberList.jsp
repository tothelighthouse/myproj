<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<scrip src="<c:url value='/resources/css/memberList.js'/>"></scrip>
<style>
	table{
		border-collapse: collapse;
	}


</style>
</head>
<body>
	<table border="1">
	<caption><h3>회원 목록 리스트</h3></captionn>
	<colgroup>
		<col width="20%">
		<col width="10%">
		<col width="10%">
		<col width="10%">
		<col width="5%">
		<col width="5%">
		<col width="10%">
	</colgroup>
	<thead>
		<tr>
			<th>ID</th>
			<th>PW</th>
			<th>TELEPHON NO.</th>
			<th>NICKNAME</th>
			<th>GENDER</th>
			<th>REGION</th>
			<th>BIRTH DATE</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="rec" items="${memberList}">
		<tr>
			<td id="id">${rec.id }</td>
			<td>${rec.pw }</td>
			<td>${rec.tel }</td>
			<td>${rec.nickname }</td>
			<td>${rec.gender }</td>
			<td>${rec.region}</td>
			<td>${rec.birth}</td>
			<td><button id="modiBtn">수정</button></td>
			<td><button data-id=#id.innerHTML>삭제</button></td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
	


</body>
</html>