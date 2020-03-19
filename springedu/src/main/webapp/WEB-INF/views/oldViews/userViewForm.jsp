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
<style>
table {
	border-collapse: collapse;
}

tr td {
	border: 1px solid black;
	text-align: center;
	padding: 5px;
}

input[type="button"] {
	width: 100%;
}

.imgContainer {
	width: 20px;
	height: 20px;
}
</style>
<link href="https://fonts.googleapis.com/css?family=Song+Myung&display=swap" rel="stylesheet">
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
	   location.href= getContextPath() + "/board/" + returnPage;
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
      
      //목록
      listBtn.addEventListener("click", function(e){
        e.preventDefault();
        console.log("목록");
        let returnPage = e.target.getAttribute("data-returnPage")
        location.href=getContextPath() + "/board/" + returnPage;
        
      },false)
      
      
	   //첨부파일 1건 삭제 : Ajax로 구현함.
       let fileList = document.getElementById("fileList");
       if(fileList !=null){
	     fileList.addEventListener("click", function(e){
  		 var fileList = document.getElementById("fileList")
  		 if(fileList!=null && e.target.tagName == "I"){//태그 이름을 대문자로 읽어옴
  		  console.log(e.target); //이벤트가 발생한 요소
  		  console.log(e.currentTaget); //이벤트가 등록된 요소
          //선택된 요소가 i가 아닐때는 실행 취소
          //if(e.target.tagName!="i") return;
  		  //실제 이벤트가 발생한 요소의 data-del_file 속성 읽어오기
  		  let fid = e.target.getAttribute("date-del_file");
  		
  		  var xhttp = new XMLHttpRequest();
  		
  		  xhttp.addEventListener("readystatechange", ajaxCall, false);
  		  function ajaxCall(){
  			if(this.readyState == 4 && this.status == 200){
  			 console.log(this.responseText);
  			 var jsonObj = JSON.parse(this.responseText);
  			 if(jsonObj){
			 }
			}
		  }
		  xhttp.open("DELETE", "localhost:9080/porfolio/board/file/" + fid,true)
		  xhttp.send();
  		 }
	   },false)
   	  }
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
</html>

















