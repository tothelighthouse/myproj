<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html lang="en"></html>
<head>
  <meta charset="UTF-8">
  <title>Document</title>
  <link rel="stylesheet" href='<c:url value="/resources/css/rereply.css"/>'>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css" />
  <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
   <!-- 뷰포트 추가 -->
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  
  <!-- BOOTSTRAP CSS -->
<%--   <link rel="stylesheet" href="${pageContext.request.contextPath }/webjars/bootstrap/4.4.1-1/css/bootstrap.css">
 --%>  
  <script>
	window.addEventListener("load",init2,false);
	//let l_bnum = 3063;		
	let l_bnum = ${boardVO.bnum } //게시 원글번호
	let l_page = 1;				//요청페이지
	let l_id = "${sessionScope.member.id}";	//로그인 아이디
	let l_nickname = "${sessionScope.member.nickname}";	//로그인 별칭
	let l_url = "${pageContext.request.contextPath}/rboard"; //공통 URL

	const GOOD = '1', BAD = '2'; //호감'1', 비호감'2'
	
	function init2(){

	//댓글목록 가져오기
	replyList(l_page);  

	//페이지번호 클릭시 이벤트 처리
	paging.addEventListener("click",function(e){
		e.preventDefault();
			if(e.target.tagName == 'A'){
 				console.log("페이지 클릭됨!!");
 				l_page = e.target.getAttribute("href");
			replyList(l_page);
		} 
	},false);

	//댓글작성
	replyBtn2.addEventListener("click",function(){
		//console.log("댓글작성버튼 클릭됨!");
		let rcontentTag = document.getElementById("rcontent")
		let rcontent = rcontentTag.value;
		
		let xhttp = new XMLHttpRequest();
		xhttp.addEventListener("readystatechange",function(){
			if(this.readyState == 4 && this.status == 200){
				console.log(this.responseText);
				let jsObj = JSON.parse(this.responseText);
				
				if(jsObj.success == 'success'){
					console.log("댓글 작성 성공!!")
              		replyList(l_page, jsObj.rnum)
					rcontentTag.value = "";
					rcontentTag.focus();
				}else{
					console.log('댓글작성오류!!');
				}
			}
		});

		 //전송데이터 json포맷으로 만들기
     let sendData = {};
     sendData.bnum  = l_bnum;
     sendData.rid 	= l_id;
     sendData.rnickname = l_nickname;
     sendData.rcontent = rcontent;
     
     //자바스크립트 obj => json포맷 문자열 변환
     let result = JSON.stringify(sendData);
     //console.log(result);
	     				
     //post방식
     xhttp.open("POST",l_url,true);
     xhttp.setRequestHeader("Content-Type","application/json;charset=utf-8"); 
     xhttp.send(result);				
			
	},false);

	//댓글목록 이벤트 등록
	document.getElementById("replyList").addEventListener("click",function(e){
		//댓글목록에서 'I'태그의 자식 태그에서만 반응하기
		if(e.target.tagName != 'I') return false;
		//이벤트가 일어난 지점에서 data-rnum속성을 포함한 요소를 찾아서 data-rnum값을 추출한다.
		let data_rnum =	parents(e.target)
										.find( tag => {	if(tag.hasAttribute("data-rnum")){
																			return tag;
																	}})
										.getAttribute("data-rnum");
		
		if(e.target.classList.contains('replyDeleteBtn')){
			//console.log('삭제버튼 클릭됨'+data_rnum);
			if(confirm('삭제하겠습니까?')){
				doDelete(e.target, data_rnum);
			}
		}else if(e.target.classList.contains('replyModifyBtn')){
			console.log('수정버튼 클릭됨'+data_rnum);
			doModify(e.target, data_rnum);
		}else if(e.target.classList.contains('goodBtn')){
			doGoodOrBad(e.target, data_rnum, GOOD);
		}else if(e.target.classList.contains('badBtn')){
			doGoodOrBad(e.target, data_rnum, BAD);
		}else if(e.target.classList.contains('rereplyBtn')){
			console.log('대댓글버튼 클릭됨'+data_rnum);
			rereply(e.target, data_rnum);
		}
	},false);
}
//댓글 삭제
function doDelete(i_node, i_rnum){
	let url = l_url+"/"+i_rnum;
	let xhttp = new XMLHttpRequest();
	xhttp.addEventListener("readystatechange",function(){
		if(this.readyState == 4 && this.status == 200){
				console.log(this.responseText);
			if(this.responseText == 'success'){
				replyList(l_page);
			}else{
				console.log('삭제오류!!');
			}
		}
	});			

     xhttp.open("DELETE",url,true); 
     xhttp.send();				
}
//댓글 수정
function doModify(i_node, i_rnum){
  //작업중인 다른 수정 버튼 상태변경
  let modifyBtns = document.getElementsByClassName("replyModifyBtn");
  console.log(modifyBtns);
  Array.from(modifyBtns).forEach(ele=>{
    ele.innerHTML = "수정"
    //내용 노드 탐색  	 
	let contentNode = parents(ele)
					.find( e => { if(e.classList.contains('header')){
									  return e;
								}}).nextElementSibling.children[1];
	 //내용 저장
	 let rcontent = contentNode.children[0].value;
	 //노드 생성
   	 let str = "";
     str += '<textarea name="rcontent" readonly>'
     	 + rcontent
     	 +'</textarea>';
    
     contentNode.innerHTML = str;
  })
  //작업중인 대댓글 버튼 상태변경
  let rereplyBtn = document.getElementsByClassName("rereplyBtn");
  console.log(rereplyBtn);
  Array.from(rereplyBtn).forEach(ele=>{
    ele.innerHTML = "댓글달기"
    //대댓글 창 부모 노드 탐색
	let rereply = parents(ele)
					.find( e => { if(e.classList.contains('header')){
									  return e;
								}}).nextElementSibling;
		
	console.log(rereply)
	if(rereply.children[2]!=null){
	  rereply.children[2].innerHTML = ""
	}
  })
  
  //내용 노드 탐색
  let contentNode = parents(i_node)
	.find( e => { if(e.classList.contains('header')){
					  return e;
				}}).nextElementSibling.children[1];

  let rcontent = contentNode.children[0].value;
  
  //내용 노드 쓰기 가능 & 등록 버튼 노드 추가
  let str = "";
  str += '<textarea name="rcontent"'
    	 +' style="box-sizing: border-box;border:1px solid black;background-color:#ffcecc">'
    	 + rcontent
    	 +'</textarea>';
  str += '<button>등록</button>';
  
  contentNode.innerHTML = str;
  console.log("contentNode.children[1].focus();" , contentNode.children[1])
  contentNode.children[0].focus();
  //수정을 취소로 변경
  i_node.innerHTML = "취소";

  
  
  //다시 클릭시 원상태로 되돌리기
  i_node.addEventListener("click",function(e){
  	e.stopPropagation();
  	this.innerHTML = "수정"
    this.removeEventListener("click",arguments.callee);
    let str = "";
    str += '<textarea name="rcontent" readonly>'
      	 + rcontent
      	 +'</textarea>';
    
    contentNode.innerHTML = str;
   },false)
  	//등록 버튼 이벤트 추가
  	//1) 버튼 탐색
  	let replyModifyBtn = parents(i_node)
	.find( e => { if(e.classList.contains('header')){
					  return e;
				}}).nextElementSibling.children[1].children[1];
	
	console.log("replyModifyBtn 의 값 :" , replyModifyBtn)
	//2) 수정 이벤트 등록
  	replyModifyBtn.addEventListener("click",  function(){	
  		//3)수정 내용 탐색
  		let rcontent = parents(i_node)
  		.find( e => { if(e.classList.contains('header')){
  						  return e;
  					}}).nextElementSibling.children[1].children[0].value;
  	    	
		let xhttp = new XMLHttpRequest();
		url = l_url
		xhttp.addEventListener("readystatechange",function(){
			if(this.readyState == 4 && this.status == 200){
				console.log(this.responseText);
				//let jsObj = JSON.parse(this.responseText)
				// 값이 하나 이면 JSON.parse를 거치지 않는가??
				
				if(this.responseText == 'success'){
					console.log("댓글 수정 성공!!")
              		replyList(l_page, i_rnum)
				}else{
					console.log('댓글 수정 오류!!');
				}
			}
		 });

		 //전송데이터 json포맷으로 만들기
	     let sendData = {};
	     sendData.rnum  = i_rnum;
	     sendData.rcontent = rcontent;
	     
	     //자바스크립트 obj => json포맷 문자열 변환
	     let result = JSON.stringify(sendData);
	     //console.log(result);
		     				
	     //post방식
	     xhttp.open("PUT",l_url,true);
	     xhttp.setRequestHeader("Content-Type","application/json;charset=utf-8"); 
	     xhttp.send(result);				
 		
		},false);

}


