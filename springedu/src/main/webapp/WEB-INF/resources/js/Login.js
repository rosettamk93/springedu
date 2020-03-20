    window.addEventListener("load",init,false);
    
    function init(){
    var idTag = document.getElementById("id");
    var pwTag = document.getElementById("pw");

    var loginBtn = window.document.getElementById("loginBtn");
    console.log(loginBtn);
    loginBtn.addEventListener("click",function(e){
        e.preventDefault();
       var result = checkLogin();
       if(result){
    	   document.getElementById("frm").submit();
       }

    },false);
    }
    function checkLogin(){
      var idTag = document.getElementById("id");
      var idValue = idTag.value;
      var idMsg = document.getElementById("idMsg");
      var pwMsg = document.getElementById("pwMsg");
      var pwTag = document.getElementById("pw");
      var pwValue = pwTag.value;
      var flag = true;
      
//      const ID = 'rosettamk93@naver.com'; 임의의 아이디 비밀번호 부여
//      const PW = '1346fhsto';
    //로그인 유효성체크
    //1)아이디, 비밀번호 빈문자열 체크
    if(idValue.trim().length == 0){
    idMsg.innerHTML="아이디를 입력하세요!";
    idMsg.classList.add("idmsg");
    idTag.focus();
    flag = false;
    return flag;
    }
    if(pwValue.trim().length == 0){
    pwMsg.innerHTML="비밀번호를 입력하세요!";
    pwMsg.classList.add("pwmsg");
    pwTag.focus();
    flag = false;
    return flag;
    }
    return flag;
//        console.log(idValue.trim(),pwValue.trim());
//        //2) 회원 존재유무 체크
//        if(idValue.trim() == ID && pwValue.trim()==PW){
//        //메인페이지로 이동
//        window.location.href = "main-login.html";
//        }else{
//        pwMsg.innerHTML = "미가입 계정이거나, 잘못된 비밀번호입니다!";
//        pwMsg.style.color="red";
//        pwMsg.style.fontSize="0.5rem";
//        pwMsg.style.fontWeight = 'bold';
//        pwTag.focus();
//        return;
//        }
}