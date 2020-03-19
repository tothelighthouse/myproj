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
  <link rel="stylesheet" href="<c:url value='/resources/css/findPWForm.css'/>">
  <script src="<c:url value='/member/js/findPWForm.js'/>" charset="utf-8"></script>
</head>
<body>
  <div class="container">
    <div class="login-wrapper">
<!--       <form id="loginForm" action="/myweb/login" method="post"> -->
      <form id="findPWForm" method="post">
        <div><h3 class="login-title">�� �� �� ȣ ã ��</h3></div>
        <div class="login-content">
          <div><input class="fixed" type="text" name="id" id="id" value="" placeholder="���̵�"></div>
          <div><span id="idMsg"></span></div>
          <div><input class="fixed" type="tel" name="tel" id="tel" value="" placeholder="��ȭ��ȣ"></div>
          <div><span id="telMsg"></span></div>
          <div><input class="fixed" type="date" name="birth" id="birth" placeholder="�������"></div>
          <div><span id="birthMsg" class="errmsg">${error }</span></div>
          <div><input class="pw before" type="password" name="pw" id="pw" value="" placeholder="���ο� ��й�ȣ"></div>
          <div><span id="pwMsg"></span></div>
          
          <div><input class="pw before" type="password" name="pwChk" id="pwChk" value="" placeholder="��й�ȣ ��Ȯ��"></div>
          <div><span id="pwChkMsg"></span></div>
          
          <div><input type="button" name="" id="findPWBtn" value="��й�ȣ ã��"></div>
        </div>
      </form>
   </div>
  </div>
</body>
</html>