//호감,비호감
function doGoodOrBad(i_node, i_rnum, i_vote){
	let url = l_url+"/vote";
	let xhttp = new XMLHttpRequest();
	xhttp.addEventListener("readystatechange",function(){
		if(this.readyState == 4 && this.status == 200){
				console.log(this.responseText);
			if(this.responseText == 'success'){
				replyList(l_page);
			}else{
				console.log('호감,비호감 오류!!');
			}
		}
	});			
	 let sendData = {};
	 sendData.rnum = i_rnum; //댓글번호
	 sendData.bnum = l_bnum; //게시글 원글
	 sendData.rid  = l_id;	 //작성자
	 sendData.vote = i_vote; //호감,비호감	

	 let result = JSON.stringify(sendData);
	 		
    xhttp.open("PUT",url,true);
    xhttp.setRequestHeader("Content-Type","application/json;charset=utf-8"); 
    xhttp.send(result);				
}
//대댓글
function rereply(i_node, i_prnum){
  //작업중인 다른 대댓글 상태변경
  let rereplyBtn = document.getElementsByClassName("rereplyBtn");
  Array.from(rereplyBtn).forEach(ele=>{
    ele.innerHTML = "댓글달기"
    //대댓글 창 부모 노드 탐색
	let rereply = parents(ele)
					.find( e => { if(e.classList.contains('header')){
									  return e;
								}}).nextElementSibling;
		
	if(rereply.children[2]!=null){
	  rereply.children[2].innerHTML = ""
	}
	//노드 삭제
 	/* rereply.remove() ; */
  })
  
  //작업중인 다른 수정 버튼 상태변경
  let modifyBtns = document.getElementsByClassName("replyModifyBtn");
  Array.from(modifyBtns).forEach(ele=>{
    ele.innerHTML = "수정"
    //내용 노드 탐색  	 
	let contentNode = parents(ele)
					.find( e => { if(e.classList.contains('header')){
									  return e;
								}}).nextElementSibling.children[1];
	 //내용 저장
	 let rercontent = contentNode.children[0].value;
	 //노드 생성
   	 let str = "";
     str += '<textarea name="rcontent" readonly>'
     	 + rercontent
     	 +'</textarea>';
    
     contentNode.innerHTML = str;
  })
  
  
  //대댓글 창이 나타날 부모 노드 탐색
  let bodyNode = parents(i_node)
			.find( e => { if(e.classList.contains('header')){
							  return e;
						}}).nextElementSibling;

  //부모 답글 글쓴이 값 추출
  let parentWriter = parents(i_node)
	.find( e => { if(e.classList.contains('header')){
					  return e;
				}}).children[0].children[0].children[0].innerHTML;
  console.log("parentWriter 의 값:", parentWriter)
  
  //대댓글 창 생성
  let str = "";
  
  str += '   <div>';
  str += '   	<textarea name="rcontent" rows="3" style="border:1px solid black;background-color:#ffcecc">'+
  				parentWriter + '님에게 답글달기'
  				+'</textarea>';    
  str += '   	<button>등록</button>';
  str += '   </div>';
  bodyNode.innerHTML += str;
  //댓글 등록을 댓글 취소로 변경
  i_node.innerHTML = "댓글취소";
  //취소 버튼 이벤트 설정
  i_node.addEventListener("click", function(e){
    e.stopPropagation();
    //대댓글 입력창 삭제
    this.innerHTML = "댓글달기";
    this.removeEventListener("click",arguments.callee);
    
    
    bodyNode.children[2].remove();
  });
  //대댓글 등록 버튼 이벤트 등록
  //1) 대댓글 등록 버튼 탐색
  let rereplysubmitBtn = parents(i_node)
					.find( e => { if(e.classList.contains('header')){
					 				 return e;
								}}).nextElementSibling.children[2].children[1];
  rereplysubmitBtn.addEventListener("click", function(){
     console.log("대댓글 등록 버튼 클릭")
     url = l_url + "/reply"
	 let xhttp = new XMLHttpRequest();
	 xhttp.addEventListener("readystatechange",function(){
			if(this.readyState == 4 && this.status == 200){
				console.log(this.responseText);
				let jsObj = JSON.parse(this.responseText);
				
				if(jsObj.success== 'success'){
					console.log("대댓글 작성 성공!!")
					console.log("등록 댓글 번호 :" , jsObj.rnum)
	            		replyList(l_page, jsObj.rnum, parentWriter)
				}else{
					console.log('대댓글작성오류!!');
				}
			}
		});
  	   //부모 댓글 정보 추출
	   let prinfo = parents(i_node)
			.find( e => { if(e.classList.contains('header')){
			 				 return e;
						}}).parentNode;
		console.log("부모 정보: ",prinfo.innerHTML )
  	   //댓글 내용 추출
  	   let rercontentTag = parents(i_node)
 							.find( e => { if(e.classList.contains('header')){
								  			return e;
										}}).nextElementSibling.children[2].children[0];
  	   let rercontent = rercontentTag.value;
		console.log(rercontent);
	
	   //전송데이터 json포맷으로 만들기
	   let sendData = {};
	   sendData.bnum    = l_bnum;
	   sendData.prnum = i_prnum;
	   sendData.rgroup  = prinfo.children[0].value;
	   sendData.rstep 	= prinfo.children[1].value;
	   sendData.rindent = prinfo.children[2].value;
	   sendData.rid = l_id;
	   sendData.rnickname = l_nickname;
	   sendData.rcontent = rercontent;
	   
	   
	   //자바스크립트 obj => json포맷 문자열 변환
	   let result = JSON.stringify(sendData);
	   console.log("result : " + result);
	     				
	   //post방식
	   xhttp.open("POST",url,true);
	   xhttp.setRequestHeader("Content-Type","application/json;charset=utf-8"); 
	   xhttp.send(result);				
			
    },false)//rereplysubmitBtn
 }
	
