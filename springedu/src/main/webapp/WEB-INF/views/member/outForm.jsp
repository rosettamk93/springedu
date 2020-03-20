<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="<c:url value= '/resources/css/out.css' />">
     <link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-1/css/all.min.css" />
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Stylish&display=swap"
	rel="stylesheet">
    <title>피규어빌리지 :: 회원탈퇴</title>  
    <script src="<c:url value ='/resources/js/out.js'/>"></script>
</head>
    <%@ include file="../header.jsp"%>
<body>
<div class="conatainer1">
<div class="logo">
            <a href="<c:url value='/' />"><img src="<c:url value='/resources/img/title-img.png' />" class="logoimg" width="100%" height="100px" alt="logo"
                title="피규어빌리지 홈으로"></a>
    </div>
    <div class="container1">
        <div class="login-wrapper">
            <form id="outForm" action="<c:url value='/member/out' />" method="post">
               <div><h3 class="login-title">회원탈퇴</h3></div>
                <div class="login-content">
                    <div><input type="text" size="20" name="id" id="id" placeholder="탈퇴하실 계정(이메일)" value="${sessionScope.member.id }" readOnly></div>
                    <div><span id="idmsg"></span></div>
                    <div><input type="password" name="pw" id="pw" placeholder="PASSWORD"></div>
                    <div><span id="pwmsg" class="errmsg"><c:if test="${!empty svr_msg}"> ${svr_msg }</c:if></span></div>
                    <div><input type="submit" name="outBtn" id="outBtn" value="탈퇴하기"></div>
                </div>
            </form>
            <div class="find_info">
                <a href="<c:url value='/' />" title= "홈으로 돌아갑니다">취소할래요</a>
            </div>
        </div>
    </div>
        <div class="abstr"></div>
        </div>
</body>
        <%@ include file="../footer.jsp"%>
</html>