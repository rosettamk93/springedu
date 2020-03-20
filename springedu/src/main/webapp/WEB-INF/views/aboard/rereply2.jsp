<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>대댓글</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-1/css/all.min.css" />
  <style>
/*     * { outline: 1px solid red;	} */
    /* 공통 */
    .lm-1{ margin-left: 10px; } .lm-2{ margin-left: 20px; } .lm-3{ margin-left: 30px; } .lm-4{ margin-left: 40px; } .lm-5{ margin-left: 50px; }
    .lm-6{ margin-left: 60px; } .lm-7{ margin-left: 70px; } .lm-8{ margin-left: 80px; } .lm-9{ margin-left: 90px; } .lm-10{ margin-left: 100px; }
    
    .rm-1{ margin-right: 10px; color: blue;} .rm-2{ margin-right: 20px; } .rm-3{ margin-right: 30px; } .rm-4{ margin-right: 40px; } .rm-5{ margin-right: 50px; }
    .rm-6{ margin-right: 60px; } .rm-7{ margin-right: 70px; } .rm-8{ margin-right: 80px; } .rm-9{ margin-right: 90px; } .rm-10{ margin-right: 100px; }
  
    .fw-1{min-width:10px;} .fw-2{min-width:20px;} .fw-3{min-width:30px;} .fw-4{min-width:40px;} .fw-5{min-width:50px;}
    .fw-6{min-width:60px;} ./* fw-7{min-width:70px;} */ .fw-8{min-width:80px;} .fw-9{min-width:90px;} .fw-10{min-width:100px;}
    .fw-15{min-width:150px;}
    
    .pw-1{width:10%;} .pw-2{width:20%;} .pw-3{width:30%;} .pw-4{width:40%;} .pw-5{width:50%;}
    .pw-6{width:60%;} .pw-7{width:70%;} .pw-8{width:80%;} .pw-9{width:90%;} .pw-10{width:100%;}

		#replyArea { width:600px; margin:0 auto; padding:10px;}

    #reply .row, 
    #areplyList .row { display:flex; }

    /* 댓글작성 */
    #reply{
      margin-top:20px; width:100%;
    }
    #reply .row{ display:flex; }    
    #reply #arcontent{ width:100%; }
    #reply #replyBtn2{ width:80px; }
    
    /* 대댓글 작성*/
    #areplyList .row.rreply{display:flex;}
    #areplyList .row.rreply .arrcontent{width:100%; border:1px solid #ccc;}
    #areplyList .row.rreply .rreplyBtn{width:80px;}
    /* 대댓글 수정*/
    #areplyList .row.rreplyModify{display:flex;}
    #areplyList .row.rreplyModify .arrcontent{width:100%; border:1px solid #ccc;}
    #areplyList .row.rreplyModify .rreplyModifyBtn{width:80px;}
      
    /* 댓글 목록 */  
    #areplyList{
      margin-top:20px; width:100%;
    }
    #areplyList .row { display:flex; }    
    #areplyList .row.header .col:nth-child(4){
      display:flex;
      justify-content: flex-end;
    }
    #areplyList .row.header div {
    	padding: 1px 3px;
    }
    /* 페이징 */
    #paging {
      margin-top:20px;
      display:flex;
      justify-content: center;
    }
    #paging a {
    	padding:2px;
    	margin:2px;
    }
    #paging .active{
    	background-color: whitesmoke;
    }
    
    /* fontawesome 아이콘  색지정 */
    .fa-reply{color:Tomato;}
    .fa-edit{color:green;}
    .fa-trash-alt{color:salmon;}
    .fa-thumbs-up{color:rgb(59, 91, 152);}
    .fa-thumbs-down{color:rgb(59, 91, 152);  line-height: 23px;}
    #talkimg{width:20px; height: 20px;}
    
    .row.body {
    background-color: whitesmoke;
    height: 50px;
}
  </style>  
	<script>
		window.addEventListener("load",init2,false);
		//let l_bnum = 2068;		//게시 원글번호
		let l_abnum = ${aboardVO.abnum }
		let l_page = 1;				//요청페이지
		let l_abid 				= "${sessionScope.member.id}";									//로그인 아이디
		let l_abnickname 	= "${sessionScope.member.nickname}";						//로그인 별칭
		let l_url 			= "${pageContext.request.contextPath}/arboard"; 	//공통 URL

		const GOOD = '1', BAD = '2'; //호감'1', 비호감'2'

		// 대댓글 작성 html코드 시작--------------------------------
		let rereply_str = "";
		rereply_str = '<div class="row">';
		rereply_str = '<textarea name="arcontent" id="arcontent" rows="3"></textarea>';
		rereply_str = '<button id="rereplyBtn2">등록</button>';
		rereply_str = '</div>';
		// 대댓글 작성 html코드 끝----------------------------------
		
		function init2(){

			//댓글목록 가져오기
			areplyList(l_page);  

 			//페이지번호 클릭시 이벤트 처리
			paging.addEventListener("click",function(e){
				e.preventDefault();
 				if(e.target.tagName == 'A'){
 	 				console.log("페이지 클릭됨!!");
 	 				l_page = e.target.getAttribute("href");
					areplyList(l_page);
				} 
			},false);

			//댓글작성
			replyBtn2.addEventListener("click",function(){
				//console.log("댓글작성버튼 클릭됨!");
				let arcontentTag = document.getElementById("arcontent")
				let arcontent = arcontentTag.value;
				
				let xhttp = new XMLHttpRequest();
				xhttp.addEventListener("readystatechange",function(){
					if(this.readyState == 4 && this.status == 200){
						console.log(this.responseText);
						if(this.responseText == 'success'){
							areplyList(l_page);
							arcontentTag.value = "";
							arcontentTag.focus();
						}else{
							console.log('댓글작성오류!!');
						}
					}
				});

			 //전송데이터 json포맷으로 만들기
	     let sendData = {};
	     //arbnum ?? or abnum??
	     sendData.arbnum  = l_abnum;
	     sendData.arid 	= l_abid;
	     sendData.arnickname = l_abnickname;
	     sendData.arcontent = arcontent;
	     
	     //자바스크립트 obj => json포맷 문자열 변환
	     let result = JSON.stringify(sendData);
	     console.log(result);
		     				
	     //post방식
	     xhttp.open("POST",l_url,true);
	     xhttp.setRequestHeader("Content-Type","application/json;charset=utf-8"); 
	     xhttp.send(result);				
				
			},false);
			let areplyListTag = document.getElementById("areplyList");
			areplyListTag.addEventListener("click",function(e){
				//댓글목록에서 'I'태그의 자식 태그에서만 반응하기
				if(e.target.tagName != 'I') return false;
				//이벤트가 일어난 지점에서 data-rnum속성을 포함한 요소를 찾아서 data-rnum값을 추출한다.
				let parentTags = parents(e.target);
				let arnumTag    = parentTags.find( tag => {	if(tag.hasAttribute("data-arnum")){
														return tag;
													}});
				let data_arnum =	arnumTag.getAttribute("data-arnum");
				
				   
				if(e.target.classList.contains('replyDeleteBtn')){
					//console.log('삭제버튼 클릭됨'+data_rnum);
					if(confirm('삭제하시겠습니까?')){
						doDelete(e.target, data_arnum);
					}
				}else if(e.target.classList.contains('replyModifyBtn')){
					console.log('수정버튼 클릭됨'+data_arnum);

					doReplyModifyTrigger(areplyListTag,'rereplyCancelBtn');
					doReplyModifyTrigger(areplyListTag,'replyModifyCancelBtn');
						
					//1) 아이콘 토글
 					e.target.classList.toggle("replyModifyBtn");
					e.target.classList.toggle("fa-edit");

					e.target.classList.toggle("replyModifyCancelBtn");
					e.target.classList.toggle("fa-window-close");		 			
					//2) 대댓글수정양식을 대댓글 대상 아래 추가하기 
					console.log(arnumTag);
					console.log(arnumTag.nextElementSibling);
										
					let row_1 = elt("textarea",{name:"arrcontent", class:"arrcontent lm-7", rows:"3"});
					let row_2 = elt("button",{class:"rreplyModifyBtn"},"수정");							
					let rreplyModifyForm = elt("div",{class:"row rreplyModify"},row_1,row_2);
					 					
					row_2.addEventListener("click",function(){
						//대댓글 수정 처리하기
						doModify(data_arnum,row_1.value);
					},false);
					areplyListTag.insertBefore(rreplyModifyForm,arnumTag.nextElementSibling);
					areplyListTag.getElementsByClassName("arrcontent")[0].value
						= arnumTag.getElementsByClassName("arcontent")[0].textContent;					
				}else if(e.target.classList.contains('replyModifyCancelBtn')){
					console.log('수정버튼 취소 클릭됨'+data_arnum);

					//1)
					e.target.classList.toggle("replyModifyBtn");
					e.target.classList.toggle("fa-edit");

					e.target.classList.toggle("replyModifyCancelBtn");
					e.target.classList.toggle("fa-window-close");							
					//2) 대댓글입력양식을 제거하기 
					areplyListTag.removeChild(arnumTag.nextElementSibling);
					
				}else if(e.target.classList.contains('goodBtn2')){
					//console.log('호감버튼 클릭됨'+data_rnum);
					doGoodOrBad(e.target, data_arnum, GOOD);
				}else if(e.target.classList.contains('badBtn2')){
					//console.log('비호감버튼 클릭됨'+data_rnum);
					doGoodOrBad(e.target, data_arnum, BAD);
				}else if(e.target.classList.contains('rereplyBtn2')){
					console.log('댓글버튼 클릭됨'+data_arnum);
					doReplyModifyTrigger(areplyListTag,'rereplyCancelBtn');
					doReplyModifyTrigger(areplyListTag,'replyModifyCancelBtn');
					 
					//1) 아이콘 토글
 					e.target.classList.toggle("rereplyBtn2");
					e.target.classList.toggle("fa-reply");
					e.target.classList.toggle("rereplyCancelBtn");
					e.target.classList.toggle("fa-window-close");
							 			
					//2) 대댓글입력양식을 대댓글 대상 아래 추가하기 
					console.log(arnumTag);
					console.log(arnumTag.nextElementSibling);
					//rnumTag.nextElementSibling.innerHTML = rereply_str;					
					let row_1 = elt("textarea",{name:"arrcontent", class:"arrcontent lm-7", rows:"3"});
					let row_2 = elt("button",{class:"rreplyBtn"},"등록");							
					let rreplyForm = elt("div",{class:"row rreply"},row_1,row_2);
					 	
					row_2.addEventListener("click",function(){
						//대댓글 등록 처리하기
						doReply(data_arnum,row_1.value);
					},false);
					
					areplyListTag.insertBefore(rreplyForm,arnumTag.nextElementSibling);
					areplyListTag.getElementsByClassName("arrcontent")[0].placeholder
						= arnumTag.getElementsByClassName("arnickname")[0].textContent+"님께 답글쓰기";

				}else if(e.target.classList.contains('rereplyCancelBtn')){
	
					//1) 아이콘` 토글
					console.log('댓글버튼 클릭됨'+data_arnum);
					e.target.classList.toggle("rereplyBtn2");
					e.target.classList.toggle("fa-reply");

					e.target.classList.toggle("rereplyCancelBtn");
					e.target.classList.toggle("fa-window-close");					
					//2) 대댓글입력양식을 제거하기 
					areplyListTag.removeChild(arnumTag.nextElementSibling);
				}
			},false);
		}
		
		//이벤트 트리거
		function doReplyModifyTrigger(i_pnode,i_findClass){
			Array.from(i_pnode.getElementsByClassName(i_findClass))
			 .forEach(item=>{item.click()});
		}
		
		//댓글 수정
		function doModify(i_arnum,i_arcontent){

			let xhttp = new XMLHttpRequest();
			xhttp.addEventListener("readystatechange",function(){
				if(this.readyState == 4 && this.status == 200){
						console.log(this.responseText);
					if(this.responseText == 'success'){
						areplyList(l_page);
					}else{
						console.log('대댓글 수정 오류!!');
					}
				}
			});		
			let sendData = {};
			sendData.arnum = i_arnum; 						//수정할 댓글번호
			sendData.arcontent = i_arcontent;			//대댓글내용
			
			let result = JSON.stringify(sendData);
					
		  xhttp.open("PUT",l_url,true);
		  xhttp.setRequestHeader("Content-Type","application/json;charset=utf-8"); 
		  xhttp.send(result);			
		}
		//대댓글 등록
		function doReply(i_arnum,i_arcontent){

			let url = l_url+"/reply";
			let xhttp = new XMLHttpRequest();
			xhttp.addEventListener("readystatechange",function(){
				if(this.readyState == 4 && this.status == 200){
						console.log(this.responseText);
					if(this.responseText == 'success'){
						areplyList(l_page);
					}else{
						console.log('대댓글 작성 오류!!');
					}
				}
			});		
			let sendData = {};
			//arbnum? or abnum?
			sendData.arbnum = l_abnum; 						//게시글 원글
			sendData.arid  = l_abid;	 							//작성자
			sendData.arnickname = l_abnickname;		//별칭
			sendData.arcontent = i_arcontent;			//대댓글내용
			sendData.aprnum =	i_arnum;						//부모댓글 
			
			let result = JSON.stringify(sendData);
					
		  xhttp.open("POST",url,true);
		  xhttp.setRequestHeader("Content-Type","application/json;charset=utf-8"); 
		  xhttp.send(result);					
		}
		//댓글 삭제
		function doDelete(i_node, i_arnum){
			let url = l_url+"/"+i_arnum;
			let xhttp = new XMLHttpRequest();
			xhttp.addEventListener("readystatechange",function(){
				if(this.readyState == 4 && this.status == 200){
						console.log(this.responseText);
					if(this.responseText == 'success'){
						areplyList(l_page);
					}else{
						console.log('삭제오류!!');
					}
				}
			});			

     xhttp.open("DELETE",url,true); 
     xhttp.send();				
		}
		//호감,비호감
		function doGoodOrBad(i_node, i_arnum, i_avote){
			let url = l_url+"/avote";
			let xhttp = new XMLHttpRequest();
			xhttp.addEventListener("readystatechange",function(){
				if(this.readyState == 4 && this.status == 200){
						console.log(this.responseText);
					if(this.responseText == 'success'){
						areplyList(l_page);
					}else{
						console.log('호감,비호감 오류!!');
					}
				}
			});			
		 let sendData = {};
		 sendData.arnum = i_arnum; //댓글번호
		 sendData.arbnum = l_abnum; //게시글 원글
		 sendData.arid  = l_abid;	 //작성자
		 sendData.avote = i_avote; //호감,비호감	

		 let result = JSON.stringify(sendData);
		 		
     xhttp.open("PUT",url,true);
     xhttp.setRequestHeader("Content-Type","application/json;charset=utf-8"); 
     xhttp.send(result);				
		}

		/*-----------------------------------------------------------------------*
		 * 노드 생성 함수
		 * 주어진 이름(name)과 속성(attributes), 자식 노드를 포함하는 요소를 만들어서 반환하는 함수
		 *-----------------------------------------------------------------------*/
		function elt(name, attributes) {
			var node = document.createElement(name);
			if( attributes ) {
				for(var attr in attributes) {
					if(attributes.hasOwnProperty(attr)) {
						node.setAttribute(attr,attributes[attr]);
					}
				}
			}
			for(var i=2; i<arguments.length; i++) {
				var child = arguments[i];
				if( typeof child == "string" ) {
					child = document.createTextNode(child);
				}
				node.appendChild(child);
			}
			return node;
		}
				
		/* 특정 노드를 매개값으로 받아서 조상노드를 찾아서 배열에 저장하기 */
		function parents(node) {     
			let current = node,         
			list    = [];     
			while(	current.parentNode != null && 
							current.parentNode != document.documentElement) {
				//존재하는 부모노드를 배열에 추가       
				list.push(current.parentNode);
				//현재노드 갱신     
				current = current.parentNode;    
			}     
			return list;
		}
				
		//댓글목록 가져오기
		function areplyList(reqPage){
			let url = l_url+"/"+l_page+"/"+l_abnum;
			
			console.log(url);
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

						str += '<div class="row pw-10" data-arnum="'+e.arnum+'" >';
						if(e.arindent == 0){
							str += '  <div class="row pw-10">';
						}else{
							str += '  <div class="row pw-10 lm-7">';
						}
						str += '    <div class="col fw-7"><img src="<c:url value='/resources/img/talk.png' />" alt="사진" id="talkimg"/></div>';
						str += '    <div class="col pw-10">';
						str += '      <div class="row header pw-10">';
						str += '        <div class="col fw-15">';
						str += '					<span><b><small class="arnickname">'+e.arnickname+'</small></b></span>';
						str += '					<span><b><small class="arid"></small></b></span></div>';
						str += '        <div class="col fw-15"><small><i>'+e.arcdate+'</i></small></div>';
						str += '        <div class="col"><span><i class="fas fa-reply rereplyBtn2" title="댓글달기"></i></span></div>';
						str += '        <div class="col pw-10">';
						str += '          <div class="row">';
						str += '            <div class="col"><span><i class="fas fa-edit replyModifyBtn" title="수정하기"></i></span></div>	';
						str += '            <div class="col"><span><i class="far fa-trash-alt replyDeleteBtn" title="삭제하기"></i></span></div>';
						str += '          </div>';
						str += '        </div>';
						str += '      </div>';
						str += '      <div class="row body">';
						if(e.arindent == 0){
							str += '  <div class="col"></div>';
						}else{
							str += '  <div class="col fw-5 rm-1"><small><b>'+e.aprnickname+'</b></small>	</div>';
						}						
						str += '        <div class="col arcontent"><p>'+e.arcontent+'<p></div>';
						str += '      </div>';
						str += '      <div class="row bottom">';
						str += '        <div class="col fw-5"><span><i class="fas fa-thumbs-up goodBtn2  title="호감"></i></span> ' + e.good+'</div>';
						str += '        <div class="col fw-5"><span><i class="fas fa-thumbs-down badBtn2 title="비호감"></i></span> ' + e.bad+'</div>';
						str += '      </div>';
						str += '    </div>';
						str += '  </div>';
						str += '</div>';					

						document.getElementById('areplyList').innerHTML = str;

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
	<div id="replyArea">
	  <!-- 댓글 달기 -->
	  <div id="reply">
	    <div class="row">
	      <textarea name="arcontent" id="arcontent" rows="3"></textarea>
	      <button id="replyBtn2">등록</button>
	    </div>
	  </div>
	  
	  <!-- 댓글 목록-->
	  <div id="areplyList"></div>
	  
	  <!--페이징-->
	  <div id="paging"></div>
  </div>
</body>
</html>