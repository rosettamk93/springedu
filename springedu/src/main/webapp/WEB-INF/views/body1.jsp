<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-1/css/all.min.css" />
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Stylish&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="<c:url value= '/resources/css/main.css' />">
<script src="<c:url value ='/resources/js/main.js'/>"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.8.2.js"></script>
<script type="text/javascript">
	function scroll_follow(id) {
		$(window).scroll(function() //스크롤이 움직일때마다 이벤트 발생
		{
			var position = $(window).scrollTop(); // 현재 스크롤바의 위치값을 반환합니다.
			$(id).stop().animate({
				top : position + "px"
			}, 850); //해당 오브젝트 위치값 재설정
		});
	}
	scroll_follow("#scroll");
	//스크롤이 생기도록 <br> 을 여러게 넣은 부분..
	$(document).ready(function() {
		for (var i = 0; i < 200; i++) {
			$('#brr').html($('#brr').html() + "<br>" + i);
		}
	});
</script>
<body>


<div class="login-box">
    <div class="dim"></div>
    <div  id="scroll">
      <div class="sd0"> MENU </div>
      <div class="sd1"><a href="<c:url value='/' />"><i class="fas fa-angle-double-up"></i><br>맨위로</a></div>
      <div class="sd2"><a href="#"><i class="fas fa-search"></i><br>상품검색</a></div>
      <div class="sd3"><a href="${pageContext.request.contextPath}/board/list"><i class="far fa-comments"></i><br>자유게시판</a></div>
      <div class="sd4"><a href="${pageContext.request.contextPath}/aboard/list"><i class="fas fa-users"></i></i><br>후기게시판</a></div>
      <div class="sd5"><a href="${pageContext.request.contextPath}/nboard/list"><i class="fas fa-check-double"></i><br>공지사항</a></div>
      
    </div>
    <div class="mobile-board"><h2 style="color: brown;">피규어빌리지란?</h2>
    <div class="instead-text">가로 1132px 이하의 화면에서는 이미지 슬라이드를 제공하지 않습니다.</div>
    </div>
  <div class="board1">
    <div class="board1-1">
      <ul class="slides">
        <input type="radio" name="radio-btn" id="img-1" checked />
        <li class="slide-container">
          <div class="slide"> <a href="#"><img src="<c:url value='/resources/img/harley2.jpg' />" ></a> </div>
          
          <div class="nav">
            <label for="img-10" class="prev">&#x2039;</label>
            <label for="img-2" class="next">&#x203a;</label>
          </div>
        </li>
          <input type="radio" name="radio-btn" id="img-2" />
        <li class="slide-container">
          <div class="slide"> <a href="#"><img src="<c:url value='/resources/img/mk50.jpg' />" ></a> </div>
          <div class="nav">
            <label for="img-1" class="prev">&#x2039;</label>
            <label for="img-3" class="next">&#x203a;</label>
          </div>
        </li>
          <input type="radio" name="radio-btn" id="img-3" />
        <li class="slide-container">
          <div class="slide"> <a href="#"><img src="<c:url value='/resources/img/supervsbet.jpg' />" ></a> </div>
          <div class="nav">
            <label for="img-2" class="prev">&#x2039;</label>
            <label for="img-4" class="next">&#x203a;</label>
          </div>
        </li>
        <input type="radio" name="radio-btn" id="img-4" />
        <li class="slide-container">
          <div class="slide"> <a href="#"><img src="<c:url value='/resources/img/EVA00.jpg' />" ></a> </div>
          <div class="nav">
            <label for="img-3" class="prev">&#x2039;</label>
            <label for="img-5" class="next">&#x203a;</label>
          </div>
        </li>
        <input type="radio" name="radio-btn" id="img-5" />
        <li class="slide-container">
          <div class="slide"> <a href="#"><img src="<c:url value='/resources/img/thanos.jpg' />" ></a> </div>
          
          <div class="nav">
            <label for="img-4" class="prev">&#x2039;</label>
            <label for="img-6" class="next">&#x203a;</label>
          </div>
        </li>
        <input type="radio" name="radio-btn" id="img-6" />
        <li class="slide-container">         
          <div class="slide"> <a href="#"><img src="<c:url value='/resources/img/prime.jpg' />" ></a> </div>
          <div class="nav">
            <label for="img-5" class="prev">&#x2039;</label>
            <label for="img-7" class="next">&#x203a;</label>
          </div>
        </li>
        <input type="radio" name="radio-btn" id="img-7" />
        <li class="slide-container">         
        <div class="slide"> <a href="#"><img src="<c:url value='/resources/img/imironman.jpg' />" ></a> </div>
          <div class="nav">
            <label for="img-6" class="prev">&#x2039;</label>
            <label for="img-8" class="next">&#x203a;</label>
          </div>
        </li>
        <input type="radio" name="radio-btn" id="img-8" />
        <li class="slide-container">         
        <div class="slide"> <a href="#"><img src="<c:url value='/resources/img/mariya.jpg' />" ></a> </div>
          <div class="nav">
            <label for="img-7" class="prev">&#x2039;</label>
            <label for="img-9" class="next">&#x203a;</label>
          </div>
        </li>
        <input type="radio" name="radio-btn" id="img-9" />
        <li class="slide-container">         
        <div class="slide"> <a href="#"><img src="<c:url value='/resources/img/darknightjk.jpg' />" ></a> </div>
          <div class="nav">
            <label for="img-8" class="prev">&#x2039;</label>
            <label for="img-10" class="next">&#x203a;</label>
          </div>
        </li>
        <input type="radio" name="radio-btn" id="img-10" />
        <li class="slide-container">         
        <div class="slide"> <a href="#"><img src="<c:url value='/resources/img/aquamen.jpg' />" ></a> </div>
          <div class="nav">
            <label for="img-9" class="prev">&#x2039;</label>
            <label for="img-1" class="next">&#x203a;</label>
          </div>
        </li>
        <li class="nav-dots">
          <label for="img-1" class="nav-dot" id="img-dot-1"></label>
          <label for="img-2" class="nav-dot" id="img-dot-2"></label>
          <label for="img-3" class="nav-dot" id="img-dot-3"></label>
          <label for="img-4" class="nav-dot" id="img-dot-4"></label>
          <label for="img-5" class="nav-dot" id="img-dot-5"></label>
          <label for="img-6" class="nav-dot" id="img-dot-6"></label>
          <label for="img-7" class="nav-dot" id="img-dot-7"></label>
          <label for="img-8" class="nav-dot" id="img-dot-8"></label>
          <label for="img-9" class="nav-dot" id="img-dot-9"></label>
          <label for="img-10" class="nav-dot" id="img-dot-10"></label>
        </li>
      </ul>
    </div>
  </div>
  </div>
