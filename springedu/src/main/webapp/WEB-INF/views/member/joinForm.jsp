<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/joinForm.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Jua&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css">
    <script src="<c:url value='/resources/js/memberJoin.js?ver=1'/>"></script>
</head>

<body>
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
    <div class="body">
      <form:form id="memberJoinForm" class="memberJoinForm" action="${pageContext.request.contextPath }/member/join"
        modelAttribute="mvo" method="post">
        <div class="join-title">회 원 가 입</div>
        <div class="idInput">
          <form:label path="id">아이디</form:label>
          <div>
            <form:input type="text" path="id" value="**@google.com" /><i class="far fa-paper-plane"></i>
          </div>
          <form:errors path="id" cssClass="errmsg" id="id_errmsg"></form:errors>
        </div>

        <div class="nickInput">
          <form:label path="nickname">별명</form:label>
          <div>
            <form:input type="text" path="nickname" value="별칭" /><i class="far fa-paper-plane"></i>
          </div>
          <form:errors path="nickname" cssClass="errmsg" id="nickname_errmsg"></form:errors>
        </div>

        <div class="pwInput">
          <form:label path="pw">비밀번호</form:label>
          <div>
            <form:input type="password" path="pw" value="abc1234" /><i class="fas fa-key"></i>
          </div>
          <form:errors path="pw" cssClass="errmsg" id="pw_errmsg"></form:errors>
        </div>
        <div class="pwChkInput">
          <label for="pwChk">비밀번호 재확인</label>
          <div>
            <input type="password" id="pwChk"><i class="fas fa-key"></i>
          </div>
          <span class="errmsg" id="pwChk_errmsg"></span>
        </div>
        <div class="telInput">
          <form:label path="tel">전화번호</form:label>
          <div>
            <form:input type="tel" path="tel" value="010-1234-1234" /><i class="fas fa-mobile-alt"></i>
          </div>
          <form:errors path="tel" cssClass="errmsg" id="tel_errmsg"></form:errors>
        </div>
        <div class="regionInput">
          <form:label path="region">지역</form:label>
          <form:select path="region">
            <form:option value="0">== 선택 ==</form:option>
            <form:options items="${region }" itemValue="code" itemLabel="label" />
          </form:select>
          <form:errors path="region" cssClass="errmsg" id="region_errmsg"></form:errors>
        </div>

        <div class="genderInput">
          <form:label path="gender">성별</form:label>
          <form:radiobuttons path="gender" items="${gender }" itemValue="code" itemLabel="label" />
          <form:errors path="gender" cssClass="errmsg" id="gender_errmsg"></form:errors>
        </div>

        <div class="birthInput">
          <form:label path="birth">생년월일</form:label>
          <div>
            <form:input type="date" path="birth" /><i class="fas fa-mobile-alt"></i>
          </div>
          <form:errors path="birth" cssClass="errmsg" id="birth_errmsg"></form:errors>
        </div>
        <div style="color:#f00;font-weight:bold;font-size:0.8rem;">${svc_msg}</div>
        <div><button type="submit" id="joinBtn">가 입 하 기</button></div>
      </form:form>
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