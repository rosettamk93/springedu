<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>피규어빌리지 :: 피규어빌리지란?</title>
       <link rel="stylesheet" href="<c:url value='/resources/css/main.css' />">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-1/css/all.min.css" />
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Stylish&display=swap"
	rel="stylesheet">
<script src="<c:url value='/resources/js/common.js' />"></script>
<style>
    body *{ 
       /* outline: 1px solid red; */
}
    .imgbox{width: 100%; display: flex; justify-content: center;}
    .intro{width: 100%; height: 100px; text-align: center; font-family: Stylish, "Open Sans", sans-serif;}
    .welcome{width: 100%; text-align: center; font-size: 2em; font-family: Stylish, "Open Sans", sans-serif;}

    .conception{width: 100%; display: flex; justify-content: center; }
    .more-info{width: 100%; height: 100%; display: flex; justify-content: center;}
    .sub-info{text-align: center; font-family: Stylish, "Open Sans", sans-serif;}
     h2{text-align: center; font-size: 2em;}
     .table{width : 60%; border-collapse: collapse; }
     .table th{ text-align: right; font-family: Stylish, "Open Sans", sans-serif;}
     .table th a{text-decoration: none; color : black;}
     .table th a:hover{font-size: 1.2em; font-weight: 900;}
     .table td{ text-align: center; font-family: 0.5em; }
     .QnA{width:100%; height: 500px;}
    @media only screen and (max-width:800px) {
      #FVfunction{width: 100%;}
       }
       @media only screen and (max-width:1250px) {
        .table{width : 100%;}
        .table td{font-size: 0.75em;}
       }
</style>
</head>

<%@ include file="header.jsp"%>
<body>

	<div class="welcome">피규어빌리지에 오신 것을 환영합니다!</div>

	<div class="intro">피규어빌리지란?</div>
	<div class="conception">
		<img src="<c:url value='/resources/img/FVfunction.jpg' />" width="70%"
			alt="" id="FVfunction">
	</div>

	<h2> 상단 메뉴바 정보 </h2>
<div class="more-info">
    <table border="1" class="table">
        <colgroup>
        <col width="15%">
        <col width="80%">
        </colgroup>
        <tr>
            <th> <a href="">상품검색</a>
                <td>관심있는, 혹은 찾으시는 피규어를 검색/조회할 수 있습니다.</td>
            </th>
        </tr>
        <tr>
            <th> <a href="${pageContext.request.contextPath}/nboard/list">공지사항</a>
                <td>결제시스템 오류 및 신규 상품 입고 등. 기존 및 신규 공지사항을 확인할 수 있습니다.</td>
            </th>
        </tr>
        <tr>
            <th> <a href="${pageContext.request.contextPath}/aboard/list">후기게시판</a>
                <td>여러 회원님들께서 후기를 나눠주시면 저희에게 힘이 됩니다 <i class="far fa-laugh-beam"></i> </td>
            </th>
        </tr>
        <tr>
            <th> <a href="${pageContext.request.contextPath}/board/list">자유게시판</a>
                <td>구매하지 않으셔도 괜찮습니다. 자유롭게 회원님들과 소통하세요~</td>
            </th>
        </tr>
        <tr>
            <th> <a href="">고객센터</a>
                <td>상품문의, 궁금하거나 만족스럽지 못한 사항을 도와드리겠습니다.</td>
            </th>
        </tr>
    </table>
</div>
        <div class="sub-info">
            좌측 태그를 클릭하시면 해당 페이지로 이동합니다.
        </div>
        <div class="QnA">
					
        </div>
</body>
<%@ include file="footer.jsp" %>
</html>