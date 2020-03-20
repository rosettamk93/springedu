    window.addEventListener("load",init,false);
    
    function init(){
    var idTag = document.getElementById("id");
    var pwTag = document.getElementById("pw");

    var outBtn = window.document.getElementById("outBtn");
    console.log(outBtn);
    outBtn.addEventListener("click",function(e){
        e.preventDefault();
       var result = checkOut();
       if(result){
    	   if(confirm("정말 회원탈퇴를 하시겠습니까?")){
    	   document.getElementById("outForm").submit();
    	   }
       }
    },false);
}
    function checkOut(){
      var idTag = document.getElementById("id");
      var idMsg = document.getElementById("idmsg");
      var pwMsg = document.getElementById("pwmsg");
      var idValue = idTag.value;
      var pwTag = document.getElementById("pw");
      var pwValue = pwTag.value;
      var flag = true;
      
//      const ID = 'rosettamk93@naver.com';
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
    idMsg.innerHTML ="";
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

