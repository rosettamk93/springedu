<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link rel="stylesheet" href="<c:url value= '/resources/css/memberModify.css' />">
  <link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-1/css/all.min.css" />
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Stylish&display=swap"
	rel="stylesheet">
    <script src="<c:url value ='/resources/js/MemberModify.js'/>"></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
.dorom{background-color: whitesmoke; text-align: center;}
</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_detailAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_detailAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
</head>
    <%@ include file="../header.jsp"%>
    
<body>
<div class="logo">
            <a href="<c:url value='/' />"><img src="<c:url value='/resources/img/title-img.png' />" class="logoimg" width="100%" height="100px" alt="logo"
                title="피규어빌리지 홈으로"></a>
    </div>
  <form:form id="joinFrm" modelAttribute="mvo"  action="${pageContext.request.contextPath }/member/modify" method="post">
    <div class="container1">
      <div class="content">
        <div><h2 class="join-title">회 원 정 보 수 정</h2></div>
        <div><form:label path="id">아이디</form:label></div>
        <div><form:input type="text" path="id" readOnly="true" /><i class="far fa-envelope fa-lg"></i></div>
        <div><form:errors path="id" cssClass="errmsg" id="id_errmsg"></form:errors></div>
        <div><form:label path="pw">비밀번호</form:label></div>
        <div><form:input type="password" path="pw" /><i class="fas fa-lock fa-lg"></i></div>
        <div><span class="errmsg" id="pw_errmsg"></span>
        <form:errors path="pw" cssClass="errmsg" id="pw_errmsg"></form:errors></div>              
        <div><form:label path="tel">전화번호</form:label></div>
        <div><form:input type="tel" path="tel" /><i class="fas fa-mobile-alt fa-lg"></i></div>
				<div><span class="errmsg" id="tel_errmsg"></span>
				<form:errors path="tel" cssClass="errmsg" id="tel_errmsg"></form:errors></div>                   
        <div><form:label path="nickname">별칭</form:label></div>
        <div><form:input type="text" path="nickname" /><i class="fas fa-id-badge"></i></div>
				<div><span class="errmsg" id="nickname_errmsg"></span>
				<form:errors path="nickname" cssClass="errmsg" id="nickname_errmsg"></form:errors></div>                 
        <div><form:label path="region">지역</form:label><i class="fas fa-map-signs"></i></div>
       <!--  <div> -->
        <div class="dorom">
				<div> <form:label path="region">주소</form:label> <i class="fas fa-map-signs"></i></div>
								
<form:input type="button" path="region" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" /><br>
<form:input type="text" path="region1" id="sample6_postcode" placeholder="우편번호" />
<form:input type="text" path="region2" id="sample6_address" placeholder="주소" /><br>
<form:input type="text" path="region3" id="sample6_detailAddress" placeholder="상세주소" />
				
				
</div>
			 <%--  <div> 
		  				<form:select path="region">
                <option value="">= 선 택 =</option>
                <form:options path="region" items="${region }" itemValue="code" itemLabel="label"/>
              </form:select>
        </div> --%>
          <%-- <form:select path="region">
            <option value="0">== 선 택 ==</option>
            <form:options path="region" items="${region }" itemValue="code" itemLabel="label" />
          </form:select>
        </div> --%>
				<div><span class="region" id="region_errmsg"></span>
				<form:errors path="region" cssClass="errmsg" id="region_errmsg"></form:errors></div>                  
        <div><form:label path="gender">성별</form:label> <i class="fas fa-venus-mars"></i></div>
        <div>
          <form:radiobuttons path="gender" items="${gender }" itemValue="code" itemLabel="label"/>
        </div>
				<div><span class="errmsg" id="gender_errmsg"></span>
				<form:errors path="gender" cssClass="errmsg" id="gender_errmsg"></form:errors></div>                    
        <div><form:label path="tel">생년월일</form:label></div>
        <div><form:input type="date" path="birth" /><i class="fas fa-birthday-cake"></i></div>
				<div> <span class="errmsg" id="birth_errmsg"></span>
				<form:errors path="birth" cssClass="errmsg" id="birth_errmsg"></form:errors></div>          
        <div><button type="submit" id="modifyBtn">수 정 하 기</button></div>
      </div>
    </div>
  </form:form>
	    <div class="abstr"></div>
    <%@ include file="../footer.jsp"%>
</body>
</html>