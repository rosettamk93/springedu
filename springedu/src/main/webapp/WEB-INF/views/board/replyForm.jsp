<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시판</title>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-1/css/all.min.css" />  
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Stylish&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<c:url value= '/resources/css/main.css' />">
<script src="<c:url value='/resources/js/common.js' />"></script>
<style>
  *{font-family: Stylish, "Open Sans", sans-serif;}
  .mycontainer.main-inner-box{display: flex; justify-content: center; height: 650px;}
  	#frm {margin-top:10px;}
    #frm { width:600px; padding: 10px; }
    #frm h2{ text-align: center; padding:30px 0;}
    #frm label { display: inline-block;}
    #frm .row { display:flex; padding: 3px; width:100%}
    #frm .row .col-1,
    #frm .row .col-2{
    	padding:3px;
    }
    #frm .row .col-1 { 
    	width:20%; text-align: right; letter-spacing: 10px; background-color:whitesmoke;
    	font-weight: bold; }
    #frm .row .col-2 { width:80%; margin-left:3px;}
    #frm .row .row.btns{ display:flex; justify-content: flex-end; }
    #frm .row .btn { width:10%; }
        #files{padding-left: 3px;}
</style>
<script>
window.addEventListener("load",init, false);
function init(){
	//등록버튼 클릭시
	writeBtn.addEventListener("click",function(e){
		e.preventDefault();
		//유효성체크

		//게시글 작성전송
		document.getElementById("boardVO").submit();
		
	},false);
	//취소버튼 클릭시
	cancelBtn.addEventListener("click",function(e){
		e.preventDefault();
		document.getElementById("boardVO").reset();
	},false);
	//목록버튼 클릭시
	listBtn.addEventListener("click",function(e){
		e.preventDefault();
			let returnPage = e.target.getAttribute('data-returnPage');
		location.href=getContextPath()+"/board/list/"+returnPage;
	},false);			
}
</script>
</head>
<%@ include file="../header.jsp"%>
<body>
	<div class="mycontainerAll">
		<div class="content">
			<!-- main -->
			<main>
				<div class="mycontainer main-inner-box">
					<div class="mycontainer mycontainer-sc">
					  <div id="frm">
					    <div><h2>답글 작성</h2></div>
					    <form:form action="${pageContext.request.contextPath }/board/reply/${returnPage }" 
					    					 enctype="multipart/form-data"
					    					 method="post"
					    					 modelAttribute="boardVO">
							<form:hidden path="boardCategoryVO.cid" value="${boardVO.boardCategoryVO.cid }"/>					    					 
							<form:hidden path="bgroup" value="${boardVO.bgroup }"/>					    					 
							<form:hidden path="bindent" value="${boardVO.bindent }"/>					    					 
							<form:hidden path="bstep" value="${boardVO.bstep }"/>					    					 
					    <div class="row">
					      <form:label path="boardCategoryVO.cid" class="col-1">분류</form:label>
					      <form:select class="col-2" path="boardCategoryVO.cid" disabled="true">
					        <option value="0">=== 선택 ===</option>
									<form:options path="boardCategoryVO.cid" 
																items="${boardCategoryVO}"
																itemValue="cid"
																itemLabel="cname"/>
					      </form:select>
					      <form:errors path="boardCategoryVO.cid"/>
					    </div>
					    <div class="row">
				        <form:label path="btitle" class="col-1">제목</form:label>
				        <form:input class="col-2" type="text" path="btitle"/>
				        <form:errors path="btitle"/>
					    </div>
					    <div class="row">
					      <label class="col-1" path="bid" >작성자</label>
					      <input type="text" class="col-2" readonly="true" value="${member.nickname }(${member.id })"/>
					    </div>
					    <div class="row">
					      <form:label class="col-1" path="bcontent" >내용</form:label>
					      <form:textarea class="col-2" rows="10" path="bcontent"></form:textarea>
					      <form:errors path="bcontent"/>
					    </div>
					    <div class="row">
					      <form:label class="col-1" path="files" >첨부</form:label>
					      <form:input type="file" multiple="multiple" path="files" id="files"/>
					      <form:errors path="files"/>
					    </div>
					    <div class="row">
					      <div class="row btns">
					        <form:button class="btn" id="writeBtn">등록</form:button>
					        <form:button class="btn" id="cancelBtn">취소</form:button>
					        <form:button class="btn" id="listBtn" data-returnPage="${returnPage }">목록</form:button>
					      </div>
					    </div>
					    </form:form>
					  </div>
					</div>
				</div>
			</main>
		</div>
	</div>
</body>
<%@ include file="../footer.jsp"%>
</html>