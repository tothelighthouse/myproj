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
  <link rel="stylesheet" href="<c:url value='/resources/css/findPWForm.css'/>">
  <script src="<c:url value='/member/js/findPWForm.js'/>" charset="utf-8"></script>
</head>
<body>
  <div class="container">
    <div class="login-wrapper">
<!--       <form id="loginForm" action="/myweb/login" method="post"> -->
      <form id="findPWForm" method="post">
        <div><h3 class="login-title">비 밀 번 호 찾 기</h3></div>
        <div class="login-content">
          <div><input class="fixed" type="text" name="id" id="id" value="" placeholder="아이디"></div>
          <div><span id="idMsg"></span></div>
          <div><input class="fixed" type="tel" name="tel" id="tel" value="" placeholder="전화번호"></div>
          <div><span id="telMsg"></span></div>
          <div><input class="fixed" type="date" name="birth" id="birth" placeholder="생년월일"></div>
          <div><span id="birthMsg" class="errmsg">${error }</span></div>
          <div><input class="pw before" type="password" name="pw" id="pw" value="" placeholder="새로운 비밀번호"></div>
          <div><span id="pwMsg"></span></div>
          
          <div><input class="pw before" type="password" name="pwChk" id="pwChk" value="" placeholder="비밀번호 재확인"></div>
          <div><span id="pwChkMsg"></span></div>
          
          <div><input type="button" name="" id="findPWBtn" value="비밀번호 찾기"></div>
        </div>
      </form>
   </div>
  </div>
</body>
</html>