/* 특정 노드를 매개값으로 받아서 조상노드를 찾아서 배열에 저장하기 */
function parents(node) {     
	let current = node,         
	list    = [];     
	while(	current.parentNode != null && 
					current.parentNode != document.documentElement) {
		//존재하는 부모노드를 배열에 추가       
		list.push(current.parentNode);
		//현재노드 갱신     
		current = current.parentNode;    
	}     
	return list;
}
			
		//댓글목록 가져오기
function replyList(reqPage){
		let url = l_url+"/"+l_page+"/"+l_bnum;
	    let i_rnum = arguments[1];
	    let i_parentWriter = arguments[2]
			
		
		//Ajax Call
		//1)
		let xhttp = new XMLHttpRequest();
		//2)
		xhttp.addEventListener("readystatechange",function(){
			if(this.readyState == 4 && this.status == 200){
				console.log(this.responseText);
				let jsObj = JSON.parse(this.responseText);
				let str = "";
				jsObj.list.forEach( e => {
	
		            if(i_rnum!=null && i_rnum == e.rnum){
		                str += '<div class="bright" data-rnum="' + e.rnum + '"> ';
		            }else{
		                str += '<div data-rnum="' + e.rnum + '"> ';
		            }
					if(e.rindent == 0){
						str += '  <div> ';
					}else{
						str += '  <div style="padding-left:40px">';
					}
					str += '    <div><img src="" alt="사진" /></div>';
					str += '    <div>';
					str += '		<input type="hidden" class="bgroup" value="' + e.rgroup + '" />';
					str += '		<input type="hidden" class="bstep" value="' + e.rstep + '" />';
					str += '		<input type="hidden" class="bindent" value="' + e.rindent + '" />';									
					str += '      <div class="rheader">';
					str += '        <div><b><small>'+e.rnickname+'('+e.rid+')'+'</small></b></div>';
					str += '        <div><small><i>'+e.rcdate+'</i></small></div>';
					str += '        <div><span><i class="fas fa-reply rereplyBtn" title="댓글달기">댓글달기</i></span></div>';
					str += '        <div>';
					str += '          <div>';
					if(e.rid == l_id){
						str += '            <div><span><i class="fas fa-edit replyModifyBtn" title="수정하기">수정</i></span></div>	';
						str += '            <div><span><i class="far fa-trash-alt replyDeleteBtn" title="삭제하기">삭제</i></span></div>';
					}else{
						str += '            <div style="visibility:hidden"><span><i class="fas fa-edit replyModifyBtn" title="수정하기">수정</i></span></div>	';
						str += '            <div style="visibility:hidden"><span><i class="far fa-trash-alt replyDeleteBtn" title="삭제하기">삭제</i></span></div>';
					}
					str += '          </div>';
					str += '        </div>';
					str += '      </div>';
					str += '      <div class="rbody">';
/* 					if(e.rindent == 0){
						str += '        <div class="col fw-5"></div>';
					}else{
 */						str += '        <div>'+ e.prnickname +'</div>';
					/* } */
					str += '        <div><textarea name="rcontent" id="rercontent" readonly>'+e.rcontent+'</textarea></div>';
					str += '      </div>';
					str += '      <div class="rbottom">';
					str += '        <div class="col fw-5"><span><i class="fas fa-thumbs-up goodBtn  title="호감"></i></span>('+e.good+')</div>';
					str += '        <div class="col fw-5"><span><i class="fas fa-thumbs-down badBtn title="비호감"></i></span>('+e.bad+')</div>';
					str += '      </div>';
					str += '    </div>';
					str += '  </div>';
					str += '</div>';					
	
					document.getElementById('replyList').innerHTML = str;
	
				});//jsObj.list.forEach 
				
				//페이지징
				//이전페이지 여부
				str = "";
				if(jsObj.pc.prev){
					str += '<a href="1">◀</a>';
				  str += '<a href="'+(jsObj.pc.startPage-1)+'">◁</a>';
				}
				//페이지 1~10
				for(let i=jsObj.pc.startPage, end=jsObj.pc.endPage; i<=end; i++){
					//현재 페이지와 요청페이지가 다르면
					if(jsObj.pc.rc.reqPage != i ){
						str += '<a href="'+i+'">'+i+'</a>';
					}else{
						str += '<a href="'+i+'" class="active">'+i+'</a>';
					}
				}
	
				//다음페이지 여부
				if(jsObj.pc.next){
			    str += '<a href="'+(jsObj.pc.endPage+1)+'">▷</a>';
			    str += '<a href="'+(jsObj.pc.finalEndPage)+'">▶</a>';
				}		
				document.getElementById('paging').innerHTML = str;		
			}
	  },false);
	//3)
	xhttp.open("GET",url,true);
	xhttp.send();
}
	</script>
