<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>대댓글</title>
  <style>
/*     * { outline: 1px solid red;	} */
    /* 공통 */
    .lm-1{ margin-left: 10px; } .lm-2{ margin-left: 20px; } .lm-3{ margin-left: 30px; } .lm-4{ margin-left: 40px; } .lm-5{ margin-left: 50px; }
    .lm-6{ margin-left: 60px; } .lm-7{ margin-left: 70px; } .lm-8{ margin-left: 80px; } .lm-9{ margin-left: 90px; } .lm-10{ margin-left: 100px; }
  
    .fw-1{min-width:10px;} .fw-2{min-width:20px;} .fw-3{min-width:30px;} .fw-4{min-width:40px;} .fw-5{min-width:50px;}
    .fw-6{min-width:60px;} .fw-7{min-width:70px;} .fw-8{min-width:80px;} .fw-9{min-width:90px;} .fw-10{min-width:130px;}
    
    .pw-1{width:10%;} .pw-2{width:20%;} .pw-3{width:30%;} .pw-4{width:40%;} .pw-5{width:50%;}
    .pw-6{width:60%;} .pw-7{width:70%;} .pw-8{width:80%;} .pw-9{width:90%;} .pw-10{width:100%;}

    #reply .row, 
    #replyList .row { display:flex; }

    /* 댓글작성 */
    #reply{
      margin-top:20px; width:100%;
    }
    #reply .row{ display:flex; }    
    #reply #rcontent{ width:100%; }
    #reply #replyBtn1{ width:80px; }
      
    /* 댓글 목록 */  
    #replyList{
      margin-top:20px; width:100%;
    }
    #replyList .row { display:flex; }    
    #replyList .row.header .col:nth-child(4){
      display:flex;
      justify-content: flex-end;
    }
    /* 페이징 */
    #paging {
      margin-top:20px;
      display:flex;
      justify-content: center;
    }
    #paging .active{
    background-color: whitesmoke;}
    span {font-size: 0.75em;}
  </style>  
	<script>
		window.addEventListener("load",init2,false);
		let l_bnum = 2062;		//게시 원글번호
		let l_page = 1;				//요청페이지
		let l_id = "${sessionScope.member.id}";	//로그인 아이디
		let l_nickname = "${sessionScope.member.nickname}";	//로그인 별칭
		let l_url = "${pageContext.request.contextPath}/rboard"; //공통 URL
		
		function init2(){

			//댓글목록 가져오기
			replyList(l_page);  

			//페이지번호 클릭시 이벤트 처리
			paging.addEventListener("click",function(e){
				e.preventDefault();
 				if(e.target.tagName == 'A'){
 	 				l_page = e.target.getAttribute("href");
					replyList(l_page);
				} 
			},false);

			//댓글작성
			replyBtn1.addEventListener("click",function(){
				//console.log("댓글작성버튼 클릭됨!");
				let rcontent = document.getElementById("rcontent").value;
				
				let xhttp = new XMLHttpRequest();
				xhttp.addEventListener("readystatechange",function(){
					if(this.readyState == 4 && this.status == 200){
						console.log(this.responseText);
						if(this.responseText == 'success'){
							replyList(l_page);
						}else{
							console.log('댓글작성오류!!');
						}
					}
				});

			 //전송데이터 json포맷으로 만들기
	     let sendData = {};
	     sendData.bnum  = l_bnum;
	     sendData.rid 	= l_id;
	     sendData.rnickname = l_nickname;
	     sendData.rcontent = rcontent;
	     
	     //자바스크립트 obj => json포맷 문자열 변환
	     let result = JSON.stringify(sendData);
	     //console.log(result);
		     				
	     //post방식
	     xhttp.open("POST",l_url,true);
	     xhttp.setRequestHeader("Content-Type","application/json;charset=utf-8"); 
	     xhttp.send(result);				
				
			},false);
		}

		//댓글목록 가져오기
		function replyList(reqPage){
			let url = l_url+"/"+l_page+"/"+l_bnum;
					
			//Ajax Call
			//1)
			let xhttp = new XMLHttpRequest();
			//2)
			xhttp.addEventListener("readystatechange",function(){
				if(this.readyState == 4 && this.status == 200){
					console.log(this.responseText);
					let jsObj = JSON.parse(this.responseText);
					let str = "";
					jsObj.list.forEach( e => {
/* 						console.log("rnum="+e.rnum);
						console.log("rid="+e.rid);
						console.log("rnickname="+e.rnickname); */

						str += '<div class="row pw-10">';
						if(e.rindent == 0){
							str += '  <div class="row pw-10">';
						}else{
							str += '  <div class="row pw-10 lm-7">';
						}
						str += '    <div class="col fw-7"><img src="" alt="사진" /></div>';
						str += '    <div class="col pw-10">';
						str += '      <div class="row header pw-10">';
						str += '        <div class="col ">'+e.rnickname+'('+e.rid+')'+'</div>';
						str += '        <div class="col fw-10"><small><i>'+e.rcdate+'</i></small></div>';
						str += '        <div class="col fw-5"><span><a href="#" class="rereplyBtn" data-rnum="">댓글버튼</a></span></div>';
						str += '        <div class="col pw-10">';
						str += '          <div class="row">';
						str += '            <div class="col fw-5"><span><a href="#" class="replyModifyBtn" data-rnum="">수정버튼</a></span></div>	';
						str += '            <div class="col fw-5"><span><a href="#" class="replyDeleteBtn" data-rnum="">삭제버튼</a></span></div>';
						str += '          </div>';
						str += '        </div>';
						str += '      </div>';
						str += '      <div class="row body">';
						str += '        <div class="col fw-5">부모댓글작성자</div>';
						str += '        <div class="col">'+e.rcontent+'</div>';
						str += '      </div>';
						str += '      <div class="row bottom">';
						str += '        <div class="col fw-10"><span><a href="#" class="goodBtn" data-rnum="">선호</a></span>('+e.good+')</div>';
						str += '        <div class="col fw-10"><span><a href="#" class="badBtn" data-rnum="">비선호</a></span>('+e.bad+')</div>';
						str += '      </div>';
						str += '    </div>';
						str += '  </div>';
						str += '</div>';					

						document.getElementById('replyList').innerHTML = str;

					});//jsObj.list.forEach 
					
					//페이지징
					//이전페이지 여부
					str = "";
					if(jsObj.pc.prev){
						str += '<a href="1">◀</a>';
					  str += '<a href="'+(jsObj.pc.startPage-1)+'">◁</a>';
					}
					//페이지 1~10
					for(let i=jsObj.pc.startPage, end=jsObj.pc.endPage; i<=end; i++){
						//현재 페이지와 요청페이지가 다르면
						if(jsObj.pc.rc.reqPage != i ){
							str += '<a href="'+i+'">'+i+'</a>';
						}else{
							str += '<a href="'+i+'" class="active">'+i+'</a>';
						}
					}

					//다음페이지 여부
					if(jsObj.pc.next){
				    str += '<a href="'+(jsObj.pc.endPage+1)+'">▷</a>';
				    str += '<a href="'+(jsObj.pc.finalEndPage)+'">▶</a>';
					}		
					document.getElementById('paging').innerHTML = str;		
				}
		  },false);
			//3)
			xhttp.open("GET",url,true);
			xhttp.send();
		}
	</script>
