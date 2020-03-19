<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css" />
  <style>
    /* { outline: 1px solid red;	} */
    /* 공통 */
    .lm-1{ margin-left: 10px; } .lm-2{ margin-left: 20px; } .lm-3{ margin-left: 30px; } .lm-4{ margin-left: 40px; } .lm-5{ margin-left: 50px; }
    .lm-6{ margin-left: 60px; } .lm-7{ margin-left: 70px; } .lm-8{ margin-left: 80px; } .lm-9{ margin-left: 90px; } .lm-10{ margin-left: 100px; }
  
    .fw-1{min-width:10px;} .fw-2{min-width:20px;} .fw-3{min-width:30px;} .fw-4{min-width:40px;} .fw-5{min-width:50px;}
    .fw-6{min-width:60px;} .fw-7{min-width:70px;} .fw-8{min-width:80px;} .fw-9{min-width:90px;} .fw-10{min-width:100px;}
    
    .pw-1{width:10%;} .pw-2{width:20%;} .pw-3{width:30%;} .pw-4{width:40%;} .pw-5{width:50%;}
    .pw-6{width:60%;} .pw-7{width:70%;} .pw-8{width:80%;} .pw-9{width:90%;} .pw-10{width:100%;}

    #reply .row, 
    #replyList .row { display:flex; }

    /* 댓글작성 */
    #reply{
      margin-top:20px; width:100%;
    }
    #reply .row{ display:flex; }    
    #reply #rcontent{ width:100%; }
    #reply #replyBtn{ width:80px; }
      
    /* 댓글 목록 */  
    #replyList{
      margin-top:20px; width:100%;
    }
    #replyList .row { display:flex; }    
    #replyList .row.header .col:nth-child(4){
      display:flex;
      justify-content: flex-end;
    }
    /* 페이징 */
    #paging {
      margin-top:20px;
      display:flex;
      justify-content: center;
    }
    
    #paging a {
      padding:2px;
      margin:2px;
    }
    
    #paging .active{
      background-color: yellow;
    }
    .bright{
     animation: background 5s;
     transition: all 3s;
    }

    @keyframes background{
     from{
       background-color: gray;
     }
     to{
       background-color: white;
     }
    }
    
    
    
  </style>  
  <script>
    window.addEventListener("load",init2,false);
    let l_bnum = 3063; //게시 원글 번호
    let l_page = 1;//요청 페이지
    let l_id = "${sessionScope.member.id}"; //로그인 아이디
    let l_nickname = "${sessionScope.member.nickname}"; //로그인 별칭
    let l_url = "${pageContext.request.contextPath}/rboard"; //공통 url

    const GOOD = '1',BAD ='2';
        
    function init2() {
      //댓글 목록 가져요기
      replyList(l_page);


      //페이지 번호 클릭시 이벤트 처리
      paging.addEventListener("click", function(e){
        e.preventDefault();
        if(e.target.tagName == 'a'){
          l_page = e.target.getAttribute("href");
          replyList(l_page);
        }
      }, false)
      
      //댓글 작성
      replyBtn2.addEventListener("click",function(){
  	  /* replyBtn.addEventListener("click",function(){ */
          
        console.log("댓글 작성 버튼 클릭됨");
        let rcontentTag = document.getElementById("rcontent") 
        let rcontent = rcontentTag.value;
        
        let xhttp = new XMLHttpRequest();
        xhttp.addEventListener("readystatechange", function(){
          if(this.readyState == 4 && this.status == 200){
            console.log(this.responseText);
            let jsonObj = JSON.parse(this.responseText);
            if(jsonObj.success == "success"){
              console.log(jsonObj.rnum)
              replyList(l_page, jsonObj.rnum)
              rcontentTag.value = "";
              rcontentTag.focus();
            }else{
              console.log("댓글 작성 오류!!")
            }
          }
        },false);
        //전송 데이터 json format으로 만들기
        let sendData = {};
        sendData.bnum = l_bnum;
        sendData.rid = l_id;
        sendData.rnickname = l_nickname;
        sendData.rcontent = rcontent;

        // 자바스크립트 obj => json포맷 문자열 변환
        let result = JSON.stringify(sendData);
        
        //post 방식
        xhttp.open("POST", l_url, true);
        xhttp.setRequestHeader("Content-Type","application/json");
        xhttp.send(result);
       },false) //replyBtn.addEventListener

       //댓글 삭제
       let delBtns = document.getElementsByClassName("replyDeleteBtn");
       Array.from(delBtns).forEach(item => {
          item.addEventListener("click", function(e){
            console.log("del:" + e.target.getAttribute("data-num"))
           },false)
       })
         

       // 특정 노드를 매개값으로 받아서 조상노드를 찾아서 배열에 저장하기
       function parents(node){
         let current = node,
         list = [];     
         while(current.parentNode != null && 
               current.parentNode != document.documentElement) {
                list.push(current.parentNode);
                current = current.parentNode;
         }
         return list
       }
       //댓글목록 이벤트 등록
       document.getElementById("replyList").addEventListener("click",function(e){
        //댓글목록에서 "I"태그의 자식 태그에서만 반응하기
        if(e.target.tagName != 'I') return false;
        //이벤트가 일어난 지점에서 data-rnum 속성을 포함한 요소를 찾아서 data-rnum값을 추출한다.
        let data_rnum = parents(e.target)
                        .find(tag => { if(tag.hasAttribute("data-rnum")){
                                         return tag;
                                      }})
                        .getAttribute("data-rnum")
        if(e.target.classList.contains('replyDeleteBtn')){
            console.log("삭제 버튼 클릭됨" + data_rnum);
            doDelete(e.target, data_rnum);
          }else if(e.target.classList.contains('replyModifyBtn')){
            console.log("수정 버튼 클릭됨" + data_rnum);
          }else if(e.target.classList.contains('goodBtn')){
            console.log("호감 버튼 클릭됨" + data_rnum);
            doGoodorBad(e.target, data_rnum, GOOD);
          }else if(e.target.classList.contains('badBtn')){
            console.log("비호감 버튼 클릭됨" + data_rnum);
            doGoodorBad(e.target, data_rnum, BAD);
          }else if(e.target.classList.contains('rereplyDeleteBtn')){        
             console.log("댓글 버튼 클릭됨" + data_rnum);
             doRereply(e.target, data_rnum);
          }
        },false)
    }//function init2()
    //댓글 삭제
    function doDelete(i_node, i_rnum){
      let url = l_url +"/"+i_rnum;
      let xhttp = new XMLHttpRequest();
      xhttp.addEventListener("readystatechange", function(){
        if(this.readyState == 4 && this.status == 200){
          console.log(this.responseText);
          if(this.responseText == "success"){
            replyList(l_page)
          }else{
            console.log("삭제 작성 오류!!")
          }
        }
      },false);
      xhttp.open("DELETE", url, true);
      xhttp.send();
    } 
    //호감, 비호감
    function doGoodorBad(i_node, i_rnum, i_vote){
      let url = l_url +"/vote";
      let xhttp = new XMLHttpRequest();
      xhttp.addEventListener("readystatechange", function(){
        if(this.readyState == 4 && this.status == 200){
          console.log(this.responseText);
          if(this.responseText == "success"){
            replyList(l_page)
          }else{
            console.log("호감 작성 오류!!")
          }
        }
      },false);
      
      let sendData = {};
      sendData.rnum = i_rnum // 댓글번호
      sendData.bnum = l_bnum // 게시글 원글
      sendData.rid = l_id //작성자
      sendData.vote = i_vote // 호감

      let result = JSON.stringify(sendData);

      xhttp.open("PUT", url, true);
      xhttp.setRequestHeader("Content-Type","application/json");
      xhttp.send(result);
    } 
    function doRereply(i_node, i_rnum){
      // 대댓글창 자식 노드 추가
      
      // 대댓글 작성
    }    

    // 댓글 목록 가져오기
    function replyList(reqPage){
      l_page = reqPage;
      let url = l_url + "/" + l_page + "/" + l_bnum;
      let i_rnum = arguments[1];
      //Ajax Call
      //1)
      let xhttp = new XMLHttpRequest();
      //2)
      xhttp.addEventListener("readystatechange", function(){
        if(this.readyState == 4 && this.status == 200){
          console.log(this.responseText);
          let jsonObj = JSON.parse(this.responseText);
          
      
          let str = null;
          console.log("arguments[1] : " + i_rnum)
          
          jsonObj.list.forEach(e => {
            if(i_rnum!=null && i_rnum == e.rnum){
              console.log("참 통과")
              str += '<div class="row pw-10 bright" data-rnum="' + e.rnum + '"> ';
            }else{
              console.log("거짓 통과")
              str += '<div class="row pw-10" data-rnum="' + e.rnum + '"> ';
            }
            if(e.rindent == 0){
              str += ' <div class="row pw-10"> ';
            }else{
              str += ' <div class="row pw-10 lm-7"> ';
            }
            str += '   <div class="col fw-7"><img src="" alt="사진" /></div> ';
            str += '   <div class="col pw-10"> ';
            str += '     <div class="row pw-10"> ';
            str += '       <div class="col fw-10">' + e.rnickname +'(' + e.rid + ')' + '</div>';
            str += '       <div class="col fw-10"><small><i>' + e.rcdate + '</i></small></div> ';
            str += '       <div class="col fw-5"><span>댓글버튼</span></div> ';
            str += '       <div class="col pw-10"> ';
            str += '        <div class="row"> ';
            str += '           <div class="col fw-5"><span><i class="fas fa-edit replyModifyBtn" title="수정버튼">수정버튼</i></span></div>   ';
            str += '           <div class="col fw-5"><span><i class="fas fa-trash replyDeleteBtn">삭제버튼</i></span></div> ';
            str += '        </div>           ';
            str += '       </div> ';
            str += '     </div> ';
            str += '     <div class="row">     ';
            str += '       <div class="col fw-5">부모댓글작성자</div>             ';
            str += '       <div class="col">' + e.rcontent + '</div> ';
            str += '     </div> ';
            str += '     <div class="row"> ';
            str += ' <div class="col fw-10"><span><i class="far fa-thumbs-up goodBtn"></i>선호</span>('+ e.good +')</div>';
            str += ' <div class="col fw-10"><span><i class="far fa-thumbs-down badBtn"></i>비선호</span>('+ e.bad +')</div>';
            str += '     </div> ';
            str += '   </div> ';
            str += ' </div> ';
            str += '</div> ';

            document.getElementById("replyList").innerHTML = str;
          }); //jsonObj.list.forEach
          
          //페이징
          //이전페이지 여부
          if(jsonObj.pc.prev){
            str += '<a href="1">◀</a>'
            str += '<a href="' + (jsonObj.pc.startPage - 1) + '">◁</a>'
          }else{

          }
          //페이지 1~10
          for(let i = jsonObj.pc.startPage, end=jsonObj.pc.endPage; i<=end ; i++){
            //현재 페이지와 요청 페이지가 다르면
            if(jsonObj.pc.rc.reqPage !=i){
              str += '<a href="' + i + '">' + i + '</a>';
            }else{
              str += '<a href="' + i +'" class="active">' +  i + '</a>';
            }
          }
          //다음페이지 여부
          if(jsonObj.pc.next){
            str += '<a href="' + (jsonObj.pc.endPage + 1) + '">▷</a>'
            str += '<a href="' + (jsonObj.pc.finalEndPage) + '">▶</a>'
          }
          
          document.getElementById('paging').innerHTML = str;		
        }
      }, false)
      //3)
      xhttp.open("GET", url, true);
      console.log("오픈완료")
      xhttp.send();
    }
      
      
  
    

  </script>
