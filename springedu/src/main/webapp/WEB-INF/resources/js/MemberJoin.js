window.addEventListener("load",init,false);
function init(){
  joinBtn.addEventListener("click",function(e){
    e.preventDefault();
//    document.forms['join-frm'].submit()
    if(checkValid()){
    	//유효성 통과하면 메인화면 이동
    	document.forms['join-frm'].submit();
    	
    }
  },false);

}

function checkValid(){
  // 사용자 입력값 읽어오기
  var idEle = document.getElementById('id');
  var pwEle = document.getElementById('pw');
  var pwChkEle = document.getElementById('pwChk');
  var telEle = document.getElementById('tel');
  var regionEle = document.getElementById('region');
  var birthEle = document.getElementById('birth');
  var nicknameEle = document.getElementById('nickname');
  var genderEle = document.getElementsByName('gender');

  var flag = true; /* 회원가입 유효성 체크 유무 */

  //1) 이메일 주소 체크
    
    if(!isEmail(idEle.value)) {
      id_errmsg.innerHTML = "이메일를 입력하세요.";
      flag = flag && false;
//      if(isEmail(idEle.value) > 30){
//    	  flag = flag && false;
//    	  id_errmsg.innerHTML = "이메일은 30자 이내로 작성해주세요.";
//      }
    }else{
        id_errmsg.innerHTML = "멋진 이메일이네요!";
        id_errmsg.style.color= "green";
        id_errmsg.style.fontSize='0.7em';
    }
  //2) 비밀번호 체크
    if(!isPassword(pwEle.value)) {
      pw_errmsg.innerHTML = "비밀번호를 입력해주세요(6~10자리)";
    
    	  flag = flag && false;      
    }else{
      pw_errmsg.innerHTML = "";
    }
  //3) 비밀번호 재확인
    //3-1)비밀번호 패턴 체크
    if(!isPassword(pwChkEle.value) && isPassword(pwChkEle.value) == 0) {
      pwChk_errmsg.innerHTML = "비밀번호 재확인을 해주세요.";
      flag = flag && false;
    }else{
      pwChk_errmsg.innerHTML = "";
    }
    //3-2)비밀번호 일치 체크
    if(pwEle.value != pwChkEle.value ) {
      pwChk_errmsg.innerHTML = "비밀번호가 일치하지 않습니다.";
      flag = flag && false;
    }else {
      pwChk_errmsg.innerHTML = "";
    }
  //4) 전화번호
    if(!isTel(telEle.value)) {
      tel_errmsg.innerHTML = "전화번호를 입력해주세요 ex) 010-1234-5678";
      flag = flag && false;
    }else{
      tel_errmsg.innerHTML = "";
    }    
    //5) 생년월일
    if(!isBirth(birthEle.value)) {
    	birth_errmsg.innerHTML = "생년월일를 입력해주세요 ex) 1901-01-01";
    	flag = flag && false;
    }else{
    	birth_errmsg.innerHTML = "";
    }    
  //6) 지역
//    if(regionEle.selectedIndex == 0){
//    	region_errmsg.innerHTML = "지역을 선택해주세요!";
//      flag = flag && false;
//    }else{
//    	region_errmsg.innerHTML = "";
//    }
  //7) 성별
    var status = false;
    for(var gender of genderEle) {
      if(gender.checked) {
        status = true;
        break;
      }
    }
    if(!status) {
      gender_errmsg.innerHTML = "성별을 선택해주세요!";
      flag = flag && false;
    }else{
      gender_errmsg.innerHTML = "";
    }
  //8) 닉네임
    if(!isnickname(nicknameEle.value) && isnickname(nicknameEle.value) < 2) {
        nickname_errmsg.innerHTML = "닉네임을 입력해 주세요.(2~10자이내)";
        flag = flag && false;
      }else{
        nickname_errmsg.innerHTML = "";
      }    
    return flag;

}
// 이메일 체크 정규식
function isEmail(asValue) {
  var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
  return regExp.test(asValue); // 형식에 맞는 경우 true 리턴	
}
// 닉네임 체크 정규식
function isnickname(asValue) {
	var regExp = /^[\w\Wㄱ-ㅎㅏ-ㅣ가-힣]{2,20}$/;
	return regExp.test(asValue); // 형식에 맞는 경우 true 리턴	
}

// 핸드폰 번호 체크 정규식
function isTel(asValue) {
  var regExp = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;
  return regExp.test(asValue); // 형식에 맞는 경우 true 리턴
}
//생년월일 체크 정규식
function isBirth(asValue) {
	var regExp = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
	return regExp.test(asValue); // 형식에 맞는 경우 true 리턴
}
//비밀번호 체크 정규식
function isPassword(asValue) {
  var regExp = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,10}$/; //  8 ~ 10자 영문, 숫자 조합
  return regExp.test(asValue); // 형식에 맞는 경우 true 리턴
}
