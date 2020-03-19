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
	  <div><a href="${pageContext.request.contextPath }/loginForm">로그인</a></div>
	  <div><a href="<c:url value='/member/joinForm'/>">회원가입</a></div>
      <div>고객센터</div>
    </div>
    <div class="body">
      <div class="loginContainer">
      	<form id="loginForm" action="<c:url value='/login?reqURI=${reqURI }'/>" method="post">
          <div><input type="text" name="id" id="id" value="" placeholder="아이디"></div>
          <div><span id="idMsg"></span></div>
          <div><input type="password" name="pw" id="pw" placeholder="비밀번호"></div>
          <div><span id="pwMsg" class="errmsg">${error }</span></div>
          <div><span id="pwMsg" class="errmsg">
              <c:if test="${!empty svr_msg}">${svr_msg }</c:if>
            </span></div>
          <div><input type="submit" name="" id="loginBtn" value="로 그 인"></div>
        </form>
        <div class="find_info">
          <a href="<c:url value='/member/findIDForm'/>">아이디 찾기</a>
          <span>|</span>
          <a href="<c:url value='/member/findPWForm'/>">비밀번호 찾기</a>
          <span>|</span>
          <a href="<c:url value='/member/joinForm'/>">회원가입</a>
        </div>
      </div>
    </div>
  <div class="footer">
    <div class="footerMenu">
      <div>회사소개</div>
      <div>개인정보취급방침</div>
      <div>이용약관</div>
      <div>고객센터</div>
    </div>
    <div class="customCenter">
      <div>고객만족 센터</div>
      <div>1544-0909</div>
      <div>평일 오전 9시 ~ 오후 6시 </div>
      <div>점심시간 오전 12시 ~ 오후 1시 / 토,일 공휴일 휴무 </div>
    </div>
    <div class="usageRule">Copyright 2007 ㈜ 샤캄. All rights reserved [사업자정보] 대표전화 : 1544 -2949 | 대표(CEO) : 구정근 | 개인정보
      보호책임자 : 권기현 사업자등록번호 : 101-81-98107 | 통신판매업 신고번호 : 제 2017-인천강화-0057호. 인천광역시 강화군 길상면 해안남로 814, 2층 | Email :
      help@bookoa.com
    </div>
  </div>
  </div>
</body>
</html>