<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시판</title>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-1/css/all.min.css" />  
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Stylish&display=swap" rel="stylesheet">
<script src="<c:url value='/resources/js/common.js' />"></script>
<style>
	#boardList {width:80%; padding: 10px; height: 100%;}
	#boardList h2{ text-align: center; padding:30px 0;}

  .login-wrapper {
    width: 100%;
  }
  .mycontainer.main-inner-box{height: 100%;}
  .mycontainer.mycontainer-sc{display: flex; justify-content: center;}
  #boardList th:not(#nottd), td:not(#nottd) {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }
	#boardList table th:nth-child(1) { width:7%; }
/* 	#boardList table td:nth-child(1) { text-align: right; } */
	#boardList table th:nth-child(2) { width:8%; }
	#boardList table th:nth-child(3) { width:36%; }
	#boardList table td:nth-child(3):hover { text-decoration: underline; }
	#boardList table th:nth-child(4) { width:23%; }
	#boardList table th:nth-child(5) { width:17%; }
	#boardList table th:nth-child(6) { width:10%; }
/* 	#boardList table td:nth-child(6) { text-align: right; } */
	#boardList table td:not(#nottd0){ padding:3px; text-align: center;}
		
	#boardList table {
		font-size:0.825rem;
	}
	table{border-collapse: collapse;}
	table tr:not(#not-tr){border-bottom: 1px solid;}
	#boardList #writeBtn { width:100%; padding: 2px 3px;}
	#boardList #paging, #boardList #search{
		display:flex;
		justify-content: center;
	}
	#boardList #paging, #boardList #search{
		padding: 10px 5px;
	}
	#boardList #paging a{
		padding:3px;
	}
	#boardList #paging a:hover{
		text-decoration: underline;
	}
	#boardList #paging a.on{
		background-color:whitesmoke;
	}
 	#boardList #search input[type="search"]{
		width:200px;}
	
	#boardList #search #searchBtn{ padding:2px; } 
	
	#writeBtn{background-color:black; color : white;}
	   	.plus-space{width:100%; height: 150px;}
	   	#title-tr{background-color: whitesmoke;}
</style>	
<script src="<c:url value='/resources/js/common.js' />"></script>	
<script>
	window.addEventListener("load",init,false);

	function init(){
		//글쓰기 버튼 클릭시
		<c:if test="${sessionScope.member.admin > 0  }">
		writeBtn.addEventListener("click",function(e){
			e.preventDefault();
			let returnPage = e.target.getAttribute('data-returnPage');
			location.href=getContextPath()+"/nboard/writeForm/"+returnPage;
		},false);
</c:if>
		//검색버튼 클릭시
		searchBtn.addEventListener("click",function(e){
			e.preventDefault();
			//console.log("검색!!");
			// 검색어 입력값이 없으면
			if(keyword.value.trim().length == 0) {
				alert('검색어를 입력하세요!');
				keyword.value="";
				keyword.focus();
				return false;
			}

			let stype = searchType.value; 			//검색유형
			let kword = keyword.value.trim();		//검색어

			location.href = getContextPath() + "/nboard/list/1/" + stype + "/" + kword;
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
						<div id="boardList">
							<div><h2 id="title">공지사항 </h2></div>
							<div>
								<table class="login-wrapper" >
									<tr id="title-tr">
										<th>번호</th>
										<th>분류</th>
										<th>제목</th>
										<th>작성자</th>
										<th>작성일</th>
										<th>조회수</th>
									</tr>
									<c:forEach var="rec" items="${list }">	
									<fmt:formatDate value="${rec.nbcdate }" pattern="yyyy/MM/dd HH:mm" var="nbcdate"/>						
									<tr>
										<td>${rec.nbnum }</td>
										<td>${rec.boardCategoryVO.cname }</td>
										<td  id="nottd0">
											<a href="${pageContext.request.contextPath }/nboard/view/${pc.rc.reqPage}/${rec.nbnum }">
												${rec.nbtitle } 
											</a>
											
										</td>
										<td>${rec.nbnickname }</td>
										<td>${nbcdate }</td>
										<td>${rec.nbhit }</td>
									</tr>
								</c:forEach>
									<tr id="not-tr">
										<td colspan="5" id="nottd"></td>
										<td id="nottd">
										<c:if test="${sessionScope.member.admin > 0  }">
										<button id="writeBtn" data-returnPage="${pc.rc.reqPage }">글쓰기</button>
										</c:if>
										</td>
									</tr>
								</table>
							</div>
							<div id="paging">	
								<!-- 처음페이지 / 이전페이지 이동 -->
								<c:if test="${pc.prev }" >
									<a href="${pageContext.request.contextPath }/nboard/list/1/${pc.fc.searchType}/${pc.fc.keyword}"><i class="fas fa-angle-double-left"></i></a>
									<a href="${pageContext.request.contextPath }/nboard/list/${pc.startPage-1}/${pc.fc.searchType}/${pc.fc.keyword}"><i class="fas fa-angle-left"></i></a>
								</c:if>
								<c:forEach var="pageNum" begin="${pc.startPage }" end="${pc.endPage }">
									<!-- 현재페이지와 요청페이지가 다르면 -->
									<c:if test="${pc.rc.reqPage != pageNum }">
									<a href="${pageContext.request.contextPath }/nboard/list/${pageNum }/${pc.fc.searchType}/${pc.fc.keyword}" class="off">${pageNum }</a>
									</c:if>								
									<!-- 현재페이지와 요청페이지가 같으면 -->
									<c:if test="${pc.rc.reqPage == pageNum }">
									<a href="${pageContext.request.contextPath }/nboard/list/${pageNum }/${pc.fc.searchType}/${pc.fc.keyword}" class="on">${pageNum }</a>
									</c:if>
								</c:forEach>
								<!-- 다음페이지 / 최종페이지 이동 -->	
								<c:if test="${pc.next }" >	
									<a href="${pageContext.request.contextPath }/nboard/list/${pc.endPage+1}/${pc.fc.searchType}/${pc.fc.keyword}"><i class="fas fa-angle-right"></i></a>
									<a href="${pageContext.request.contextPath }/nboard/list/${pc.finalEndPage}/${pc.fc.searchType}/${pc.fc.keyword}"><i class="fas fa-angle-double-right"></i></a>
								</c:if>	
							</div>
							<div id="search">
								<form>
									<select name="searchType" id="searchType">
										<option value="TC" 
											<c:out value="${pc.fc.searchType == 'TC' ? 'selected':'' }" />>제목+내용</option>
										<option value="T"
											<c:out value="${pc.fc.searchType == 'T' ? 'selected':'' }" />>제목</option>
										<option value="C"
											<c:out value="${pc.fc.searchType == 'C' ? 'selected':'' }" />>내용</option>
										<option value="N"
											<c:out value="${pc.fc.searchType == 'N' ? 'selected':'' }" />>작성자</option>
										<option value="I"
											<c:out value="${pc.fc.searchType == 'I' ? 'selected':'' }" />>아이디</option>
									</select>
									<input type="search" name="keyword" id="keyword" value="${pc.fc.keyword }"/>
									<button id="searchBtn">검색</button>
								</form>
							</div>
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