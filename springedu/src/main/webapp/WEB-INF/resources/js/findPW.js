window.addEventListener("load",init,false);
function init(){
	findPWBtn.addEventListener("click",findPWBtnClick,false);
}

function findPWBtnClick(e){
  console.log('클릭됨');  
  var status = false;
  //1) 유효성 체크(아이디,전화번호,생일)
  status = valChk();
  if(!status) return;
  
  //2) 사용자인증 AJAX call
  authCkh();
}

//1) 유효성 체크(아이디,전화번호,생일)
function valChk(){
	 // 사용자 입력값 읽어오기
  var idEle 		= document.getElementById('id');
  var telEle 		= document.getElementById('tel');
  var birthEle 		= document.getElementById('birth');

  var flag = true; /* 유효성 체크 유무 */
  //1) 이메일 주소 체크
    if(!isEmail(idEle.value)) {
    	idMsg.innerHTML = "이메일을 입력해주세요.";
      flag = flag && false;
    }else{
    	idMsg.innerHTML = "";
    }

  //2) 전화번호
    if(!isTel(telEle.value)) {
    	telMsg.innerHTML = "전화번호를 입력하세요. <br> ex)010-1234-5678";
      flag = flag && false;
    }else{
    	telMsg.innerHTML = "";
    }    

  //3) 생년월일 체크
    if(birthEle.value == "" ) {
    	birthMsg.innerHTML = "생일을 입력해주세요!";
      flag = flag && false;
    }else{
    	birthMsg.innerHTML = "";
    }
    return flag;  
}

//2) 사용자인증 AJAX call
function authCkh(){

  //AJAX 사용
  //1) XMLHttpRequest객체 생성	
  var xhttp = new XMLHttpRequest();
  
  //2) 서버응답처리
  xhttp.addEventListener("readystatechange",ajaxCall,false);
  function ajaxCall(){
	  if (this.readyState == 4 && this.status == 200) {
		  console.log(this.responseText);
		  //json포맷 문자열  => 자바스크립트 obj
		  var jsonObj = JSON.parse(this.responseText)
		  if(jsonObj.success){
		  	updateUI(true);
		  	console.log('회원인증 성공!!');
		  }else{
		  	console.log('회원인증 실패!!');
		  	updateUI(false);
		  }
	  }
  }
 	  
  //3) 서비스 요청
  var sendData = {};
  sendData.id   = document.getElementById("id").value;
  sendData.tel   = document.getElementById("tel").value;
  sendData.birth = document.getElementById("birth").value;
  //자바스크립트 obj => json포맷 문자열 변환
  var result = JSON.stringify(sendData);
  console.log(result);
  
  //post방식
  xhttp.open("POST","http://localhost:9080/portfolio/member/findPW",true);
//  xhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded"); 
  xhttp.setRequestHeader("Content-Type","application/json;charset=utf-8"); 
  xhttp.send(result);
//  xhttp.send("result="+result);
}

