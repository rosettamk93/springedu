<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${nboardVO.nbtitle}</title>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-1/css/all.min.css" />  
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Stylish&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<c:url value= '/resources/css/main.css' />">
  <style>
  *{font-family: Stylish, "Open Sans", sans-serif;}
  .mycontainer.main-inner-box{ height: 100%;}
  .mycontainer.mycontainer-sc{width:100%; display: flex; justify-content: center;}
    #frm {width:40%; margin-top:10px; padding: 10px; }
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
        #replyBtn3{background-color: black; color:white; display : none !important;}
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
		replyBtn3.addEventListener("click",function(e){
			e.preventDefault();
			console.log("답글");
 				let returnPage = e.target.getAttribute('data-returnPage');				
 				let nbnum = e.target.getAttribute('data-nbnum');
				location.href = getContextPath()+"/nboard/replyForm/"+returnPage+"/"+nbnum;
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
 	 				let nbnum = e.target.getAttribute('data-nbnum');
					location.href = getContextPath()+"/nboard/delete/"+returnPage+"/"+nbnum;
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
			document.getElementById('nboardVO').submit();
			
		},false);      

  //목록
  	let listBtn = document.getElementById("listBtn");
		listBtn.addEventListener("click",function(e){
			e.preventDefault();
			console.log("목록");
				let returnPage = e.target.getAttribute('data-returnPage');
			location.href=getContextPath()+"/nboard/list/"+returnPage;
		},false);   

	}
	

	//읽기 모드 , 수정모드
	function changeMode(flag){						
			let rmodes = document.getElementsByClassName("rmode");
			let umodes = document.getElementsByClassName("umode");
		//수정모드	
		if(flag){
			//제목변경 => 게시글 보기
			document.getElementById("title").value = '게시글 수정';
			//분류,필드 제목,내용 필드
			document.getElementById("boardCategoryVO.cid").removeAttribute("disabled");			
			document.getElementById("nbtitle").removeAttribute("readOnly");			
			document.getElementById("nbcontent").removeAttribute("readOnly");			
			//수정모드버튼 활성화
			Array.from(rmodes).forEach(e=>{e.style.display="none";});
			Array.from(umodes).forEach(e=>{e.style.display="block";});
		//읽기모드	
		}else{
			//제목변경 => 게시글 보기
			document.getElementById("title").value = '게시글 보기';
			//분류,필드 제목,내용 필드
			document.getElementById("boardCategoryVO.cid").setAttribute("disabled",true);						
			document.getElementById("nbtitle").setAttribute("readOnly",true);
			document.getElementById("nbcontent").setAttribute("readOnly",true);	
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
							<form:form action="${pageContext.request.contextPath }/nboard/modify/${returnPage }" 
					    					 enctype="multipart/form-data"
					    					 method="post"
					    					 modelAttribute="nboardVO">
					    <form:hidden path="nbnum"/>					 					 
					    <div class="row hit" ><span>조회수 : ${nboardVO.nbhit }</span></div>					 
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
				        <form:label path="nbtitle" class="col-1">제목</form:label>
				        <form:input class="col-2" type="text" path="nbtitle" readOnly="true"/>
				        <form:errors path="nbtitle"/>
					    </div>
					    <div class="row">
					      <label class="col-1" path="nbid" >작성자</label>
					      <p><span>${nboardVO.nbnickname }</span></p>
					    </div>
					    <div class="row">
					      <form:label class="col-1" path="nbcontent" >내용</form:label>
					      <form:textarea class="col-2" rows="10" path="nbcontent" readOnly="true"></form:textarea>
					      <form:errors path="nbcontent"/>
					    </div>
					    
					  
					    <!-- 버튼 -->
					    <div class="row">
					      <div class="row btns">
					       <form:button class="btn rmode" id="replyBtn3" data-returnPage="${returnPage }" data-nbnum="${nboardVO.nbnum }">답글</form:button> 
					        <!-- 작성자만 수정, 삭제 가능 시작 -->
	
					        <c:if test="${sessionScope.member.admin > 0 }" >
					        <form:button class="btn rmode" id="modifyBtn">수정</form:button>
					        <form:button class="btn rmode" id="deleteBtn" data-returnPage="${returnPage }" data-nbnum="${nboardVO.nbnum }">삭제</form:button>
					        <!-- 작성자만 수정, 삭제 가능 끝 -->
					        </c:if>
					        <form:button class="btn umode" id="cancelBtn">취소</form:button>
					        <form:button class="btn umode" id="saveBtn">저장</form:button>
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
	<div class="plus-space"></div>
</body>
<%@ include file="../footer.jsp"%>
</html>