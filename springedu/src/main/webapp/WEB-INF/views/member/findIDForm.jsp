<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>로 그 인</title>
  <link rel="stylesheet" href="<c:url value='/resources/css/findIDForm.css'/>">
  <script src="${pageContext.request.contextPath }/resources/js/findIDForm.js"></script>
</head>
<body>
  <div class="container">
    <div class="login-wrapper">
<!--       <form id="loginForm" action="/myweb/login" method="post"> -->
      <form id="findForm" method="post">
        <div><h3 class="login-title">아 이 디 찾 기</h3></div>
        <div class="login-content">
          <div><input type="tel" name="tel" id="tel" value="" placeholder="전화번호"></div>
          <div><span id="telMsg"></span></div>
          <div><input type="date" name="birth" id="birth" placeholder="생년월일"></div>
          <div><span id="birthMsg" class="errmsg">${error }</span></div>
          <div><input type="text" name="id" id="id" value="" placeholder="찾은 아이디"></div>
          <div><input type="button" name="" id="findIDBtn" value="아이디 찾기"></div>
        </div>
      </form>
<%--       <div class="find_info">
        <a href="<c:url value='/member/findId'/>">아이디 찾기</a>
        <span>|</span>
        <a href="#">비밀번호 찾기</a>
        <span>|</span>
        <a href="<c:url value='/member/joinForm'/>">회원가입</a>
      </div>
 --%>    </div>
  </div>
</body>
</html>