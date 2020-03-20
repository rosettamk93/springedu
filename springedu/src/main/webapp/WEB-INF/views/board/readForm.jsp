<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${boardVO.btitle}</title>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-1/css/all.min.css" />  
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Stylish&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<c:url value= '/resources/css/main.css' />">
  <style>
  *{font-family: Stylish, "Open Sans", sans-serif;}
  .mycontainer.main-inner-box{display: flex; justify-content: center; height: 100%;}
    #frm { margin-top:10px; padding: 10px; }
    #frm h2{ text-align: center; padding:30px 0;}
    #frm label { display: inline-block;}
    #frm .row { display:flex; padding: 3px; width:100%}
    #frm .row .col-1,
    #frm .row .col-2{
    	padding:3px;
    }
    #frm .row .col-1 { 
    	width:20%; text-align: right; letter-spacing: 5px; background-color:whitesmoke;
    	font-weight: bold; }
    #frm .row .col-2 { width:80%; margin-left:3px;}
    #frm .row .row.btns{ display:flex; justify-content: flex-end; }
    #frm .row .btn { width:10%; }
    #frm  .fileList{
    	font-color:#000;
    }
    #frm #fileList {
    	font-size:0.825em;
    }
    #frm a.fileList:hover {
    	text-decoration: underline;
    }
    #frm .row.hit {
    	width:100%;
    	display:flex;
    	justify-content: flex-end;
    	font-weight: bold;
    	font-size: 0.825rem;
    }
        #files{padding-left: 3px;}
        #replyBtn{background-color: black; color:white;}
        #listBtn {background-color:whitesmoke; color: black;}
        	.plus-space{width:100%; height: 150px;}
  </style>
	<script src="<c:url value='/resources/js/common.js' />"></script>
  <script>
	window.addEventListener("load",init, false);
	function init(){
		changeMode(false);
		
		let modifyBtn = document.getElementById('modifyBtn');
		let deleteBtn = document.getElementById('deleteBtn');
		
  //답글
		replyBtn.addEventListener("click",function(e){
			e.preventDefault();
			console.log("답글");
 				let returnPage = e.target.getAttribute('data-returnPage');				
 				let bnum = e.target.getAttribute('data-bnum');
				location.href = getContextPath()+"/board/replyForm/"+returnPage+"/"+bnum;
		},false);
  //수정
  if(modifyBtn != null) {
			modifyBtn.addEventListener("click",function(e){
				e.preventDefault();
				//console.log("수정");
				changeMode(true);
			},false);
  }
  //삭제
  if(deleteBtn != null){
			deleteBtn.addEventListener("click",function(e){
				e.preventDefault();
				//console.log("삭제"+e.target.getAttribute('data-del_bnum'));

 				if (confirm("삭제하시겠습니까?")){
 	 				let returnPage = e.target.getAttribute('data-returnPage');
 	 				let bnum = e.target.getAttribute('data-bnum');
					location.href = getContextPath()+"/board/delete/"+returnPage+"/"+bnum;
				} 
			},false);
  }

  //취소(수정모드->읽기모드)
		cancelBtn.addEventListener("click",function(e){
			e.preventDefault();
			console.log("취소");
			changeMode(false);
		},false);
  //저장	
		saveBtn.addEventListener("click",function(e){
			e.preventDefault();
			console.log("저장");
			//유효성체크

			//
			document.getElementById('boardVO').submit();
			
		},false);      

  //목록
		listBtn.addEventListener("click",function(e){
			e.preventDefault();
			console.log("목록");
				let returnPage = e.target.getAttribute('data-returnPage');
			location.href=getContextPath()+"/board/list/"+returnPage;
		},false);   

		//첨부파일 1건 삭제 : Ajax로 구현함.
		let fileList = document.getElementById('fileList');
		if(fileList != null ) {
			fileList.addEventListener("click",function(e){
				console.log(e.target); //이벤트가 발생된 요소
				console.log(e.currentTarget);//이벤트가 등록된 요소
				console.log(e.target.tagName);
				//선택된 요소가 첨부파일 삭제 아이콘일때만 삭제처리 수행
				if(e.target.tagName != 'I') return false;
				if(!confirm('삭제하시겠습니까?')) return false;
				//실제 이벤트가 발생한요소의 data-del_file속성값 읽어오기
				let fid = e.target.getAttribute('data-del_file');

			  //AJAX 사용
			  //1) XMLHttpRequest객체 생성	
			  var xhttp = new XMLHttpRequest();
			  
			  //2) 서버응답처리
			  xhttp.addEventListener("readystatechange",ajaxCall,false);
			  function ajaxCall(){
				  if (this.readyState == 4 && this.status == 200) {
					  console.log(this.responseText);
					  if(this.responseText == "success"){
					  	console.log('성공!!');
					  	//삭제대상 요소 찾기
 					  	let delTag = e.target.parentElement.parentElement.parentElement;
 					  	//부모요소에서 삭제대상 요소 제거
					  	fileList.removeChild(delTag); 
					  }else{
					  	console.log('실패!!');
					  }
				  }
			  }
			 	  			  
			  //post방식
			  xhttp.open("DELETE","http://localhost:9080/portfolio/board/file/"+fid,true);
			  xhttp.send();
			},false);  
		}
	}

	//읽기 모드 , 수정모드
	function changeMode(flag){						
			let rmodes = document.getElementsByClassName("rmode");
			let umodes = document.getElementsByClassName("umode");
		//수정모드	
		if(flag){
			//제목변경 => 게시글 보기
			document.getElementById("title").textContent = '게시글 수정';
			//분류,필드 제목,내용 필드
			document.getElementById("boardCategoryVO.cid").removeAttribute("disabled");			
			document.getElementById("btitle").removeAttribute("readOnly");			
			document.getElementById("bcontent").removeAttribute("readOnly");			
			//수정모드버튼 활성화
			Array.from(rmodes).forEach(e=>{e.style.display="none";});
			Array.from(umodes).forEach(e=>{e.style.display="block";});
		//읽기모드	
		}else{
			//제목변경 => 게시글 보기
			document.getElementById("title").textContent = '게시글 보기';
			//분류,필드 제목,내용 필드
			document.getElementById("boardCategoryVO.cid").setAttribute("disabled",true);						
			document.getElementById("btitle").setAttribute("readOnly",true);
			document.getElementById("bcontent").setAttribute("readOnly",true);	
			//읽기모드버튼 활성화				
			Array.from(rmodes).forEach(e=>{e.style.display="block";});
			Array.from(umodes).forEach(e=>{e.style.display="none";});
		}
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
							<div>
								<h2 id="title">게시글 보기</h2>
							</div>
							<form:form action="${pageContext.request.contextPath }/board/modify/${returnPage }" 
					    					 enctype="multipart/form-data"
					    					 method="post"
					    					 modelAttribute="boardVO">
					    <form:hidden path="bnum"/>					 					 
					    <div class="row hit" ><span>조회수 : ${boardVO.bhit }</span></div>					 
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
				        <form:input class="col-2" type="text" path="btitle" readOnly="true"/>
				        <form:errors path="btitle"/>
					    </div>
					    <div class="row">
					      <label class="col-1" path="bid" >작성자</label>
					      <p><span>${boardVO.bnickname }</span></p>
					    </div>
					    <div class="row">
					      <form:label class="col-1" path="bcontent" >내용</form:label>
					      <form:textarea class="col-2" rows="10" path="bcontent" readOnly="true"></form:textarea>
					      <form:errors path="bcontent"/>
					    </div>
					    <div class="row umode">
					      <form:label class="col-1" path="files" >첨부</form:label>
					      <form:input type="file" multiple="multiple" path="files"/>
					      <form:errors path="files"/>
					    </div>
					    
					    <!-- 첨부목록 -->
					    <c:if test="${!empty files}">
					    <div class="row">
					    	<div class="col-1">첨부목록</div>
					    	<div class="col-2" id="fileList">
					    		<c:forEach var="file" items="${files }">
					    		<p style="display:flex">
						    		<a class="fileList" href="${pageContext.request.contextPath}/board/file/${file.fid }">${file.fname }</a>
						    		<span style="margin-left:10px">(${file.fsize/1000 } kb)</span>
						    		<span class="umode" style="margin-left:10px">
						    			<a href="#none"><i class="fas fa-backspace" data-del_file="${file.fid }"></i></a>
						    		</span>
									</p>						    		
						    	</c:forEach>
					    	</div>
					    </div>
					    </c:if>
					    <!-- 버튼 -->
					    <div class="row">
					      <div class="row btns">
					        <form:button class="btn rmode" id="replyBtn" data-returnPage="${returnPage }" data-bnum="${boardVO.bnum }">답글</form:button>
					        <!-- 작성자만 수정, 삭제 가능 시작 -->
					        <c:if test="${sessionScope.member.id == boardVO.bid || sessionScope.member.admin > 0 }" >
					        <form:button class="btn rmode" id="modifyBtn">수정</form:button>
					        <form:button class="btn rmode" id="deleteBtn" data-returnPage="${returnPage }" data-bnum="${boardVO.bnum }">삭제</form:button>
					        </c:if>
					        <!-- 작성자만 수정, 삭제 가능 끝 -->
					        <form:button class="btn umode" id="cancelBtn">취소</form:button>
					        <form:button class="btn umode" id="saveBtn">저장</form:button>
					        <form:button class="btn" id="listBtn" data-returnPage="${returnPage }">목록</form:button>
					      </div>
					    </div>
					    </form:form>
						</div>
				<%@ include file="rereply.jsp" %>
					</div>
				</div>
			</main>
		</div>
	</div>
	<div class="plus-space"></div>
</body>
<%@ include file="../footer.jsp"%>
</html>