<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="<c:url value= '/resources/css/findID.css' />">
     <link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-1/css/all.min.css" />
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Stylish&display=swap"
	rel="stylesheet">
    <title>피규어빌리지 :: 아이디찾기</title>  
    <script src="<c:url value='/resources/js/findID.js' />"></script>
</head>
    <%@ include file="../header.jsp"%>
<body>
<div class="cont">
<div class="logo">
            <a href="<c:url value='/' />"><img src="<c:url value='/resources/img/title-img.png' />" class="logoimg" width="100%" height="100px" alt="logo"
                title="피규어빌리지 홈으로"></a>
    </div>
    <div class="container1">
        <div class="login-wrapper">
            <form id="frm">
               <div><h3 class="login-title">아이디찾기</h3></div>
                <div class="login-content">
										<div><input type="tel" name="tel" id="tel" value="" placeholder="전화번호"><i class="fas fa-mobile-alt fa-lg"></i> </div>
										<div><span  id="telMsg"></span></div>
                    <div><input type="date" name="birth" id="birth" placeholder="생년월일(0000-00-00)"> </div>
										<div><span  id="birthMsg" class="errmsg"></span> </div>
                    <div><input type="id" name="id" id="id" placeholder="찾은 아이디" readonly="readonly"></div>
                    <div class="findbtn"><input type="button" name="" id="findIDBtn" value="아이디 찾기"></div>
                </div>
            </form>
						<div class="find_info">
                <a href="<c:url value='/member/joinForm' />">회원가입</a>
                <span>|</span>
                <a href="<c:url value='/member/findPWForm' />">비밀번호 찾기</a>
                <span>|</span>
                <a href="<c:url value='/' />">메인화면</a>
            </div>
        </div>
    </div>
        <div class="abstr"></div>
        </div>
</body>
        <%@ include file="../footer.jsp"%>
</html>