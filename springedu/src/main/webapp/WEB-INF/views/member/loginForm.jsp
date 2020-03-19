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
  <link href="https://fonts.googleapis.com/css?family=Song+Myung&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="<c:url value='/resources/css/loginForm.css'/>">
  <script src="resources/js/login.js"></script>
</head>
<body>
  <div class="container">
	<div class="header">
      <div class="titleLogo">
      	<a href="/portfolio">
      		<img src="/portfolio/resources/img/titleLogo.jpg" alt="">
      	</a>
      </div>
	  <div><a href="${pageContext.request.contextPath }/loginForm">�α���</a></div>
	  <div><a href="<c:url value='/member/joinForm'/>">ȸ������</a></div>
      <div>������</div>
    </div>
    <div class="body">
      <div class="loginContainer">
      	<form id="loginForm" action="<c:url value='/login?reqURI=${reqURI }'/>" method="post">
          <div><input type="text" name="id" id="id" value="" placeholder="���̵�"></div>
          <div><span id="idMsg"></span></div>
          <div><input type="password" name="pw" id="pw" placeholder="��й�ȣ"></div>
          <div><span id="pwMsg" class="errmsg">${error }</span></div>
          <div><span id="pwMsg" class="errmsg">
              <c:if test="${!empty svr_msg}">${svr_msg }</c:if>
            </span></div>
          <div><input type="submit" name="" id="loginBtn" value="�� �� ��"></div>
        </form>
        <div class="find_info">
          <a href="<c:url value='/member/findIDForm'/>">���̵� ã��</a>
          <span>|</span>
          <a href="<c:url value='/member/findPWForm'/>">��й�ȣ ã��</a>
          <span>|</span>
          <a href="<c:url value='/member/joinForm'/>">ȸ������</a>
        </div>
      </div>
    </div>
  <div class="footer">
    <div class="footerMenu">
      <div>ȸ��Ұ�</div>
      <div>����������޹�ħ</div>
      <div>�̿���</div>
      <div>������</div>
    </div>
    <div class="customCenter">
      <div>������ ����</div>
      <div>1544-0909</div>
      <div>���� ���� 9�� ~ ���� 6�� </div>
      <div>���ɽð� ���� 12�� ~ ���� 1�� / ��,�� ������ �޹� </div>
    </div>
    <div class="usageRule">Copyright 2007 �� ��į. All rights reserved [���������] ��ǥ��ȭ : 1544 -2949 | ��ǥ(CEO) : ������ | ��������
      ��ȣå���� : �Ǳ��� ����ڵ�Ϲ�ȣ : 101-81-98107 | ����Ǹž� �Ű��ȣ : �� 2017-��õ��ȭ-0057ȣ. ��õ������ ��ȭ�� ���� �ؾȳ��� 814, 2�� | Email :
      help@bookoa.com
    </div>
  </div>
  </div>
</body>
</html>