<div class="abstract"></div> 

<!-- 인기상품 박스-->
	<div class="login-box2">
		<div class="board2">
			<div class="board2-1">
				<div class="hotpic-title">
					<h2>신규제품</h2>
				</div>
				<p>*하단 이미지를 클릭하면 상품으로 이동합니다.</p>
				<div class="board2-2">
					<a href="#"><img
						src="<c:url value='/resources/img/mysterio.jpg' />" width="255px"
						height="230px" alt=""></a> <a href="#"><img
						src="<c:url value='/resources/img/joker.jpg' />" width="255px"
						height="230px" alt=""></a> <a href="#"><img
						src="<c:url value='/resources/img/resqueam.jpg' />" width="255px"
						height="230px" alt=""></a> <a href="#"><img
						src="<c:url value='/resources/img/spiderman.jpg' />" width="255px"
						height="230px" alt=""></a>
				</div>
				<div class="board2-3">
					<a href="#"><img
						src="<c:url value='/resources/img/thor.jpg' />" width="255px"
						height="230px" alt=""></a> <a href="#"><img
						src="<c:url value='/resources/img/widow.jpg' />" width="255px"
						height="230px" alt=""></a> <a href="#"><img
						src="<c:url value='/resources/img/whitebeard.jpg' />"
						width="255px" height="230px" alt=""></a> <a href="#"><img
						src="<c:url value='/resources/img/rey.jpg' />" width="255px"
						height="230px" alt=""></a>
				</div>
				<div class="board2-4">
					<a href="#"><img
						src="<c:url value='/resources/img/shockwave.jpg' />" width="255px"
						height="230px" alt=""></a> <a href="#"><img
						src="<c:url value='/resources/img/sabo.jpg' />" width="255px"
						height="230px" alt=""></a> <a href="#"><img
						src="<c:url value='/resources/img/benner.jpg' />" width="255px"
						height="230px" alt=""></a> <a href="#"><img
						src="<c:url value='/resources/img/saitama.jpg' />" width="255px"
						height="230px" alt=""></a>
				</div>
			</div>
		</div>
	</div>

	<div class="login-box3">
		<div class="board3">
			<div class="board3-1">
				<div class="hotpic-title">
					<h2>인기상품</h2>
				</div>
				<p>* 하단이미지 클릭시 상품으로 이동</p>
				<div class="board3-1">
					<a href="#"><img
						src="<c:url value='/resources/img/betgirl.jpg' />" width="255px"
						height="230px" alt=""></a> <a href="#"><img
						src="<c:url value='/resources/img/burst.jpg' />" width="255px"
						height="230px" alt=""></a> <a href="#"><img
						src="<c:url value='/resources/img/captain.jpg' />" width="255px"
						height="230px" alt=""></a> <a href="#"><img
						src="<c:url value='/resources/img/elsa.jpg' />" width="255px"
						height="230px" alt=""></a>
				</div>
				<div class="board3-2">
					<a href="#"><img
						src="<c:url value='/resources/img/arska.jpg' />" width="255px"
						height="230px" alt=""></a> <a href="#"><img
						src="<c:url value='/resources/img/bee.jpg' />" width="255px"
						height="230px" alt=""></a> <a href="#"><img
						src="<c:url value='/resources/img/goku.jpg' />" width="255px"
						height="230px" alt=""></a> <a href="#"><img
						src="<c:url value='/resources/img/incredible.jpg' />"
						width="255px" height="230px" alt=""></a>
				</div>
			</div>
			<div class="board3-2">
				<div class="new-title">
					<h2>예약상품</h2>
				</div>
				<p>* 하단이미지 클릭시 상품으로 이동</p>
				<div class="board4-1">
					<a href="#"><img
						src="<c:url value='/resources/img/EVA02.jpg' />" width="255px"
						height="230px" alt=""></a> <a href="#"><img
						src="<c:url value='/resources/img/mk7.jpg' />" width="255px"
						height="230px" alt=""></a> <a href="#"><img
						src="<c:url value='/resources/img/queen.jpg' />" width="255px"
						height="230px" alt=""></a> <a href="#"><img
						src="<c:url value='/resources/img/trex.jpg' />" width="255px"
						height="230px" alt=""></a>
				</div>
				<div class="board4-2">
					<a href="#"><img
						src="<c:url value='/resources/img/vampie.jpg' />" width="255px"
						height="230px" alt=""></a> <a href="#"><img
						src="<c:url value='/resources/img/centinel.jpg' />" width="255px"
						height="230px" alt=""></a> <a href="#"><img
						src="<c:url value='/resources/img/berserg.jpg' />" width="255px"
						height="230px" alt=""></a> <a href="#"><img
						src="<c:url value='/resources/img/deadpool.jpg' />" width="255px"
						height="230px" alt=""></a>
				</div>
			</div>
		</div>
	</div>


</body>
</html>