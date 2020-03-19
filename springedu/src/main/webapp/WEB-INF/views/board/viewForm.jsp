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
<link rel="stylesheet" href="<c:url value='/resources/css/viewForm.css'/>">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css">
<script src="<c:url value='/resources/js/common.js'/>"></script>
<script>
	window.addEventListener("load", init, false);
	function init(){
	  changeMode(false);
      
      //답글
      replyBtn.addEventListener("click", function(e){
        e.preventDefault();
        console.log("답글");
        let returnPage = e.target.getAttribute('data-returnPage');
   		let bnum = e.target.getAttribute('data-bnum');
  		location.href = getContextPath() + "/board/replyForm/" + returnPage + "/" + bnum ;
      },false)
        
      //수정
      let modifyBtn = document.getElementById("modifyBtn") || null;
      if(modifyBtn!=null){
        modifyBtn.addEventListener("click",function(e){
          e.preventDefault();
          let bnum = e.target.getAttribute("data-bnum");
          console.log("수정");
          changeMode(true);
        },false)
      }
        
	  //목록 버튼 클릭시
	  listBtn.addEventListener("click", function(e) {
       e.preventDefault();
  	   let returnPage = e.target.getAttribute('data-returnPage') // 자바스크립트가 분리되는 경우 해당 값을 탐색 필요
       console.log(returnPage);
	   //location.href= getContextPath() + "/board/" + ${returnPage}; 자바스크립트가 분리되지 않은경우에만 EL과 함께 사용가능 
	   location.href= getContextPath() + "/board/list/" + returnPage;
	  },false)
    
      //삭제
      let deleteBtn = document.getElementById("deleteBtn") || null;
      if(deleteBtn != null){
  	  deleteBtn.addEventListener("click", function(e){
  	   e.preventDefault();
  	   console.log("삭제" + e.target.getAttribute('data-bnum'))
         if(confirm("삭제하시겠습니까?")){
      	 let returnPage = e.target.getAttribute('data-returnPage')
      	 let bnum = e.target.getAttribute('data-bnum')
      	 location.href = getContextPath() + "/board/delete/" + returnPage + "/" + bnum ;
         }
        },false)
      }
      
      //취소(수정모드 -> 읽기모드)
      cancelBtn.addEventListener("click",function(e){
        e.preventDefault();
        console.log("취소");
        changeMode(false);
      },false)
      
      //저장
      saveBtn.addEventListener("click",function(e){
        e.preventDefault();
        console.log("저장")//유효성 체크
        
        //
        document.getElementById("boardVO").submit();
      })
          
      
	   //첨부파일 1건 삭제 : Ajax로 구현함.
       let fileList = document.getElementsByClassName("fileList");
       if(fileList !=null){
    	   Array.from(fileList).forEach(ele =>{
		     ele.addEventListener("click", function(e){
		  		 let fid;
		  		 if(ele!=null && e.target.tagName == "I"){//태그 이름을 대문자로 읽어옴
		  		  console.log(e.target); //이벤트가 발생한 요소
		  		  console.log(e.currentTaget); //이벤트가 등록된 요소
		          //선택된 요소가 i가 아닐때는 실행 취소
		          //if(e.target.tagName!="i") return;
		  		  //실제 이벤트가 발생한 요소의 data-del_file 속성 읽어오기
		  		  fid = e.target.getAttribute("data-del_file");
		  		  console.log(fid);
	          	  }//if
		  		  var xhttp = new XMLHttpRequest();
		  		
		  		  xhttp.addEventListener("readystatechange", ajaxCall, false);
		  		  function ajaxCall(){
		  			if(this.readyState == 4 && this.status == 200){
		  			 console.log(this.responseText);
		  			 /* var jsonObj = JSON.parse(this.responseText); */
		  			 if(this.responseText){
					  	console.log('성공!!');
					  	//삭제대상 요소 찾기
 					  	let delTag = e.target.parentElement.parentElement.parentElement;
 					  	//부모요소에서 삭제대상 요소 제거
					  	/* ele.removeChild(delTag); */
					  	delTag.remove(); 
					 }
					}
				  }
				  xhttp.open("DELETE", "http://localhost:9080/portfolio/board/file/" + fid,true)
				  xhttp.send();
		     },false)//ele.addEventListener
   	 	 })//Array.from(fileList).forEach
       }//if(fileList !=null
	}//function init(){
    function changeMode(flag){
      const rmodes = document.getElementsByClassName("rmode");
      const umodes = document.getElementsByClassName("umode");
      //수정모드
      if(flag){
        //제목변경 => 게시글 보기
        document.getElementById("title").textContent='게시글 수정';
        //분류필드, 제목, 내용 필드
        document.getElementById("boardCategoryVO.cid").removeAttribute("disabled");
        document.getElementById("btitle").removeAttribute("readOnly");
        document.getElementById("bcontent").removeAttribute("readOnly");

        //수정모드 버튼 활성화
        Array.from(rmodes).forEach(e=>{e.style.display="none";});
        Array.from(umodes).forEach(e=>{e.style.display="block";});
      //읽기모드  
      }else{
        //제목 변경 => 게시글 보기
        document.getElementById("btitle").textContent = "게시글 보기";
        //분류필드, 제목, 내용 필드
        document.getElementById("boardCategoryVO.cid").setAttribute("disbled",true);
        document.getElementById("btitle").setAttribute("readOnly",true);
        document.getElementById("bcontent").setAttribute("readOnly", true);
        //읽기 모드 버튼 활성화
        Array.from(rmodes).forEach(e=>{e.style.display="block";});
        Array.from(umodes).forEach(e=>{e.style.display="none";});
      }
    }  
