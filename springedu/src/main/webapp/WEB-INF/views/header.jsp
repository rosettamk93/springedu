<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
       <link rel="stylesheet" href="<c:url value='/resources/css/main.css' />">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-1/css/all.min.css" />  
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Stylish&display=swap" rel="stylesheet">
      <script src="<c:url value ='/resources/js/main.js'/>"></script>
  <script type="text/javascript" src="http://code.jquery.com/jquery-1.8.2.js"></script>
  <script type="text/javascript"> 
    function scroll_follow(id) {
      $(window).scroll(function ()  //스크롤이 움직일때마다 이벤트 발생
      {
        var position = $(window).scrollTop(); // 현재 스크롤바의 위치값을 반환합니다.
        $(id).stop().animate({ top: position + "px" }, 850); //해당 오브젝트 위치값 재설정
      });
    }
    scroll_follow("#scroll");
    //스크롤이 생기도록 <br> 을 여러게 넣은 부분..
    $(document).ready(function(){ for( var i=0; i<200; i++ ) {$('#brr').html($('#brr').html() +"<br>" + i);} });
    

  function doBlink() {
    var blink = document.all.tags("BLINK")
    for (var i = 0; i < blink.length; i++)
      blink[i].style.visibility = blink[i].style.visibility == "" ? "hidden" : ""
  }
  function startBlink() {
    if (document.all)
      setInterval("doBlink()", 500)
  }
  window.onload = startBlink; 
    </script> 
<body>


  <!-- 반응형 메뉴바 -->
  <div class="wrapper">

    <header id="header">
      <nav id='desktop'>
        <ul>
	          <li><a href="<c:url value='/information' />">피규어빌리지란?</a></li>
          <li><a href="#">상품검색</a></li>
          <li><a href="${pageContext.request.contextPath}/nboard/list">공지사항</a></li>
          <li><a href="${pageContext.request.contextPath}/board/list">자유게시판</a></li>
          <li><a href="${pageContext.request.contextPath}/aboard/list">후기게시판</a></li>
        </ul>
      </nav>
      <nav id='mobile'>
        <!-- <ul> -->
        <a href="<c:url value='/' />"><img src="<c:url value='/resources/img/logo1.jpg' />" width="150px" height="150px" alt="logo" title="피규어빌리지 홈으로" id="logoimg"></a><br><small>상단이미지 클릭시 처음페이지로
          갑니다</small>
        <hr>
        <li><a href="<c:url value='/information' />">피규어빌리지란?</a></li>
        <li><a href="#">상품검색</a></li>
        <li><a href="${pageContext.request.contextPath}/nboard/list">공지사항</a></li>
        <li><a href="${pageContext.request.contextPath}/board/list">자유게시판</a></li>
        <li><a href="${pageContext.request.contextPath}/aboard/list">후기게시판</a></li>
        </ul>
      </nav>
      <a href="" class="tab"><span>tab</span><i class="fas fa-bars fa-2x"></i></a>
    </header>
  </div>
   <div class="logo"><a href="<c:url value='/' />"><img src="<c:url value='/resources/img/logo1.jpg' />" width="150px" height="150px" alt="logo" title="피규어빌리지 홈으로"></a> </div>
  <!-- 반응형 메뉴바 끝-->


  <div class="log-menu">
    <li>
    <c:if test="${empty member }" >
      <a href="<c:url value='/loginForm' />">로그인</a> | 
      <a href="<c:url value='/' />">홈으로</a> |
    	<a href="<c:url value='/member/joinForm' />">회원가입</a> 
  </li>
  </c:if>
   <c:if test="${!empty member && sessionScope.member.admin == 0 }">
   <li>
      <a href="${pageContext.request.contextPath}/logout">로그아웃</a> | 
      <a href="${pageContext.request.contextPath}/member/outForm">회원탈퇴</a> |
    	 <a href="<c:url value='/member/modifyForm/${sessionScope.member.id }' />">${member.nickname }님</a> 
  </li>
  </c:if>
   <c:if test="${sessionScope.member.admin > 0}">
   <li>
      <a href="${pageContext.request.contextPath}/logout">로그아웃</a> | 
      <a href="${pageContext.request.contextPath}/member/outForm">회원탈퇴</a> |
    	 <a href="<c:url value='/member/modifyForm/${sessionScope.member.id }' />">${member.nickname }님</a> |
      <a href="${pageContext.request.contextPath}/admin/memberList">회원관리</a>
  </li>
  </c:if>
  </div>
</body>
</html>