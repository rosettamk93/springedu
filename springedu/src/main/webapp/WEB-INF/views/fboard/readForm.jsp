<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${foardVO.ftitle}</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-1/css/all.min.css" />  
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Stylish&display=swap" rel="stylesheet">
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.8.2.js"></script>
    
<!-- <script src="jquery.bxslider/jquery.bxslider.js"></script> -->

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
  


  </script> 
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
				location.href = getContextPath()+"/fboard/replyForm/"+returnPage+"/"+bnum;
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
					location.href = getContextPath()+"/fboard/delete/"+returnPage+"/"+bnum;
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
			document.getElementById('fboardVO').submit();
			
		},false);      

  //목록
		listBtn.addEventListener("click",function(e){
			e.preventDefault();
			console.log("목록");
				let returnPage = e.target.getAttribute('data-returnPage');
			location.href=getContextPath()+"/fboard/list/"+returnPage;
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
			  xhttp.open("DELETE","http://localhost:9080/portfolio/fboard/file/"+fid,true);
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
			document.getElementById("btitle").setAttribute("readOnly",true);
			document.getElementById("bcontent").setAttribute("readOnly",true);	
			//읽기모드버튼 활성화				
			Array.from(rmodes).forEach(e=>{e.style.display="block";});
			Array.from(umodes).forEach(e=>{e.style.display="none";});
		}
	}
  </script>
<style>
    *{font-family: Stylish, "Open Sans", sans-serif;}
    /* *{outline: 1px solid;} */
    a{text-decoration: none; color:#000;}
    .w-cont{width: 100%; display: flex; justify-content: center;}
    h2{text-align: center;}
    .container{display: flex; justify-content: center;}
    .item-info{padding-left: 5px;}
    .item-title{width: 100%; height: 60px; text-align: center; font-size: 1.25em; font-weight: 900; }
    .small{font-size: 0.75em; font-weight: 900;}
    #color-blue{color: blue; font-weight: 900;}
    #color-red{color: red;}
    .table1{width: 100%; height: 100px; text-align: right;}
    .table1 td{text-align: center;}
    .table2{width: 100%; height: 124px; text-align: center;}
    .selection{text-align: center; font-size: 0.85em;}
    .btns{display: flex;}
    button{width: 50%; height: 30%; font-size: 1.25em;}
    #buynowBtn{width: 50%; height: 55px; background-color: black; color: white;}
    #pocketBtn{width: 50%; height: 55px; background-color: whitesmoke; color: black;}
    .info-list{width: 100%; height: 150px; display : flex; justify-content: center; text-align: center;}
    .content{width: 100%; height: 100%;}
    .content img{width: 48%; height: 100%;}
    
    @media only screen and (max-width:790px) {
        .container{display: inline-block;}
        .table2{height: 10px;}
        .content img{width: 85%;}
      }
      @media only screen and (max-width:1080px) {
          #scroll{display: none;}
      }
      #scroll{width: 80px; height: 300px;  text-align: center; background-color: whitesmoke; border-radius: 10px; }
   .sd0 {background-color: black; color: white; padding:0;}
   
   .sd1, .sd2, .sd3, .sd4{padding-top: 15px; padding-bottom: 15px; color: black;}
   
   .sd1 a, .sd2 a, .sd3 a, .sd4 a{background-color: whitesmoke;}
   
   .sd1 a, .sd2 a, .sd3 a, .sd4 a:hover{color: black;}
   a:hover{font-weight: 900;}
   #scroll{ position: relative;left:110px; }
      .photo{width: 100%; height: 100%; text-align: center;}
      .other-items{width: 100%; height: 500px; outline: 1px solid red; }  
      img{border:0px;}   
</style>
</head>

<body>
  <div class="w-cont">
        <div class="w-wrap">
            <h2 id="title">상품 세부정보</h2><hr>
         <div class="container">
         <%-- <form:form action="#{pageContext.request.contextPath }/fboad/modify/${returnPage }"
        					enctype="multipart/form-data"
					    					 method="post"
					    					 modelAttribute="fboardVO"> --%>
					    					 <%-- <form:hidden path="fnum"/> --%>
        <div><img src="practice/img/harley2.jpg" width="400px" height="400px" alt=""></div>
        <div class="item-info">
            <div class="item-title">[입고예정] 수어사이드 스쿼드 - 할리퀸 1/3 스테츄 <br><div class="small">Suicide Squad - Harley Quinn 1/3 Statue</div></div>
            <table class="table1">
            <tr>
                <th>제조사
                    <td>PRIME1 STUDIO</td>
                </th>
            </tr>
            <tr id="color-blue">
                <th>판매가
                    <td>1,111,000원</td>
                </th>
            </tr>
            <tr id="color-red">
                <th>제품번호
                    <td>MMSS-01</td>
                </th>
            </tr>
        </table>
        <hr>
        <div class="selection">[입고예정] 수어사이드 스쿼드 - 할리퀸 1/3 스테츄

           <div>
               주문수량 <select name="1" id="">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                </select>
           </div>
           
        </div>
        <table class="table2">
            <th>결제금액
                <td>1,111,000원</td>
            </th>
        </table>
        <div class="btns">
            <button id="buynowBtn">바 로 구 매</button>
            <button id="pocketBtn">장 바 구 니</button>
        </div> <div class="abstrbox"></div><hr>
        </div>
        
        
        
        <div  id="scroll">
            <div class="sd0"> MENU </div>
            <div class="sd1"><a href="#"><i class="fas fa-angle-double-up"></i><br>맨위로</a></div>
            <div class="sd2"><a href="#"><i class="fas fa-search"></i><br>상품검색</a></div>
            <div class="sd4"><a href="#"><i class="fas fa-list"></i><br>목록으로</a></div>
            <div class="sd3"><a href="#footer"><i class="fas fa-shopping-cart"></i><br>맨아래로</a></div>
          </div>
          
          
          
         </div>
        </div>
    </div>
    <hr>
    <div class="info-list">
        <table class="table3">
            <tr>
                <th>제품명
                    <td colspan="5">수어사이드 스쿼드 할리퀸(일반판)</td>
                </th>
            </tr>
            <tr>
                <th>출시예정
                    <td colspan="5">2018년 1분기</td>
                </th>
            </tr>
            <tr>
                <th>제조사
                    <td colspan="5">PRIME1 STUDIO</td>
                </th>
            </tr>
            <tr id="item-size">
                <th>높이
                   <td>710mm</td>
                </th>
                <th>길이
                   <td>350mm</td>
                </th>
                <th>폭
                   <td>385mm</td>
                </th>
            </tr>
            <tr>
                <th>무게
                    <td colspan="5">미정</td>
                </th>
            </tr>
        </table>
    </div>
    <%-- </form:form> --%>
    <div class="photo">
<div class="content">
    <div class="imgbox"> <img src="practice/img/harley2.jpg" alt=""> </div>
    <div class="imgbox"> <img src="practice/img/harley2.jpg" alt=""> </div>
    <div class="imgbox"> <img src="practice/img/harley2.jpg" alt=""> </div>
    <div class="imgbox"> <img src="practice/img/harley2.jpg" alt=""> </div>
    <div class="imgbox"> <img src="practice/img/harley2.jpg" alt=""> </div>
    <div class="imgbox"> <img src="practice/img/harley2.jpg" alt=""> </div>
</div>
</div>
<div class="other-items">관련상품</div>
</body>
</html>