</head>
<body>
  <!-- 댓글 달기 -->
  <div id="reply">
    <div class="row">
      <textarea name="rcontent" id="rcontent" rows="3"></textarea>
      <button id="replyBtn1">등록</button>
    </div>
  </div>
  
  <!-- 댓글 목록-->
  <div id="replyList">
  	<!-- 원글의 댓글 양식-->
    <div class="row pw-10">
      <div class="row pw-10">
        <div class="col fw-7"><img src="" alt="사진" /></div>
        <div class="col pw-10">
          <div class="row header pw-10">
            <div class="col fw-10">댓글작성자</div>
            <div class="col fw-10"><small><i>댓글작성일시</i></small></div>
            <div class="col fw-5"><span><a href="#" class="rereplyBtn" data-rnum="">댓글버튼</a></span></div>
            <div class="col pw-10">
  						<div class="row">
                <div class="col fw-5"><span><a href="#" class="replyModifyBtn" data-rnum="">수정버튼</a></span></div>	
                <div class="col fw-5"><span><a href="#" class="replyDeleteBtn" data-rnum="">삭제버튼</a></span></div>
  						</div>					
            </div>
          </div>
          <div class="row body">		
            <div class="col fw-5">부모댓글작성자</div>            
            <div class="col">댓글내용</div>
          </div>
          <div class="row bottom">
            <div class="col fw-10"><span><a href="#" class="goodBtn" data-rnum="">선호</a></span>(3)</div>
            <div class="col fw-10"><span><a href="#" class="badBtn" data-rnum="">비선호</a></span>(1)</div>
          </div>
        </div>
      </div>
    </div>
    <!-- 대댓글 양식 -->
    <div class="row pw-10" data-rnum="">
      <div class="row pw-10 lm-7">
        <div class="col fw-7"><img src="" alt="사진" /></div>
        <div class="col pw-10">
          <div class="row header pw-10">
            <div class="col fw-10">댓글작성자</div>
            <div class="col fw-10"><small><i>댓글작성일시</i></small></div>
            <div class="col fw-5"><span><a href="#" class="rereplyBtn" data-rnum="">댓글버튼</a></span></div>
            <div class="col pw-10">
  						<div class="row">
                <div class="col fw-5"><span><a href="#" class="replyModifyBtn" data-rnum="">수정버튼</a></span></div>	
                <div class="col fw-5"><span><a href="#" class="replyDeleteBtn" data-rnum="">삭제버튼</a></span></div>
  						</div>					
            </div>
          </div>
          <div class="row body">		
            <div class="col fw-5">부모댓글작성자</div>            
            <div class="col">댓글내용</div>
          </div>
          <div class="row bottom">
            <div class="col fw-10"><span><a href="#" class="goodBtn" data-rnum="">선호</a></span>(3)</div>
            <div class="col fw-10"><span><a href="#" class="badBtn" data-rnum="">비선호</a></span>(1)</div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--페이징-->
  <div id="paging">
    <a href="#">첫페이지</a>
    <a href="#">이전페이지</a>
    <a href="#">1</a>
    <a href="#">2</a>
    <a href="#">3</a>
    <a href="#">4</a>
    <a href="#">5</a>
    <a href="#">6</a>
    <a href="#">7</a>
    <a href="#">8</a>
    <a href="#">9</a>
    <a href="#">10</a>
    <a href="#">다음페이지</a>
    <a href="#">끝페이지</a>
  </div>
</body>
</html>