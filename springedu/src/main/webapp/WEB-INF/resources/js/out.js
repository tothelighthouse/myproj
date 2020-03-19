window.addEventListener("load",init,false);
function init(){
  var idTag = document.getElementById("id");
  var pwTag = document.getElementById("pw");

  var outBtn = window.document.getElementById("outBtn")
  outBtn.addEventListener("click",function(e){
	  e.preventDefault();
	  var result = checkLogin();
	  if(result){
		  if(confirm("탈퇴하시겠습니까")){
			  document.getElementById("frm").submit();
		  }
	  }
  },false)
}
function checkLogin(){
  var idTag = document.getElementById("id");
  var idValue = idTag.value;
  var pwTag = document.getElementById("pw");
  var pwValue = pwTag.value;
  var flag = true;
  // 로그인 유효성 체크
  //1) 아이디, 비밀번호 빈문자열 체크
  if(idValue.trim().length == 0){
    idMsg.innerHTML="아이디를 입력하세요!";
    idMsg.classList.add("errmsg");     
    idTag.focus();
    flag = false;
    return flag;
  }
  if(pwValue.trim().length == 0){
    idMsg.innerHTML="";
    pwMsg.innerHTML="비밀번호를 입력하세요!";
    pwMsg.classList.add("errmsg");  
    pwTag.focus();
    flag = false
    return flag;
  }
  return flag;
//  console.log(idValue.trim(),pwValue.trim());
//  //2) 회원 존재유무체크
//  if(idValue.trim() == ID && pwValue.trim() == PW){
//    //메인 페이지로 이동
//    window.location.href = "index_logined.jsp";
//  }else {
//    pwMsg.innerHTML="가입하지 않은 아이디이거나, 잘못된 비밀번호입니다.";
//    pwMsg.style.color = "red";
//    pwMsg.style.fontSize = '0.7rem';
//    psMsg.style.fontWeight = 'bold';
//    pwTag.focus();
//    return;
//  }
}