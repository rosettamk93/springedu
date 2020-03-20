<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-1/css/all.min.css" />
<link rel="stylesheet" href="../css/memberjoin.css" />
<link href="https://fonts.googleapis.com/css?family=Calistoga|Do+Hyeon|Jua|Oswald:400,500&display=swap&subset=korean" rel="stylesheet">
<script>
	window.addEventListener('load',init,false);
	function init(){
		var joinBtn = document.getElementById('joinBtn');
//		joinBtn.addEventListener('click',function(){
//			location.href="<c:url value='/member/join'/>";
//		},false)

//		window.addEventListener("load",init,false);
//		function init(){
		  joinBtn.addEventListener("click",function(e){ 
				  e.preventDefault(); 
				  var result = checkValid(); 
				  if(result){
					  console.log(document.getElementById('join-frm'));
					  var frmEle = document.getElementById('join-frm');
					  frmEle.submit();
					  //document.getElementById('join-frm').submit();
						//console.log(document.forms['join-frm']);
					  //document.forms['join-frm'].submit();
					}
			  },false); 
		} //init

		function checkValid(){ // 사용자 입력값 읽어오기
		  var idEle = document.getElementById('id');
		  var pwEle = document.getElementById('pw');
		  var pwChkEle = document.getElementById('pwChk');
		  var telEle = document.getElementById('tel');
		  var nicknameEle = document.getElementById('nickname');
		  var genderEle = document.getElementById('gender');
		  var regionEle = document.getElementById('region');
		  var birthEle = document.getElementById('birth');
		  var flag = true;
		    if(!isEmail(idEle.value)) { 
			    id_errmsg.innerHTML = "이메일 정보가 잘못되었습니다.";
		      flag = flag && false; 
		      }else{ id_errmsg.innerHTML = "멋진 이메일이네요!"; id_errmsg.style.color = "green"; }

		    if(!isPassword(pwEle.value)) { pw_errmsg.innerHTML = "비밀번호가 잘못되었습니다.(8~10)자리";
		      flag = flag && false; 
		      }else{ pw_errmsg.innerHTML = ""; }

		    if(!isPassword(pwChkEle.value)) { pwChk_errmsg.innerHTML = "비밀번호가 잘못되었습니다.(8~10)자리";
		      flag = flag && false; 
		      }else{ pwChk_errmsg.innerHTML = ""; }

		    if(pwEle.value != pwChkEle.value ) { pwChk_errmsg.innerHTML = "비밀번호가 일치하지 않습니다.";
		      flag = flag && false; 
		      }else { pwChk_errmsg.innerHTML = ""; }

		    if(!isTel(telEle.value)) { tel_errmsg.innerHTML = "전화번호가 잘못되었습니다.ex)010-1234-5678";
		      flag = flag && false; 
		      }else{ tel_errmsg.innerHTML = ""; }

		    if(nicknameEle.value.length <=2 && nicknameEle.value.length >=10){
			    nickname_errmsg.innerHTML= "닉네임이 잘못되었습니다(2~10자)";
	        flag = flag && false;
	        }else{nickname_errmsg.innerHTML= "";}

	      if(birthEle.value == null) {
					birth_errmsg.innerHTML = "생일을 입력해주세요.";
		      }  

		  //8) 생일
					function isEmail(asValue) { var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; return regExp.test(asValue); }
					function isTel(asValue) { var regExp = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/; return regExp.test(asValue); }
					function isPassword(asValue) {  var regExp = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,10}$/; return regExp.test(asValue); }
						return flag;
				}
</script>
</head>
    <%@ include file="../header.jsp"%>
    <%@ include file="../body1.jsp"%>
<body>
	<form id="join-frm" action="<c:url value='/member/join.do' />" method="post">
		<div class="container">
			<div class="content">

				<div> <h2 class="join-title">회 원 가 입</h2> </div>
				<div> <label for="id">아이디</label> </div>
				<div> <input type="email" name="id" id="id" placeholder="abc123@naver.com"><i class="far fa-envelope fa-lg"></i> </div>
				<div> <span class="errmsg" id="id_errmsg"></span> </div>
				<div> <label for="pw">비밀번호</label> </div>
				<div> <input type="password" name="pw" id="pw" placeholder="PASSWORD"><i class="fas fa-lock fa-lg"></i> </div>
				<div> <span class="errmsg" id="pw_errmsg"></span> </div>
				<div> <label for="pwChk">비밀번호 재확인</label> </div>
				<div> <input type="password" name="pwchk" id="pwChk"><i class="fas fa-lock fa-lg"></i> </div>
				<div> <span class="errmsg" id="pwChk_errmsg"></span> </div>
				<div> <label for="tel">전화번호</label> </div>
				<div> <input type="text" name="tel" id="tel" placeholder="010-0000-0000"><i class="fas fa-mobile-alt fa-lg"></i> </div>
				<div> <span class="errmsg" id="tel_errmsg"></span> </div>
				<div> <label for="nickname">닉네임</label> </div>
				<div> <input type="text" name="nickname" id="nickname" placeholder="10자 이내 한/영"> </div>
				<div> <span class="errmsg" id="nickname_errmsg"></span> </div>
				
				<div> <label for="gender">성별</label> </div>
				<div> <input type="radio" name="gender" id="men"  value="남"><label for="men">남</label>
						  <input type="radio" name="gender" id="women" value="여"><label for="women">여</label>
			  </div>
				<div> <span class="errmsg" id="gender_errmsg"></span> </div>
				
				
				<div> <label for="region">주소</label> </div>
				<div> <select name="region" id="region">
                <option value="">= 선택해주세요 =</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="대구">대구</option>
                <option value="부산">부산</option>
                <option value="울산">울산</option>
             </select>
        </div>
				<div> <span class="region" id="region_errmsg"></span> </div>
				<div> <label for="birth">생일</label> </div> <div>
					<input type="date" name="birth" id="birth" placeholder="ex)2000-01-01" size="40px"> </div> 
					<div> <span class="birth" id="birth_errmsg"></span> </div>
				<div> <button type="submit" id="joinBtn">가 입 하 기</button> </div>
				<br>
				<a href="${pageContext.request.contextPath}/" id="cancle"> <li>가 입 취 소</li></a>
			</div>
		</div>
	</form>
    <div class="abstr"></div>
        <%@ include file="../footer.jsp"%>
</body>
</html>