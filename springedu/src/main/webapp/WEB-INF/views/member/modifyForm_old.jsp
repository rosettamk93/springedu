<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-1/css/all.min.css" />
<link rel="stylesheet" href="<c:url value= '/resources/css/memberjoin.css' />">
<link href="https://fonts.googleapis.com/css?family=Calistoga|Do+Hyeon|Jua|Oswald:400,500&display=swap&subset=korean" rel="stylesheet">
    <script src=<c:url value ='/resources/js/MemberModify.js'/>"></script>
</head>
    <%@ include file="../header.jsp"%>
    <%@ include file="../body1.jsp"%>
<body>
	<form id="join-frm" action="<c:url value='/member/modify' />" method="post">
		<div class="container">
			<div class="content">

				<div> <h2 class="join-title">회 원 수 정</h2> </div>
				<div> <label for="id">아이디</label> </div>
				<div> <input type="text" name="id" id="id" value="${memberVO.id }" readonly="readonly"><i class="far fa-envelope fa-lg"></i> </div>
				<div> <span class="errmsg" id="id_errmsg"></span> </div>
				<div> <label for="pw">비밀번호</label> </div>
				<div> <input type="password" name="pw" id="pw" ><i class="fas fa-lock fa-lg"></i> </div>
				<div> <span class="errmsg" id="pw_errmsg"></span> </div>
				<div> <label for="tel">전화번호</label> </div>
				<div> <input type="text" name="tel" id="tel" value="${memberVO.tel }"><i class="fas fa-mobile-alt fa-lg"></i> </div>
				<div> <span class="errmsg" id="tel_errmsg"></span> </div>
				<div> <label for="nickname">닉네임</label> </div>
				<div> <input type="text" name="nickname" id="nickname" value="${memberVO.nickname }"> </div>
				<div> <span class="errmsg" id="nickname_errmsg"></span> </div>
				<div> <label for="region">주소</label> </div>
				<div> <select name="region" id="region">
                <option value="">= 선 택 =</option>
                <option value="서울" ${memberVO.region == "서울" ? 'selected="selected"' : ' ' }>서 울</option>
                <option value="경기" ${memberVO.region == "경기" ? 'selected="selected"' : ' ' }>경 기</option>
                <option value="대구" ${memberVO.region == "대전" ? 'selected="selected"' : ' ' }>대 전</option>
                <option value="대구" ${memberVO.region == "대구" ? 'selected="selected"' : ' ' }>대 구</option>
                <option value="부산" ${memberVO.region == "부산" ? 'selected="selected"' : ' ' }>부 산</option>
                <option value="울산" ${memberVO.region == "울산" ? 'selected="selected"' : ' ' }>울 산</option>
                <option value="경남" ${memberVO.region == "경남" ? 'selected="selected"' : ' ' }>경 남</option>
                <option value="경북" ${memberVO.region == "경북" ? 'selected="selected"' : ' ' }>경 북</option>
                <option value="충남" ${memberVO.region == "충남" ? 'selected="selected"' : ' ' }>충 남</option>
                <option value="충북" ${memberVO.region == "충북" ? 'selected="selected"' : ' ' }>충 북</option>
                <option value="전남" ${memberVO.region == "전남" ? 'selected="selected"' : ' ' }>전 남</option>
                <option value="전북" ${memberVO.region == "전북" ? 'selected="selected"' : ' ' }>전 북</option>
                <option value="강원" ${memberVO.region == "강원" ? 'selected="selected"' : ' ' }>강 원</option>
                <option value="제주" ${memberVO.region == "제주" ? 'selected="selected"' : ' ' }>제 주</option>
             </select>
        </div>
				<div> <span class="region" id="region_errmsg"></span> </div>
				
				<div> <label for="gender">성별</label> </div>
				<div> <input type="radio" name="gender" id="men"  value="남" ${memberVO.gender == "남" ? 'checked = "checked"' : ''}><label for="men">남</label>
						  <input type="radio" name="gender" id="women" value="여"${memberVO.gender == "여" ? 'checked = "checked"' : ''}><label for="women">여</label> </div>
				<div> <span class="errmsg" id="gender_errmsg"></span> </div>
				
				
				<div> <label for="birth">생년월일</label> </div> <div>
					<input type="date" name="birth" id="birth" value="${memberVO.birth }"> </div> 
					<div> <span class="birth" id="birth_errmsg"></span> </div>
				<div> <button type="submit" id="modifyBtn">수 정 하 기</button> </div>
			</div>
		</div>
	</form>
	    <div class="abstr"></div>
    <%@ include file="../footer.jsp"%>
</body>
</html>