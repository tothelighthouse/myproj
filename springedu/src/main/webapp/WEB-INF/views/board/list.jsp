<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css?family=Song+Myung&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css">
<link rel="stylesheet" href="<c:url value='/resources/css/list.css'/>">
<style>
a.on {
	background-color: pink;
}


</style>
<script src="<c:url value='/resources/js/common.js'/>"></script>

<script>
window.addEventListener("load", init,false)
function init(){
	writeBtn.addEventListener("click", function(e){
		e.preventDefault();
        let returnPage = e.target.getAttribute("data-returnPage")
		location.href=getContextPath() + "/board/writeForm/" + returnPage;
	},false)
    //검색버튼 클릭시
    searchBtn.addEventListener("click", function(e){
      e.preventDefault();
      console.log("검색!!");
      //검색어 입력값이 없으면
      if(keyword.value.trim().length == 0){
        alert("검색어를 입력하세요");
        keyword.value="";
        keyword.focus();
        return false;
      }

      let stype = searchType.value; // 검색유형
      let kword = keyword.value;    // 검색어

      location.href = getContextPath() + "/board/list/" + "1/" + stype + "/" + kword;
      
    },false)
}

</script>
</head>
<body>
<c:set var="contextRoot" value="${pageContext.request.contextPath }"/>

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
      <div class="boardContainer">
        <div class="tmenu">
          <div>목록개수</div>
          <select name="" id="boardItemCnt">
            <option value="10">10개</option>
            <option value="20">20개</option>
            <option value="30">30개</option>
            <option value="40">40개</option>
          </select>
          <input type="button" id="cntBtn" value="선택">
        </div>
        <div class="th">
          <div class="bnum">No</div>
          <div class="category">분류</div>
          <div class="title">제목</div>
          <div class="bid">ID</div>
          <div class="bnickname">별명</div>
          <div class="bcdate">작성일</div>
          <div class="bhit">조회수</div>
        </div>
        <div class="tbody">
        
       	<c:forEach var="rec" items="${list}">
		<fmt:formatDate value="${rec.bcdate }" pattern="yyyy/MM/dd -- HH:mm" var="cdate"/>
          <div class="tr" id="tr">
            <div class="bnum">${rec.bnum }</div>
            <div class="category">${rec.boardCategoryVO.cname }</div>
            <div class="title">
			  <c:forEach begin="1" end="${rec.bindent}">-</c:forEach>
                <c:if test="${rec.bindent > 0}">
                <i class="fas fa-reply-all"></i>
                </c:if>
				<a href="${pageContext.request.contextPath}/board/view/${pc.rc.reqPage}/${rec.bnum }">
				${rec.btitle }
				</a>
            </div>
            <div class="bid">${rec.bid }</div>
            <div class="bnickname">${rec.bnickname }</div>
            <div class="bcdate">${cdate}</div>
            <div class="bhit">${rec.bhit}</div>
          </div>
        </c:forEach>
          
        </div>
        <div class="tfoot">
          <div id="writeBtn">
            <input type="button" value="글쓰기" data-returnPage = ${pc.rc.reqPage}>
          </div>
        </div>
        <div class="paging">
	        <c:if test="${pc.prev }">
				<a href="${contextRoot}/board/list/1/${pc.fc.searchType }/${pc.fc.keyword }"><i class="fas fa-angle-double-left"></i></a>
				<a href="${contextRoot}/board/list/${pc.startPage - 1}/${pc.fc.searchType }/${pc.fc.keyword }"><i class="fas fa-angle-left"></i></a>
	        </c:if>
        	<c:forEach var="pageNum" begin="${pc.startPage }" end="${pc.endPage }">
            <!-- 현재 페이지와 요청 페이지가 다르면 -->
	            <c:if test="${pc.rc.reqPage != pageNum }">
	              <c:choose>
		              <c:when test="${pc.fc.searchType!=null && pc.fc.keyword!=null }">
		  			    <a href="${contextRoot }/board/list/${pageNum}/${pc.fc.searchType }/${pc.fc.keyword }" class="off">${pageNum }</a>
		  			  </c:when>
	              	  <c:when test="${pc.fc.searchType==null && pc.fc.keyword==null }">
				   		<a href="${contextRoot }/board/list/${pageNum}" class="off">${pageNum }</a>
	              	  </c:when>
              	  </c:choose>
	            </c:if>
            <!-- 현재 페이지와 요청페이지가 같으면 -->
            <c:if test="${pc.rc.reqPage == pageNum }">
	            <c:choose>
	              <c:when test="${pc.fc.searchType!=null && pc.fc.keyword!=null }">
				   <a href="${contextRoot }/board/list/${pageNum}/${pc.fc.searchType }/${pc.fc.keyword }" class="on">${pageNum }</a>
	              </c:when>
	              <c:when test="${pc.fc.searchType==null && pc.fc.keyword==null }">
				   <a href="${contextRoot }/board/list/${pageNum}" class="on">${pageNum }</a>
	              </c:when>
	            </c:choose>
            </c:if>
         	</c:forEach>
	        <c:if test="${pc.next }">
				<a href="${contextRoot}/board/list/${pc.endPage + 1 }/${pc.fc.searchType }/${pc.fc.keyword }"><i class="fas fa-angle-right"></i></a>
				<a href="${contextRoot}/board/list/${pc.finalEndPage }/${pc.fc.searchType }/${pc.fc.keyword }"><i class="fas fa-angle-double-right"></i></a>
	        </c:if>
        </div>
        <form class="searchMenu">
		  <select name="searchType" id="searchType">
	          <option value="TC"
	           <c:out value="${pc.fc.searchType == 'TC' ? 'selected' :''}" />>제목+내용</option>
	          <option value="T"
	           <c:out value="${pc.fc.searchType == 'T' ? 'selected' :''}" />>제목</option>
	          <option value="C"
	           <c:out value="${pc.fc.searchType == 'C' ? 'selected' :''}" />>내용</option>
	          <option value="N"
	           <c:out value="${pc.fc.searchType == 'N' ? 'selected' :''}" />>작성자</option>
	          <option value="I"
	           <c:out value="${pc.fc.searchType == 'I' ? 'selected' :''}" />>아이디</option>
          </select>
           <input type="search" id="keyword" name="keyword" value="${pc.fc.keyword }">
           <button id="searchBtn">검색</button>
        </form>  
      
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