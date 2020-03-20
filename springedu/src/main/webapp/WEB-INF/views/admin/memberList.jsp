<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>              
<%@ page import="java.util.*" %>    
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-1/css/all.min.css" />  
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Stylish&display=swap" rel="stylesheet">
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원목록</title>
<style>
.table-box{ width : 100%; display:flex; justify-content: center;}
	table { border-collapse:collapse;
width : 80%;
height : 90%;
}
	table tr td{
	
		text-align: center;
	}
		*{font-family: Stylish, "Open Sans", sans-serif;}
		        .abstr{
/*         outline: 1px solid red; */
        width:100%;
        height: 250px;}
		        .abstr1{
/*         outline: 1px solid red; */
        width:100%;
        height: 50px;}
</style>

</head>
    <%@ include file="../header.jsp"%>
<body>
    <div class="abstr1"></div>
<table border="1">
	<div class="mycontainerAll">
		<div class="content">
		
		
		
			<!-- main -->
			<main>
				<div class="table-box">
				<div>
					<table border="1">
						<caption><h3>회원 목록</h3></caption>
						<colgroup>
							<col width="20%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="10%"/>
						</colgroup>
						<thead>
							<tr>
								<th>회원아이디</th>
								<th>비밀번호</th>
								<th>전화번호</th>
								<th>별칭</th>
								<th>성별</th>
								<th>지역</th>
								<th>생년월일</th>
								<th>생성일</th>
								<th>수정일</th>
							</tr>
						</thead>
						<tbody>	
							<c:forEach var="rec" items="${memberList }">
							<tr>
								<td>${rec.id}</td>
								<td>${rec.pw }</td>
								<td>${rec.tel }</td>
								<td>${rec.nickname}</td>
								<td>${rec.gender }</td>
								<td>${rec.region }</td>
								<td>${rec.birth}</td>
								<td>${rec.cdate }</td>
								<td>${rec.udate }</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>						
				</div>
				</div>
			</main>

		
		</div>
	</div>
<div class="abstr"></div>
</body>
    <%@ include file="../footer.jsp"%>
</html>