<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>테스트</h3>
	<form:form modelAttribute="per" action="/portfolio/test/t11" method="post">	
		<p><label for="name">이름</label>
			 <form:input type="text" path="name"/>
			 <form:errors path="name" />
			 </p>
		<p><label for="age">나이</label>
			 <form:input type="text" path="age"/>
			 <form:errors path="age" />
			 </p>
		<p><input type="submit" value="전송"></p>
	</form:form>
</body>
</html>