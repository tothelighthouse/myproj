window.addEventListener("load",init,false)
function init(){
	findPWBtn.addEventListener("click",findPWBtnClick,false);
}

function findPWBtnClick(){
	console.log("클릭됨");
	var status = false;
	//1) 유효성체크(아이디, 전화번호, 생일)
	status = valChk();
	//2)사용자 인증 AJAX Call 실행
	if(!status) return;
	authChk();
}
//유효성 체크
function valChk(){

}

//사용자 인증 AJAX Call
function authChk(){
//	1) AJAX Call 사용 준비
	var xhttp = new XMLHttpRequest();
//	2) 서버 요청 처리
	xhttp.addEventListener("readystatechange",ajaxCall,false);
//	3) 리스너 구현
	function ajaxCall(){
//	3-1) 요청 결과 확인
		if(this.readystate == 4 && this.status == 200){
			console.log(this.responseText)
			//json 문자열 => 자바스크립트 객체
			var jsonObj = JSON.parse(this.responseText);
//	3-2) UIUpdate()호출
			if(jsonObj.success){
				console.log("회원인증 성공")
				updateUI(true);
			}else{
				console.log("회원인증 실패")
				updateUI(false);
			}
		}
	}
//	4) 서비스 요청
	var sendData = {}
	sendData.id = document.getElementById("id").value;
	sendData.tel = document.getElementById("tel").value;
	sendData.birth = document.getElementById("birth").value;
	
	var result = JSON.stringify(sendData);
	console.log(result);
	
	xhttp.open("POST","http://loacalhost:9080/myweb/findPW.do",false);
	xhttl.setRequestHeader("Content-Type","applicaton/x-www-form-urlencoded");
	xhttp.send("result=" + result);
	
}
//UIUpadte(비밀번호 변경 가능하도록!!)
function updateUI(flag){
	console.log("ui 호출됨")
//	1) 비밀번호 입력창 활성화
	var hideTags = document.querySelectorAll(".hide");
	Array.from(hideTags).forEach(ele =>{
		if(ele.classList.contains("hide")){
			ele.classList.remove("hide")
		}
	})
	
//	2) 아이디, 전화번호, 생일 읽기전용
	var readOnly = ["id","tel","birth"]
	readOnly.forEach(ele =>{
		document.getElementById(ele).setAttribute("readonly","readonly");
	})
	
//	3) 이벤트 리스너 제거
//	4) 이벤트 리스너 설정
//	5) 비밀번호 유효성 체크
//	6) 비밀번호 변경 AJAX call
}
//정규식 체크
function isEmail(asValue){
	var regExp = "";
	return regExp.test(asValue);
}

function isTel(asValue){
	var regExp = "";
	return regExp.test(asValue);
}

function isPassword(asValue){
	var regExp = "";
	return regExp.test(asValue);
}
