</head>
<body>
  <!-- 댓글 달기 -->
  <div id="reply">
    <div class="row">
      <textarea name="rcontent" id="rcontent" rows="3"></textarea>
      <button id="replyBtn2">등록</button>
    </div>
  </div>
  <!-- 댓글 목록-->
  <div id="replyList">
   <div class="row pw-10">
      <div class="row pw-10">
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
            <div class="col fw-10"><span><a href="#" class="goodBtn" data-rnum=""><i class="far fa-thumbs-up"></i>선호</a></span>(3)</div>
            <div class="col fw-10"><span><a href="#" class="badBtn" data-rnum=""><i class="far fa-thumbs-down"></i>비선호</a></span>(1)</div>
            
          </div>
        </div>
      </div>
    </div>
    <div class="row pw-10" data-rnum="">
      <div class="row pw-10 lm-7">
        <div class="col fw-7"><img src="" alt="사진" /></div>
        <div class="col pw-10">
          <div class="row pw-10">
            <div class="col fw-10">댓글작성자</div>
            <div class="col fw-10"><small><i>댓글작성일시</i></small></div>
            <div class="col fw-5"><span><a href="#" class="rereplyBtn" data-rnum=""><i class="fas fa-comment-dots"></i>댓글버튼</a></span></div>
            <div class="col pw-10">
  						<div class="row">
                <div class="col fw-5"><span><a href="#" class="replyModifyBtn" data-rnum="">수정버튼</a></span></div>	
                <div class="col fw-5"><span><a href="#" class="replyDeleteBtn" data-rnum="">삭제버튼</a></span></div>
  						</div>					
            </div>
          </div>
          <div class="row">		
            <div class="col fw-5">부모댓글작성자</div>            
            <div class="col">댓글내용</div>
          </div>
          <div class="row">
            <div class="col fw-10"><span><a href="#" class="goodBtn" data-rnum=""><i class="far fa-thumbs-up"></i>선호</a></span>(3)</div>
            <div class="col fw-10"><span><a href="#" class="badBtn" data-rnum=""><i class="far fa-thumbs-down"></i>비선호</a></span>(1)</div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--페이징-->
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
</body>
</html>