</script>

<body>
<c:set var="contextRoot" value="${pageContext.request.contextPath }" />

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
    <form:form action="${contextRoot }/board/modify/${returnPage }"
    		   class="viewFormContainer" 
    		   enctype="multipart/form-data"
    		   method="post"
      		   modelAttribute="boardVO">
      <form:hidden path="bnum" />
   	  <div id="title">게 시 글 읽 기</div>
      <div>
        <form:label path="boardCategoryVO.cid" for="">분류</form:label>
        <form:select path="boardCategoryVO.cid" style="width: 100%;">
          <option value="0">=====선택=====</option>
          <form:options path="boardCategoryVO.cid" items="${boardCategoryVO}" itemValue="cid" itemLabel="cname" />
        </form:select>
        <form:errors path="boardCategoryVO.cid"></form:errors>
      </div>
      <div>
        <form:label path="bnum">글번호</form:label>
        <form:input type="text" style="width: 100%;" readonly="true" path="bnum" />
      </div>
      <div>
        <form:label path="btitle">제목</form:label>
        <form:input type="text" style="width: 100%;" readonly="true" path="btitle" />
      </div>
      <form:errors path="btitle"></form:errors>
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
        <form:textarea rows="10" cols="100" style="width: 99%;" readonly="true" path="bcontent" />
      </div>
      <form:errors path="bcontent"></form:errors>
      
    
      <div id="buttonBox">
        <form:button class="btn rmode" id="replyBtn" data-returnPage="${returnPage }" data-bnum="${boardVO.bnum }">
          답글</form:button>
        <!-- 작성자만 수정, 삭제 가능 시작 -->
        <c:if test="${sessionScope.member.id == boardVO.bid }">
          <form:button class="btn rmode" id="modifyBtn">수정</form:button>
          <form:button class="btn rmode" id="deleteBtn" data-returnPage="${returnPage }" data-bnum="${boardVO.bnum }">
            삭제</form:button>
        </c:if>
        <!-- 작성자만 수정, 삭제 가능 종료-->
        <form:button class="btn umode" id="cancelBtn">취소</form:button>
        <form:button class="btn umode" id="saveBtn">저장</form:button>
        <form:button class="btn" id="listBtn" data-returnPage="${returnPage }">목록</form:button>
      </div>
        <div id="attachment">
        <form:label path="files">첨부</form:label>
        <div>
          <c:forEach var="file" items="${files}">
          <div class="fileListContainer">
            <a href="${contextRoot}/board/file/${file.fid }">${file.fname }</a>
            <div class="umode" style="margin-left:10px">
              <a href="#none" class="fileList"><i class="fas fa-backspace" data-del_file="${file.fid }"></i></a>
            </div>
          </div>
          </c:forEach>
		  <form:input class="umode" type="file" multiple="multiple" path="files" />
        </div>
      </div>
    </form:form>
	<%@ include file="rereply.jsp"%>
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