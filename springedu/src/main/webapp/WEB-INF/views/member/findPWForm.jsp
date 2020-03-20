<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>        
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<link rel="stylesheet" href="<c:url value= '/resources/css/findPW.css' />">
     <link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-1/css/all.min.css" />
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Stylish&display=swap"
	rel="stylesheet">
<script src="<c:url value='/resources/js/findPW.js' />"></script>
<script src="<c:url value='/resources/js/common.js' />"></script>
</head>
    <%@ include file="../header.jsp"%>
<body>
<div class="cont">
<div class="logo">
            <a href="<c:url value='/' />"><img src="<c:url value='/resources/img/title-img.png' />" class="logoimg" width="100%" height="100px" alt="logo"
                title="피규어빌리지 홈으로"></a>
    </div>
  <div class="container1">
  <table class="login-wrapper">
    <caption><h2>비밀번호 찾기</h2></caption>
    <colgroup>
      <col width="30%">
      <col width="70%">
    </colgroup>
    <thead>
      <tr>
        <th>아 이 디</th>
        <td><input type="text" name="id" id="id"></td>
      </tr>
      <tr><td colspan="2" class="errmsg" id="idMsg"></td></tr>
      <tr>
        <th>전화번호</th>
        <td><input type="tel" name="tel" id="tel"></td>
      </tr>
      <tr><td colspan="2" class="errmsg" id="telMsg"></td></tr>
      <tr>
        <th>생년월일</th>
        <td><input type="date" name="birth" id="birth"></td>
      </tr>
      <tr><td colspan="2" class="errmsg" id="birthMsg"></td></tr>
      <tr class="hide">
        <th>비밀번호</th>
        <td><input type="password" name="pw" id="pw"></td>
      </tr>
      <tr class="hide"><td colspan="2" class="errmsg" id="pwMsg"> </td></tr>
      <tr class="hide">
        <th>비밀번호<br>확인</th>
        <td><input type="password" name="pwchk" id="pwchk"></td>
      </tr>
      <tr class="hide"><td colspan="2" class="errmsg" id="pwckhMsg"> </td></tr>
      <tr>
        <td colspan="2"><button id="findPWBtn">비밀번호찾기</button></td>
      </tr>
    </thead>    
  </table>
  </div>
      <div class="abstr"></div>
      </div>
</body>
      <%@ include file="../footer.jsp"%>
</html>