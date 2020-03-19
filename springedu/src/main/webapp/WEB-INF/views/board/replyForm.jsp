<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link href="https://fonts.googleapis.com/css?family=Song+Myung&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<c:url value='/resources/css/replyForm.css'/>">
<script src="<c:url value='/resources/js/common.js'/>"></script>
<script>
	window.addEventListener("load", init,false)
	function init(){
		//등록 버튼 클릭시
		writeBtn.addEventListener("click", function(e) {
			e.preventDefault();



			document.getElementById("boardVO").submit();
		})
		//취소 버튼 클릭시
		cancelBtn.addEventListener("click", function(e) {
			e.preventDefault();
			document.getElementById("boardVO").reset();
			
		})
		//목록 버튼 클릭시
		listBtn.addEventListener("click", function(e) {
			e.preventDefault();
            let returnPage = e.target.getAttribute("data-returnPage")
			location.href= getContextPath() + "/board/list/" + returnPage;
		},false)

	}
</script>
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
 <div>답글쓰기 페이지</div>
  <form:form action="${pageContext.request.contextPath }/board/reply/${returnPage }" 
      		 class="writeFormContainer"
      		 enctype="multipart/form-data"
             method="post" 
    		 modelAttribute="boardVO">
    <form:hidden path="boardCategoryVO.cid" value="${boardVO.boardCategoryVO.cid }" />
    <form:hidden path="bgroup" value="${boardVO.bgroup }" />
    <form:hidden path="bstep" value="${boardVO.bstep }" />
    <form:hidden path="bindent" value="${boardVO.bindent }" />
    <div>
      <form:label path="boardCategoryVO.cid">분류</form:label>
      <form:select path="boardCategoryVO.cid" style="width: 100%;" disabled="true">
        <option value="0">=====선택=====</option>
        <form:options path="boardCategoryVO.cid" items="${boardCategoryVO}" itemValue="cid" itemLabel="cname" />
      </form:select>
      <div>
        <form:errors path="boardCategoryVO.cid"></form:errors>
      </div>
    </div>
    <div>
      <form:label path="btitle">제목</form:label>
      <form:input type="text" style="width: 100%;" path="btitle" />
    </div>
    <div>
      <form:errors path="btitle"></form:errors>
    </div>
    <div>
      <form:label path="bid">작성자</form:label>
      <form:input type="text" style="width: 100%;" readonly="true" path="bid" />
    </div>
    <div>
      <form:label path="bnickname">별칭</form:label>
      <form:input type="text" style="width: 100%;" readonly="true" path="bnickname" />
    </div>
    <div>
      <form:label path="bcontent">내용</form:label>
      <form:textarea rows="10" cols="100" style="width: 99%;" path="bcontent" />
    </div>
    <div>
      <form:errors path="bcontent"></form:errors>
    </div>

    <div>
      <form:label path="files">첨부</form:label>
      <form:input type="file" multiple="multiple" path="files" />
      <div>
        <form:errors path="files"></form:errors>
      </div>
    </div>
    <div id="writeMenu">
      <form:button id="writeBtn">등록</form:button>
      <form:button id="cancelBtn">취소</form:button>
      <form:button id="listBtn" data-returnPage="${returnPage }">목록</form:button>
    </div>
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