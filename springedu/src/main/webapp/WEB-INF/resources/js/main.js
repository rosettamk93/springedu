/**
 * 
 */

  window.addEventListener("load",init,false);
  function init() {
    // 햄버거 버튼요소
    var tabEle = document.getElementsByClassName("tab")[0];
    // 본문(contents)요소
    var dimEle = document.getElementsByClassName("dim")[0];
    //햄버거 버튼 클릭시
    tabEle.addEventListener("click",function(e){
      e.preventDefault(); /*기본 이벤트 취소*/
      displayMobilemenu();
    },false);
    //본문 클릭시
    dimEle.addEventListener("click",function(){
      var mobileEle = document.getElementById("mobile");
      var dimEle = document.getElementsByClassName("dim")[0];
      mobileEle.classList.remove("active");
      dimEle.classList.remove("active");        
    },false);
  //화면이 760px 보다 크면 .dim을 클릭하면 하는 행동을 실행
  window.addEventListener("resize",function(e){
    // console.log(e.target.innerWidth);
    var dimEle = document.getElementsByClassName("dim")[0];
    if(e.target.innerWidth > 760){
      if(dimEle.classList.contains("active")){
        //★dispatchEvent : 프로그램 상으로 이벤트를 강제 발생시키는 함수
        dimEle.dispatchEvent(new Event("click"));
        }
      }
    },false);
  }
  function displayMobilemenu(){
    var mobileEle = document.getElementById("mobile");
    var dimEle = document.getElementsByClassName("dim")[0];
    mobileEle.classList.add("active");
    dimEle.classList.add("active");
  }

 
  	
/*============================================================================================*/



