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
    <link rel="stylesheet" href="<c:url value='/resources/css/memberModify.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Jua&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css">
    <script src="<c:url value='/resources/js/memberModify.js'/>"></script>
</head>
<body>
    <form:form modelAttribute="mvo" action="${pageContext.request.contextPath}/member/modify" id="memberJoinForm" method="post">
        <div class="container">
            <div class="content">
                <div class="gnb">
                    <div class="gnbsub hamburger"><i class="fas fa-bars fa-1x"></i></div>
                    <div class="gnbsub logo"><img src="${pageContext.request.contextPath }/resources/img/titleLogo.jpg" alt=""></div>
                    <div class="gnbsub searchIcon"><i class="fas fa-search fa-1x"></i></div>
                    <div class="gnbsub basket"><i class="fas fa-shopping-basket fa-1x"></i></div>
                </div>
                <h2 class="join-title">회원 정보 수정</h2>
                <div><form:label path="id">아이디</form:label></div>
                <div><form:input type="text" path="id" value="${sessionScope.member.id }" readonly="true"/><i class="far fa-paper-plane"></i></div>
                <!-- <div><span class="errmsg" id="id_errmsg"></span></div> -->
                <div><form:errors path="id" cssClass="errmsg" id="id_errmsg"></form:errors></div>
                
				<div><form:label path="nickname">별명</form:label></div>
                <div><form:input type="text" path="nickname" value="${memberVO.nickname }"/><i class="far fa-paper-plane"></i></div>
                <!-- <div><span class="errmsg" id="id_errmsg"></span></div> -->
                
                <div><form:label path="pw">비밀번호</form:label></div>
                <%-- <div><form:input type="password" path="pw"/><i class="fas fa-key"></i></div> --%>
                <div><form:input type="password" path="pw"/><i class="fas fa-key"></i></div>
                <!-- <div><span class="errmsg" id="pw_errmsg"></span></div> -->
				<div><form:errors path="pw" cssClass="errmsg" id="pw_errmsg"></form:errors></div>
                
                <div><label for="pwChk">비밀번호 재확인</label></div>
                <div><input type="password" id="pwChk"><i class="fas fa-key"></i></div>
                <div><span class="errmsg" id="pwChk_errmsg"></span></div>
                <div><form:label path="tel">전화번호</form:label></div>
                <div><form:input type="tel" path="tel" value="010-1234-1234"/><i class="fas fa-mobile-alt"></i></div>
                <!-- <div><span class="errmsg" id="tel_errmsg"></span></div> -->
                <div><form:errors path="tel" cssClass="errmsg" id="tel_errmsg"></form:errors></div>
                <div><form:label path="region">지역</form:label></div>
                <div>
					<form:select path="region">
                        <form:option value="0">== 선택 ==</form:option>
                        <form:options items="${region }" itemValue="code" itemLabel="label"/>
                    </form:select>
                
<%--                     <select name="region" id="region">
                        <option value="">== 선택 ==</option>
                        <option value="서울" ${memberVO.region == "서울" ? "selected='selected'" : ''}>서울</option>
                        <option value="경기" ${memberVO.region == "경기" ? "selected='selected'" : ''}>경기</option>
                        <option value="대구" ${memberVO.region == "대구" ? "selected='selected'" : ''}>대구</option>
                        <option value="부산" ${memberVO.region == "부산" ? "selected='selected'" : ''}>울산</option>
                        <option value="울산" ${memberVO.region == "울산" ? "selected='selected'" : ''}>부산</option>
                    </select>
 --%>                </div>
                <div><span class="errmsg" id="region_errmsg"></span></div>
                <div><form:errors path="region" cssClass="errmsg" id="pw_errmsg"></form:errors></div>
                
                <div><form:label path="gender">성별</form:label></div>
                <div>
					<form:radiobuttons path="gender" items="${gender }" itemValue="code" itemLabel="label"/>
                    <%-- <form:input type="radio" path="gender" id="1" value="남" checked="checked"/><form:label path="men">남</form:label> --%>
                    <%-- <form:input type="radio" path="gender" id="2" value="여"/><form:label path="women">여</form:label> --%>
                </div>
                <div><form:errors path="gender" cssClass="errmsg" id="gender_errmsg"></form:errors></div>
                
                
								<div><form:label path="birth">생년월일</form:label></div>
                <div><form:input type="date" path="birth"/><i class="fas fa-mobile-alt"></i></div>
                <div><form:errors path="birth" cssClass="errmsg" id="birth_errmsg"></form:errors></div>
                <!-- <div><span class="errmsg" id="birth_errmsg"></span></div> -->
                
                <div><button type="submit" id="modifyBtn">수 정 하 기</button></div>
                
                <div class="footer">
                    <div class="footerWrapper1">
                        <div class="footerContainer container1">
                            <div class="cusCenter"><span>고객만족센터</span></div>
                            <div class="cusDetail">
                                <div class="cusContanct"><span>1544-2929</span></div>
                                <div class="cusTimeDay"><span>상담시간 : 평일 오전 9시 ~ 오후 6시 </span></div>
                                <div class="cusTimeWeekend"><span> 점심시간 : 오전 12시 ~ 오후 1시 휴무일 : 토,일 공휴일 </span></div>
                            </div>
                        </div>
                    </div>
                    <div class="footerWrapper2">
                        <div class="footerContainer container2">
                            <div class="companyInt"><span>회사소개/개인정보취급방침/이용약관/고객센터</span></div>
                        </div>
                        <div class="footerContainer container3"><span>Copyright 2007 ㈜ 샤캄. All rights reserved [사업자정보] 대표전화 : 1544 -2949 | 대표(CEO) : 구정근 | 개인정보 보호책임자 : 권기현 사업자등록번호 : 101-81-98107 | 통신판매업 신고번호 : 제 2017-인천강화-0057호. 인천광역시 강화군 길상면 해안남로 814, 2층 | Email : help@bookoa.com</span></div>
                    </div>
                </div>
            </div>
        </div>
    </form:form>
</body>
</html>