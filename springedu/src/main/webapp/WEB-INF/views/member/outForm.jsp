<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>�� �� ��</title>
  <link rel="stylesheet" href="<c:url value='/resources/css/out.css'/>">
  <script src="<c:url value='/member/js/out.js'/>"></script>
</head>
<body>
  <div class="container">
    <div class="login-wrapper">
      <form id="frm" action="<c:url value='/member/out'/>" method="post">
        <div><h3 class="login-title">ȸ��Ż��</h3></div>
        <div class="login-content">
          <div><input type="text" name="id" id="id" value="${sessionScope.member.id }" readonly="readonly"></div>
          <div><span id="idMsg"></span></div>
          <div><input type="password" name="pw" id="pw" placeholder="��й�ȣ"></div>
          <div><span id="pwMsg" class="errmsg"><c:if test="${!empty svr_msg }">${svr_msg }</c:if></span></div>
          <div><input type="submit" name="" id="outBtn" value="ȸ �� Ż ��"></div>
        </div>
      </form>
      <div class="find_info">
        <a href="#">���̵� ã��</a>
        <span>|</span>
        <a href="#">��й�ȣ ã��</a>
        <span>|</span>
        <a href="<c:url value='memberJoin.jsp'/>">ȸ������</a>
      </div>
    </div>
  </div>
</body>
</html>