</head>
<body>
 <div class="replyContainer">
   <div id="reply">
     <div class="row">
       <textarea name="rcontent" id="rcontent" rows="3"></textarea>
       <button id="replyBtn2">등록</button>
     </div>
   </div>
   <!-- 댓글 목록-->
   <div id="replyList">
     <!-- <div class="row pw-10"> -->
       <!-- <div class="row pw-10">
         <div class="col fw-7"><img src="" alt="사진" /></div>
         <div class="col pw-10">
           <div class="row header pw-10">
             <div class="col fw-10">댓글작성자</div>
             <div class="col fw-10"><small><i>댓글작성일시</i></small></div>
             <div class="col fw-5"><span><a href="#" class="rereplyBtn" data-rnum="">댓글버튼</a></span></div>
             <div class="col pw-10">
               <div class="row">
                 <div class="col fw-5"><span><a href="#" class="replyModifyBtn" data-rnum="">수정버튼</a></span></div>
                 <div class="col fw-5"><span><a href="#" class="replyDeleteBtn" data-rnum="">삭제버튼</a></span></div>
               </div>
             </div>
           </div>
           <div class="row body">
             <div class="col fw-5">부모댓글작성자</div>
             <div class="col">댓글내용</div>
           </div>
           <div class="row bottom">
             <div class="col fw-10"><span><a href="#" class="goodBtn" data-rnum=""><i
                     class="far fa-thumbs-up"></i>선호</a></span>(3)</div>
             <div class="col fw-10"><span><a href="#" class="badBtn" data-rnum=""><i
                     class="far fa-thumbs-down"></i>비선호</a></span>(1)</div>

           </div>
         </div>
       </div> -->
  <!-- 페이징 -->
    </div>
	  <div id="paging">
	    <a href="#">첫페이지</a>
	    <a href="#">이전페이지</a>
	    <a href="#">1</a>
	    <a href="#">2</a>
	    <a href="#">3</a>
	    <a href="#">4</a>
	    <a href="#">5</a>
	    <a href="#">6</a>
	    <a href="#">7</a>
	    <a href="#">8</a>
	    <a href="#">9</a>
	    <a href="#">10</a>
	    <a href="#">다음페이지</a>
	    <a href="#">끝페이지</a>
	  </div>
  </div>
    <!-- Optional JavaScript -->
  <!-- jQuery first, then Popper.js, then Bootstrap JS -->
  <script defer="defer" src="${pageContext.request.contextPath }/webjars/jquery/3.4.1/jquery.js"></script>
  <script defer="defer" src="${pageContext.request.contextPath }/webjars/popper.js/2.0.2/umd/popper.js"></script>
  <script defer="defer" src="${pageContext.request.contextPath }/webjars/bootstrap/4.4.1-1/js/bootstrap.js"></script>
  
  </body>
  </html>