//3) UI업데이트(비밀번호변경되게!!)
function updateUI(flag){
	console.log('ui호출됨!');
	if(flag){
		//1) 비밀번호 변경필드 활성화
	  var hideTags = document.querySelectorAll(".hide");
	  for(let hideTag of hideTags){
	    if(hideTag.classList.contains("hide")){
	      hideTag.classList.remove("hide");
	      console.log(hideTag);
	    }
	  }
	  
	  //2) 아이디, 전화번호, 생년월일 읽기모드로
	  id.setAttribute("readOnly","readOnly");
	  tel.setAttribute("readOnly","readOnly");
	  birth.setAttribute("readOnly","readOnly");
	  
	  //3) 비밀번호 찾기 이벤트 제거
	  findPWBtn.removeEventListener("click",findPWBtnClick);
	  
	  //4) 비밀번호 변경 이벤트추가
	  findPWBtn.addEventListener("click", changePWBtnClick); 
	  findPWBtn.textContent = "비밀번호변경";	
	  
	}else{
		birthMsg.textContent="가입된 회원정보가 없습니다!";
	}
	
//비밀번호 클릭시
	function changePWBtnClick() {
	  console.log('클릭됨');  
	  var status = false;
	  //1) 유효성 체크(비밀번호)
	  status = pwChk();
	  if(!status) return;
	  
	  //2) 사용자인증 AJAX call
	  changePW();	
	}

	//4) 유효성체크(비밀번호)
	function pwChk() {
	  // 사용자 입력값 읽어오기
	  var pwEle 		= document.getElementById('pw');
	  var pwChkEle 		= document.getElementById('pwchk');
	  var flag = true; /* 유효성 체크 유무 */
	  
	  //1) 비밀번호 체크
	  if(!isPassword(pwEle.value)) {
	    pwMsg.innerHTML = "비밀번호를 입력하세요.";
	    flag = flag && false;    
	  }else{
		  pwMsg.innerHTML = "";
	  }
	  //2) 비밀번호 재확인
	  //2-1)비밀번호 패턴 체크
	  if(!isPassword(pwChkEle.value)) {
		  pwckhMsg.innerHTML = "비밀번호를 한번 더 입력하세요.";
	    flag = flag && false;
	  }else{
		  pwckhMsg.innerHTML = "";
	  }
	  //2-2)비밀번호 일치 체크
	  if(pwEle.value != pwChkEle.value ) {
		  pwckhMsg.innerHTML = "비밀번호가 일치하지 않습니다.";
	    flag = flag && false;
	  }else {
		  pwckhMsg.innerHTML = "";
	  }
	  if(pwEle.value == pwChkEle.value && !isPassword(pwChkEle.value)){
		  pwckhMsg.innerHTML = "비밀번호를 다시입력하세요(8자리 이상)"
		  flag = flagg && false;
	  }
	  return flag;  
	}

	//5) 비밀번호변경 AJAX call
	function changePW() {
	  //AJAX 사용
	  //1) XMLHttpRequest객체 생성	
	  var xhttp = new XMLHttpRequest();
	  
	  //2) 서버응답처리
	  xhttp.addEventListener("readystatechange",ajaxCall,false);
	  function ajaxCall(){
		  if (this.readyState == 4 && this.status == 200) {
			  console.log(this.responseText);
			  //json포맷 문자열  => 자바스크립트 obj
			  var jsonObj = JSON.parse(this.responseText)
			  if(jsonObj.success){
			  	console.log('비밀번호 변경 성공!!');
			  	alert('비밀번호가 성공적으로 변경되었습니다!!'+"\r\n로그인 페이지로 이동합니다.!!");
			  	document.location.href = getContextPath()+"/loginForm";
			  }else{
			  	console.log('비밀번호 변경 실패!!');
			  	pwckhMsg.innerHTML = "비밀번호변경 실패하였습니다.관리자에게 문의바랍니다.";
			  }
		  }
	  }
	 	  
	  //3) 서비스 요청
	  var sendData = {};
	  sendData.id   = document.getElementById("id").value;
	  sendData.pw   = document.getElementById("pw").value;

	  //자바스크립트 obj => json포맷 문자열 변환
	  var result = JSON.stringify(sendData);
	  console.log(result);
	  
	  //post방식
	  xhttp.open("POST","http://localhost:9080/portfolio/member/changePW",true);
	  xhttp.setRequestHeader("Content-Type","application/json;charset=utf-8"); 
	  xhttp.send(result);	
	}	
}

//이메일 체크 정규식
function isEmail(asValue) {
  var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
  return regExp.test(asValue); // 형식에 맞는 경우 true 리턴	
}

// 핸드폰 번호 체크 정규식
function isTel(asValue) {
  var regExp = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;
  return regExp.test(asValue); // 형식에 맞는 경우 true 리턴
}

//비밀번호 체크 정규식
function isPassword(asValue) {
  var regExp = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,10}$/; //  8 ~ 10자 영문, 숫자 조합
  return regExp.test(asValue); // 형식에 맞는 경우 true 리턴
}  




