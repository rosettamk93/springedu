<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>테스트</h3>
	<form action="/portfolio/test/t11" method="post">
	<p><label for="name">이름</label><input type="text" name="name" id="name" value="${per.name }"/></p>
	<p><label for="age">나이</label><input type="text" name="age" id="age" value="${per.age }"/></p>
<p><input type="submit" value="전송"></p>
	</form>
</body>
</html>