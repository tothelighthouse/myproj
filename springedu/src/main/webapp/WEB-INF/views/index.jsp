<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css?family=Song+Myung&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<c:url value='/resources/css/index.css'/>">
</head>

<body>
<div class="mainback"></div>
  <div class="container">
    <div class="header">
      <div class="titleLogo">
      	<a href="/portfolio">
      		<img src="/portfolio/resources/img/titleLogo.jpg" alt="">
      	</a>
      </div>
      <c:choose>
	  	  <c:when test="${empty member.id }">
			<div><a href="${pageContext.request.contextPath }/loginForm">로그인</a></div>
			<div><a href="<c:url value='/member/joinForm'/>">회원가입</a></div>
			<div>고객센터</div>
		  </c:when>
		  
	      <c:when test="${!empty member.id && member.id ne 'admin@test.com' }">
	      	<div><a href="<c:url value='/member/modifyForm/${sessionScope.member.id }'/>">${member.nickname } 님 </a></div>
	        <div><a href="/portfolio/logout">로그아웃</a></div>
	        <div>고객센터</div>
	      </c:when>
	      
		  <c:when test="${!empty member.id && member.id eq 'admin@test.com' }">
	      	<div><a href="<c:url value='/member/modifyForm/${sessionScope.member.id }'/>">${member.nickname } 님 </a></div>
	        <div><a href="/portfolio/logout">관리자 페이지</a></div>
	        <div><a href="/portfolio/logout">로그아웃</a></div>
	      </c:when>
      </c:choose>	  
    </div>
    <div class="upperMenu">
      <div class="searchBar">
        <select name="" id="">
          <option value="">책제목</option>
          <option value="">판매자 아이디</option>
        </select>
        <input type="input">
        <input type="button" value="검색">
      </div>
      <div class="upperMenuItem">
        <div class="bookCategory">
          <div class="bookCategoryTitle">전체분류보기</div>
          <div class="bookCategoryDetail">
            <div></div>
            <div></div>
            <div></div>
            <div>분류1</div>
            <div>분류2</div>
            <div>분류3</div>
            <div>분류4</div>
            <div>분류5</div>
            <div>분류6</div>
            <div>분류7</div>
            <div>분류8</div>
            <div>분류9</div>
            <div>분류10</div>
            <div>분류11</div>
            <div class="hoverArea">분류12</div>
          </div>
        </div>
        <div>책판매하기</div>
        <div>파워북샵</div>
        <div><a href="<c:url value='/board/list'/>">자유게시판</a></div>
      </div>
    </div>
    <div class="body">
      <div class="realTime">
        <div class="realTimeMenu">
          <div>실시간 등록도서</div>
          <div>더보기</div>
        </div>
        <div class="realTimeBody">
          <div class="realTimeItem">
            <div class="rtTitle">실시간등록도서 1</div>
            <div class="rtHover">
              <div class="detail">상세</div>
              <div class="buy">즉시 구입</div>
              <div class="cart">장바구니</div>
            </div>
          </div>
        </div>
      </div>
      <div class="usedBest">
        <div class="usedBestMenu">
          <div>중고 BEST</div>
          <div>더보기</div>
        </div>
        <div class="usedBestBody">
          <div>중고도서1</div>
          <div>중고도서2</div>
          <div>중고도서3</div>
          <div>중고도서4</div>
          <div>중고도서5</div>
          <div>중고도서6</div>
          <div>중고도서7</div>
          <div>중고도서8</div>
          <div>중고도서9</div>
          <div>중고도서10</div>
          <div>중고도서11</div>
          <div>중고도서12</div>
        </div>
      </div>
      <div class="powerBookShop">
        <div class="powerBookShopMenu">
          <div>파워북 샵</div>
          <div>더보기</div>
        </div>
        <div class="powerbookShopBody">
          <div>파워북샵1</div>
          <div>파워북샵2</div>
          <div>파워북샵3</div>
          <div>파워북샵4</div>
          <div>파워북샵5</div>
          <div>파워북샵6</div>
          <div>파워북샵7</div>
          <div>파워북샵8</div>
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