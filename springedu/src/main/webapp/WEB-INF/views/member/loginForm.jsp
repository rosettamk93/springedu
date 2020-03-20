<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="<c:url value= '/resources/css/login.css' />">
    
     <link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-1/css/all.min.css" />
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Stylish&display=swap"
	rel="stylesheet">
    <title>피규어빌리지 :: 로그인</title>  
    <script src="<c:url value ='/resources/js/Login.js'/>"></script>
</head>
    <%@ include file="../header.jsp"%>
<body>
<main>
<div class="logo">
            <a href="<c:url value='/' />"><img src="<c:url value='/resources/img/title-img.png' />" class="logoimg" width="100%" height="100px" alt="logo"
                title="피규어빌리지 홈으로"></a>
    </div>
    <div class="container1">
        <div class="login-wrapper">
            <form id="frm" action="<c:url value='/login?reqURI=${reqURI }' />" method="post">
               <div><h3 class="login-title">Login</h3></div>
                <div class="login-content">
                    <div><input type="text" name="id" id="id" value="" placeholder="아이디"></div>
          <div><span id="idMsg" class="errmsg"></span></div>
          <div><input type="password" name="pw" id="pw" placeholder="비밀번호"></div>
          <div><span id="pwMsg" class="errmsg"><c:if test="${!empty svr_msg}">${svr_msg }</c:if></span></div>
          <div><input type="submit" name="" id="loginBtn" value="로 그 인"></div>
                </div>
            </form>
            <div class="find_info">
                <a href="<c:url value='/member/findIDForm' />">아이디 찾기</a>
                <span>|</span>
                <a href="<c:url value='/member/findPWForm' />">비밀번호 찾기</a>
                <span>|</span>
                <a href="<c:url value='/member/joinForm' />">회원가입</a>
            </div>
        </div>
    </div>
    <div class="abstr"></div>
    </main>
</body>

        <%@ include file="../footer.jsp"%>
</html>