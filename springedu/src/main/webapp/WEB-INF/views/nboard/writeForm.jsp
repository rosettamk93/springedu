<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link
	href="https://fonts.googleapis.com/css?family=Calistoga|Do+Hyeon|Jua|Oswald:400,500&display=swap&subset=korean"
	rel="stylesheet">
<link rel="stylesheet" href="<c:url value= '/resources/css/main.css' />">
<script src="<c:url value='/resources/js/common.js' />"></script>
<style>
.mycontainer.main-inner-box {width : 100%; height: 650px;}
.mycontainer.mycontainer-sc{width : 100%; height : 100%; display : flex; justify-content: center; }
    #frm { padding: 10px;width : 80%; }
    #frm h2{ text-align: center; padding:30px 0;}
    #frm label { display: inline-block;}
    #frm .row { display:flex; padding: 3px; width:100%}
    #frm .row .col-1,
    #frm .row .col-2{
    	padding:3px;
    }
    #frm .row .col-1 { 
    	width:10%; text-align: right; letter-spacing: 10px; background-color: whitesmoke;
    	font-weight: bold; }
    #frm .row .col-2 { width: 90%; margin-left:3px;}
    #frm .row .row.btns{ display:flex; justify-content: center; }
    #frm .row .btn { width:60px; }
    table { width : 100%;  }
    #writeBtn2{background-color: black; color : white;}
    #cancelBtn{color:black;}
    #listBtn{background-color: #CCCCCC; color : black;}
    #error {font-size: 0.75em; color : red; }
    #files{padding-left: 3px;}
</style>
<script>
window.addEventListener("load",init, false);
function init(){
	//등록버튼 클릭시
	window.addEventListener("load",init, false);
	function init(){
		//등록버튼 클릭시
		writeBtn2.addEventListener("click",function(e){
			e.preventDefault();
			//유효성체크

			//게시글 작성전송
			document.getElementById("nboardVO").submit();
			
		},false);
		//취소버튼 클릭시
		cancelBtn.addEventListener("click",function(e){
			e.preventDefault();
			document.getElementById("nboardVO").reset();
		},false);
		//목록버튼 클릭시
		listBtn.addEventListener("click",function(e){
			e.preventDefault();
				let returnPage = e.target.getAttribute('data-returnPage');
			location.href=getContextPath()+"/nboard/list/"+returnPage;
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
					    <div><h2>게시글 작성</h2></div>
					    <form:form action="${pageContext.request.contextPath }/nboard/write/${returnPage }" 
					    					 enctype="multipart/form-data"
					    					 method="post"
					    					 modelAttribute="nboardVO">
					    <div class="row">
					      <form:label path="boardCategoryVO.cid" class="col-1">분류</form:label>
					      <form:select class="col-2" path="boardCategoryVO.cid" >
					        <option value="0">=== 선택 ===</option>
									<form:options path="boardCategoryVO.cid" 
																items="${boardCategoryVO}"
																itemValue="cid"
																itemLabel="cname"/>
					      </form:select>
					    </div>
					      <form:errors path="boardCategoryVO.cid" id="error"/>
					    <div class="row">
				        <form:label path="nbtitle" class="col-1">제목</form:label>
				        <form:input class="col-2" type="text" path="nbtitle"/>
					    </div>
				        <form:errors path="nbtitle" id="error"/>
					    <div class="row">
					      <label class="col-1" path="abid" >작성자</label>
					      <input type="text" class="col-2" readonly="true" value="${member.nickname }(${member.id })"/>
					    </div>
					    <div class="row">
					      <form:label class="col-1" path="nbcontent" >내용</form:label>
					      <form:textarea class="col-2" rows="10" path="nbcontent"></form:textarea>
					    </div>
					      <form:errors path="nbcontent" id="error"/>
					    <div class="row">
					      <div class="row btns">
					        <form:button class="btn" id="writeBtn2">등록</form:button>
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