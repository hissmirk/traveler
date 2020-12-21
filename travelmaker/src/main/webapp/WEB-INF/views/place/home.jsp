<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page session = "true" %>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<html>
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <link href="/resources/css/home.css" rel="stylesheet">
   <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
   <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
   <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
   <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
   <link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
   <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
   <style>
* {
outline:0;
}
img {
	width:80px;
	height:80px;
}
.daily-place-list {
   list-style-type: none;
   margin: 10px;
   width: 80%;
}

.daily-place-list li {
   margin: 0 3px 3px 3px;
   padding: 0.4em;
   width: auto;
   font-size: 15px;
}

.daily-place-list li span {
   position: absolute;
   margin-left: -1.3em;
}

.mainContainer {
   display: flex;
   height:100%;
}

.menu {
   flex-basis: 0;
   flex-grow: 1;
   height: 750px;
}

.left-menu {
   position:relative;
   height:100%;
   background-color:#ffffff;
   flex: 0 0 18%;
   margin : 0 0 10px;
   display: flex;
}

.left-date {
   background-color:#203341;
   flex: 0 0 25%;
   
}

.left-date ul {
   padding: 0;
}

.left-place-list {
	flex: 0 0 75%;
}

.container {
   flex: 0 0 64%;
}

.daily-place-all {
   border-style: groove;
   width: 200px;
}

ul {
   list-style: none;
   padding: 0;
}

#Allschedule {
   display: flex;
}

#showAll {
   display: none;
   width: 70%;
   height: 80%;
   padding: 20px 30px;
   background-color: #fefefe;
   border: 1px solid #888;
   border-radius: 3px;
}


#all-date {
	display: flex;
    flex-direction: column;
    flex: 0 0 25%;
    background-color: #203341;
}
#all-schedule {
	display: flex;
	flex-direction:column;
	overflow:auto;
	flex: 0 0 75%;
}
.daily-place-dt {
	width:100%;
    padding: 10px 0 0;
    text-align: center;
}
#left-container {
	display:flex;
	width:20%;
}

.daily-place-all {
	display:none;
	width:100%;
}

#show-schedule {
   display: none;
   overflow:auto;
   width: 90%;
   height: 90%;
   background-color: #fefefe;
   border: 1px solid #888;
   border-radius: 3px;
}

.in-container {
	width: 80%;
   height: 100%;
}

#registerForm {
   display: none;
   width: 50%;
   height: 50%;
   padding: 20px 30px;
   background-color: #fefefe;
   border: 1px solid #888;
   border-radius: 3px;
}

#searchForm {
	display:flex;
    border-bottom: solid #a7a7a7 1px;
}
#searchForm > {
	display:inline;
}
.search-button:hover {
	 background-color:#1a7ad9;
}

button {
	border:0;
	width: 40px;
	height: 40px;
}
button:hover {
	background-color:#939393;
}
div.hoverable-place > img {
    grid-area:img;
    width:10rem;
    height:10rem;
}
div.hoverable-place > span {
	text-align: left;
    line-height: 1.2em;
    width: 200px;
    grid-area: text;
    overflow: auto;
}
div.hoverable-place > button.add-button {
    grid-area:btn1;
}
div.hoverable-place > button.detail-button {
    grid-area:btn2;
}
.hoverable-place {
	width:95%;
	height:6rem;
	display: grid;
	grid-gap:0.1rem;
  	grid-template-areas:
    'img text text text'
    'img . btn1 btn2';
	align-items:center;
	padding: 2.5%;
    border-bottom: solid #a7a7a7 1px;
    background: #fff;
}

.hoverable-place:hover {
	box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px;
	transition: all 0.2s ease-in-out;
}

.pageNoWrap {
	display:flex;
}
.pageNoWrap > div ~ div {
	padding: 0 1px;
}
.right-paging-bar {
	justify-content: center;
	display:grid;
	grid-template-areas: 'btn1 num btn2';
	align-items: center;
}
.right-paging-bar > button.prev-btn {
	width:15px;
	height:15px;
	grid-area:btn1;
}
.right-paging-bar > div {
	grid-area:num;
}
.right-paging-bar > button.next-btn {
	width:15px;
	height:15px;
	grid-area:btn2;
}
.left-date-list>button {
	border:1px #263846 solid;
	box-sizing:border-box;
	background-color:#203341;
	width:100%;
	color:white;
	height:72px;
}
.left-date-list>button:hover {
	background-color:rgb(22,76,136);
}

.selected-place {
	display:flex;
	width:100%;
	padding: 10px 0px;
	cursor:move;
	border-bottom:solid #a7a7a7 1px;
	align-items:center;
	justify-content:space-between;
}
.selected-place > span {
	flex: 0 0 40%;
	padding:0 10px;
}
#left-date-list > button.daily-place-btn.active{
	background-color:#1a7ad9;
}

#rec-place {
	overflow:auto;
	background-color:#203341;
	color:white;
	z-index: 10;
	display:none;
	position:absolute;
	top: 70px;
    left: 50px;
    flex-direction:column;
    height:50%;
}
.rec-place {
	display: flex;
	padding:10px 10px 0;
    justify-content: space-between;
    align-items: center;
}
.rec-place:last-child {
	padding:10px 10px 10px;
}


#map>.btn-rec-place {
	z-index:10;
	position:absolute;
	width:100px;
	height:42px;
	top:10px;
	text-align: center;
	left:20px;
	border-radius: 3px;
    box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px;
}

#map>.transit-btn-transit{
	z-index:10;
	position:absolute;
	right: 120px;
	bottom:10px;
	background-color:#ffffff;
	width:100px;
	height:42px;
	text-align: center;
	border-radius: 3px;
    box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px;
}
#map>.transit-btn-car {
	z-index:10;
	position:absolute;
	right:20px;
	bottom:10px;
	background-color:#ffffff;
	width:100px;
	height:42px;
	text-align: center;
	border-radius: 3px;
    box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px;
}
#map>.make-button {
	background-color:#ff9320;
	color:white;
	z-index:10;
	position:absolute;
	right:20px;
	top:10px;
	width:100px;
	height:42px;
	text-align: center;
	border-radius: 3px;
    box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px;
}

#map>.insert-button {
	z-index:10;
	position:absolute;
	right:20rem;
	top:10px;
	width:100px;
	height:42px;
	padding:0;
	text-align: center;
}

body > div.mainContainer > div.right.menu {
	overflow:auto;
	flex:0 0 18%;
	flex-direction:column;
	height:100%;
	display:flex;
}
.data-range-picker {
	text-align: center;
	border:0;
	padding:10px 10px;
	font-size:16px;
}
#show > button {
	background-color: #373737;
    color: #d3d3d3;
    font-weight: 400;
    font-size: 30px;
}
#hide {
	background-color: #373737;
    color: #d3d3d3;
    font-weight: 400;
    font-size: 30px;
    top: 200px;
    right: -40px;
    position:absolute;
    z-index: 2;
    width: 40px;
    height: 40px;
}
#show {
	display:none;
    z-index: 1000;
    top: 200px;
    position: absolute;
    width: 40px;
    height: 40px;
    left: 0px;
}

.date-wrapper {
	text-align:center;
	size:20px;
}
#left-place-list > div > div {
	background-color:#707070;
	padding: 10px 20px;
}


#left-place-list > div > div > span:nth-child(1) {
	color:white;
	padding-right:10px;
}

#left-place-list > div > div > span:nth-child(2) {
	color:#999999;
	padding-right:10px;
}
#left-place-list > div > div > span:nth-child(3) {
	color:white;
}
.search-button {
	flex:0 0 13%;
 	background-color:#1a7ad9;
}
#search-value {
	flex:0 0 87%;
}
#left-place-list > div > ul > div > button {
	flex:0 0 20%;
}
#left-date-list > button.showAllBtn.active{
	background-color:#1a7ad9;
}
.place-perday-list {
	display:flex;
}
#all-schedule > outplcdt-wrap-div > ul > div > button {
	width:100%;
	height:1.5em;
	background-color:#90a4ae;
	color:white;
}
#all-schedule > ul.place-dt-list > div > button:hover {
	background-color:#2196f3;
}


</style>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  var dnd = $.noConflict(true);
  </script>
</head>
<body>
   <!-- /.panel-heading -->
   
    <div id="showAll">
    <div id="Allschedule"></div>
               <button class="modal_close_btn" style="float:right;">닫기</button>
        </div>
        
    <div id="show-schedule">
      	  <div id="left-container">
			  <div id="all-date"></div>
			  <div id="all-schedule"></div>
		  </div>
		  <div class="in-container">
			  <div id="in-mapWrapper" style="width:100%;height:100%">
			  	<div id="in-map" style="width:100%;height:100%"></div> <!-- 지도를 표시할 div 입니다 -->
			  </div>
		  </div> 
		  <div id="right-container"><button class="modal_close_btn" style="position: absolute;right:30px;z-index:110;">X</button></div>
      	<button class="submit-btn" style="position: absolute;top:60px;right:30px;z-index:110;">저장</button>
      </div>    
      
      
      <div id="registerForm">
				<p> 
					<input type="text" class="title-box" placeholder ="plz write down title" />
				</p>
				<p>
					<input type="text" class="content-box" placeholder="plz write down content" />
      			</p>
      			<button type="button" onclick="insertSchedule()">저장</button>
      	</div>
        
      <!-- start place List 지금은 굳이 상관안해도 되고 나중에 이름 바꿀때 right side bar nav -->
<div class="mainContainer">

      <div class="left-menu">
      
      	<button id="hide"> < </button>
      
      <div class="left-date">
      
      <ul class="left-date-list" id="left-date-list">
      
      <!-- 일자별 모든 녀석들 출력하는 리스트 -->
      </ul> 
      </div>
      
      <div class="left-place-list">
      <div class="date-wrapper">
            <input type="text" name="daterange" class="data-range-picker" data-region-no='<c:out value="${schDto.schRegion}" />' data-init-todate='<c:out value="${schDto.toDate}" />' data-init-fromdate='<c:out value="${schDto.fromDate}" />' />
      </div>
      
      <div class="left-place-list" id="left-place-list">
            
      </div>
   </div>
   </div>
   <!-- end place list -->
<!-- 맵 시작 -->
<div class="container">
     <div id="mapWrapper">
        <div id="map" style="width:100%;height:100% position:relative;">
	         <div class="left clearfix" id="rec-place">
	         <c:forEach items="${places}" var="list">
	         <div class="rec-place" data-title="${list.plcTitle}" data-plc-no="${list.plcNo}" data-lat="${list.lat }" data-lng="${list.lng}" data-opening-h="${list.openingH }" data-holiday="${list.holiday}" data-address-dt="${list.addressDt}" data-region-no="${list.regionNo}">
	                  <img src='<c:out value="${list.plcImg}"></c:out>'>
	                  <c:out value="${list.plcTitle}"></c:out>
	                  <button class="rec-add-button" type="button">
	                  <i class="fas fa-plus"></i>
	                  </button>
	            </div>
	            </c:forEach>
	         </div>
        <button class="btn-rec-place">추천 장소</button>
        <button type='button' class="transit-btn-car">차</button>
		<button type='button' class="transit-btn-transit">대중교통</button>
		<!-- <button class="insert-button" onclick="insertSchedule()">일정 넣기</button> -->
		<button class="make-button" onclick="initSch()">일정 만들기</button>
		<div id="show"><button>></button></div>
        
        </div> <!-- 지도를 표시할 div 입니다 -->
    </div>
</div>
<!-- 맵 끗 -->
<div class="right menu">
      <!-- 검색 창의 시작  -->
      <form name="searchForm" id="searchForm" style="width:100%;">
            <input type="text" style="border:0;margin-left:2px" placeholder="검색어를 입력해주세요" id="search-value"/><br>
            <button class="search-button" type="button">
            <i class="fas fa-search" style="color:#ffffff"></i>
         </button>
      </form>
      <!-- 검색 창의 끝 -->
   <!-- /.panel-heading -->
   <div class="panel-body">
      <!-- start place List 지금은 굳이 상관안해도 되고 나중에 이름 바꿀때 right side bar nav -->
      <ul class="right-place-list">
      </ul>
   </div>
   <!-- end place list -->
   
    <div class="right-paging-bar"></div>
    
</div>
</div>
   <script type="text/javascript" src="/resources/js/place.js"></script>
   <script type="text/javascript"
         src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9eb973825ac1960ebb20d660fdf86341&libraries=services"></script>
   <script type="text/javascript">
   
      var markers =[];
      var marker;
      var resultset = [];

      var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
          mapOption = {
             center : new kakao.maps.LatLng(33.529252,126.589699), // 지도의 중심좌표
             level : 8
          // 지도의 확대 레벨
          };
      
         var map = new kakao.maps.Map(mapContainer,
                   mapOption); // 지도를 생성합니다
                   mapContainer.style.width = '100%';
                   mapContainer.style.height = '100%';
                   map.relayout();
      
      function hide() {
    	  dnd(".left-menu").hide("slide", { direction: "left" }, 100);
          document.querySelector('#show').style.display = 'block';
         /*  document.querySelector('.container').style.flex = '0 0 88%'; */
          map.relayout();
      }              
      function show() {
                	   dnd(".left-menu").show("slide", { direction: "left" }, 100);
                       document.querySelector('#show').style.display = 'none';
                      /*  document.querySelector('.container').style.flex = '0 0 70%'; */
                       map.relayout();   
      }
                 //전체보기
      function showAll() {
          let zIndex = 9999;
          let modal = document.getElementById('showAll');
          let listAll = document.getElementById('Allschedule');
          let dpList = document.getElementsByClassName('daily-place-list');
          
          for (let i = 0; i < dpList.length; i++) {
             
            let objs = document.createElement('ul');
            objs.setAttribute('class','daily-place-all');
            objs.style.display = 'inline';
             objs.innerText="DAY"+(1+i);
             
             listAll.appendChild(objs);

             for (let j = 0; j < dpList[i].getElementsByTagName('li').length; j++) {
             let daliyplace = document.createElement('li');
             daliyplace.setAttribute('class','daily-all-place');
             daliyplace.innerText = dpList[i].getElementsByTagName('li')[j].dataset['title'];
             
             objs.appendChild(daliyplace);
         }
       }
          
          // 모달 div 뒤에 희끄무레한 레이어
          let bg = document.createElement('div');
          bg.setStyle({
              position: 'fixed',
              zIndex: zIndex,
              left: '0px',
              top: '0px',
              width: '100%',
              height: '100%',
              overflow: 'auto',
              // 레이어 색깔은 여기서 바꾸면 됨
              backgroundColor: 'rgba(0,0,0,0.4)'
          });
          document.body.append(bg);

          // 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
          modal.querySelector('.modal_close_btn').addEventListener('click', function() {
              bg.remove();
                  modal.style.display = 'none';
                  //자식 노드 초기화
         $("#Allschedule").empty();
          });

          modal.setStyle({
              position: 'fixed',
              display: 'block',
              boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

              // 시꺼먼 레이어 보다 한칸 위에 보이기
              zIndex: zIndex + 1,

              // div center 정렬
              top: '50%',
              left: '50%',
              transform: 'translate(-50%, -50%)',
              msTransform: 'translate(-50%, -50%)',
              webkitTransform: 'translate(-50%, -50%)'
          });
      };

      // Element 에 style 한번에 오브젝트로 설정하는 함수 추가
      Element.prototype.setStyle = function(styles) {
          for (var k in styles) this.style[k] = styles[k];
          return this;
      };         
                   
      $(document).ready(function(){ // document ready, datepicker의 초기값과 이벤트 등록 전담
         
         let datePicker = document.getElementsByClassName("data-range-picker")[0];
         let fromDate = datePicker.dataset["initFromdate"];
         let toDate = datePicker.dataset["initTodate"];
         
         $('input[name="daterange"]').daterangepicker({
            startDate: fromDate,
            endDate: toDate, 
            minDate: moment(),
            maxSpan: {
                "days": 9 // 9일이어야 1일차부터 10일차까지 가능
            },
            locale: { 
               format: 'YYYY-MM-DD'
            }
           }, function(start, end, label) {
             // console.log("A new date selection was made: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD')); 
           });
         
         $('input[name="daterange"]').on('apply.daterangepicker', (e, picker) => {
            computeDate(); 
            }); 
         
         init();
      })
      
      
      function init() { //이벤트 등록 전담용 initial
          computeDate();
       //모달보는 버튼에 이벤트 추가
         document.querySelector('.transit-btn-car').addEventListener('click', ()=>{
        	 sessionStorage.setItem("transit","car");     
        	 alert("차로 변경되었습니다.")
         });
         document.querySelector('.transit-btn-transit').addEventListener('click', ()=>{
        	 sessionStorage.setItem("transit","traffic"); 
        	 alert("대중교통으로 변경되었습니다.")
         }); 
         document.querySelector('.submit-btn').addEventListener('click', ()=>{
             let btn = document.querySelector('#submit-btn'); 
         }); 
         
         document.querySelector('.search-button').addEventListener('click', searchAction);
         document.querySelector('.btn-rec-place').addEventListener('click', ()=>{ // 추천장소 버튼을 누르면 장소들 등장, button을 추가할지 말진 모르겠다.
                 let recPlace = document.querySelector('#rec-place')
                    if(recPlace.style.display=='' || recPlace.style.display==='none' ){
                       recPlace.style.display='flex';
                        }
                    else if(recPlace.style.display==='flex'){
                        recPlace.style.display='none';
                     }
         });
         
         $("#hide").click(hide)
         $("#show").click(show);
         
         document.querySelector('.daily-place-list').style.display ='block';
         let recPlaceBtn = document.getElementsByClassName("rec-add-button");
         for (var i = 0; i < recPlaceBtn.length; i++) {
            recPlaceBtn[i].addEventListener('click', (event) => {
                let index = getActiveDay();
                let leftPlaceList = document.getElementsByClassName("daily-place-list");
                let activePlaceList = leftPlaceList[index];
                let compPlaceList = activePlaceList.children
                if(compPlaceList.length>5) { //span wrap div
                	alert("하루에 장소는 6개까지만 가능합니다.")
               	 return;
                }
                let currTarget = event.currentTarget.parentElement;
                let span = document.createElement("span");
                let targetText = currTarget.innerText;
                let curClone = currTarget.cloneNode(true);
                curClone.setAttribute("class", "selected-place");
                   for (let i = 0; i < compPlaceList.length; i++) {
                      if(curClone.dataset["plcNo"]==compPlaceList[i].dataset["plcNo"]){
                         return;
                      }               
                   }
                let child = curClone.children;
                child[1].remove()
                let btnobj1 = document.createElement("button");
                btnobj1.setAttribute('class', 'delete-button');
                let iconobj1 = document.createElement("i");
                iconobj1.setAttribute('class', 'fas fa-times');
                btnobj1.addEventListener('click',deleteInLeft);
                btnobj1.appendChild(iconobj1);
                
                curClone.appendChild(btnobj1);
                activePlaceList.appendChild(curClone);
              });
         }
      }
             
       function computeDate() { // date picker apply 이벤트랑, 초기값 계산해서 button 생성하는 function
          let datePicker = document.getElementsByClassName("data-range-picker")[0];
          let dateList = datePicker.value.split(' - ');
          let fromDate = new Date(dateList[0]);
          let toDate = new Date(dateList[1]);
          let dateDiff = Math.ceil((toDate.getTime()-fromDate.getTime())/(1000*3600*24));
          const transDate = (date) => {
			 return date.toISOString().substring(5, 10).split('-').join('.')       	  
          }
          let totalDate = document.getElementById("left-date-list");
          let totalPlace = document.getElementById("left-place-list");
          totalDate.innerHTML = null;
          totalPlace.innerHTML = null; // 수정되면 초기화 작업
          
          let objs = document.createElement('button');
          objs.setAttribute('class', 'showAllBtn');
          objs.innerText="전체보기";
          //전체보기 이벤트생성
          objs.addEventListener('click', showAll);
          
          totalDate.appendChild(objs);
            
         for(let idx=0; idx<=dateDiff; idx++ ){
        	 var week = ['일','월','화','수','목','금','토']
	             let objs;
	             objs = document.createElement('button');
	             objs.setAttribute('class', 'daily-place-btn');
	             objs.innerText="DAY"+(idx+1);
	             objs.addEventListener('click',  (event) => {
                 let currTarget = event.currentTarget;
                 let btnList = document.getElementsByClassName("daily-place-btn")
                 let dailyPlaceList = document.querySelectorAll('.daily-wrap-div')
                 let arr = [...btnList];
                 let psuedoidx = arr.indexOf(currTarget);
                 // 토글 버튼 인덱스 추가 삭제 총괄
                 for (let i=0; i < btnList.length; i++) {
                    dailyPlaceList[i].style.display='none';
	             	btnList[i].classList.remove("active");
                 }
                 dailyPlaceList[psuedoidx].style.display='block';
	             btnList[psuedoidx].classList.add("active");
              });
	             totalDate.appendChild(objs);
	             let currDate = addDays(fromDate,idx);
	             let wdiv = document.createElement('div');
	             wdiv.setAttribute("class","daily-wrap-div");
	             wdiv.setAttribute('style','display:none');
	             
	             let div = document.createElement('div');
	             div.setAttribute("class","span-wrap-div");
				 let span1 = document.createElement('span');
	             let span2 = document.createElement('span');
	             let span3 = document.createElement('span');
	             span1.innerText = `DAY\${idx+1}`;
	             span2.innerText = "|";
	             span3.innerText = `\${transDate(currDate)}(\${week[currDate.getDay()]}요일)`;
	             
	             let liobjs = document.createElement('ul');
	             liobjs.setAttribute('class', 'daily-place-list');
	            
	             
	             div.appendChild(span1);
	             div.appendChild(span2);
	             div.appendChild(span3);
	             wdiv.appendChild(div);
	             wdiv.appendChild(liobjs);
	             totalPlace.appendChild(wdiv);
         }
         totalDate.children[1].classList.add("active");
         document.querySelector('.daily-wrap-div').style.display='block';
       }
       
       function addDays(date, days) { // 일을 증가시키는 메소드
    	    let ndate = new Date(date);
  		    let rdate= ndate.setDate(ndate.getDate() + days);
  		    return new Date(rdate); 
		}
       
       function insertSchedule() {
    	     /*  // 유빈 누나 코드
              const formData = new FormData();
              
              const inputFile = $("input[name='uploadFile']");
              
              const file = inputFile[0].files[0];

              if($(".uploadResult li").length==1){
                 $(".uploadResult li")[0].remove();
              }
              formData.append("uploadFile",file);
			  // 유빈누나 코드 end */
              
           let datePicker = document.getElementsByClassName("data-range-picker")[0];
           let dateList = datePicker.value.split(' - ');
           let fromDate = new Date(dateList[0]);
           let toDate = new Date(dateList[1]);
           
           let transit = sessionStorage.getItem("transit") || "car";
           let tmpAllList =[];
           let tmpList;
           let placeList = document.getElementsByClassName("daily-place-list");
           let len = placeList.length;
           let memNo = <%= session.getAttribute("memNo") %> || 0;
           let schRegion = ${schDto.schRegion};
           let scheduleVO = {
        		   memNo:memNo,
        		   schTitle:"테스트 제목",
        		   fromDate:fromDate,
        		   toDate:toDate,
        		   // 이미지 추가 멀티파일 부분
        		   img:formData,
        		   // 이미지 추가 멀티파일 부분
        		   schStatus:"작성중",
        		   memo:"테스트 메모",	   
        		   schRegion:schRegion
           }
           for (let i = 0; i < len; i++) {
        	   
             let tmpSchList = [];
             tmpList = placeList[i].children;
             tmplen = tmpList.length;
             for (j = 0; j < tmplen-1; j++) {
            	let daycount = addDays(fromDate,i)
                let tmp = { 
                	  schNo:null,
                      schDate:daycount, // 1일차, 2일차, 3일차
                      fromPlc:tmpList[j].dataset["plcNo"],
                      toPlc:tmpList[j+1].dataset["plcNo"],
                      distance:1,
                  	  duration:"1",
                      transit:transit,
                      num:j
                }
                tmpSchList.push(tmp);
             }
          tmpAllList.push(tmpSchList);
          }
           let sendData = {
        		   scheduleVO:scheduleVO,
        		   schdtVOs:tmpAllList
           }
           $.ajax({
                url: "/place/put/sch",
                type: "POST",
                data: JSON.stringify(sendData),
                contentType: "application/json; charset=utf-8;",
                dataType: "text",
                success:function(data){
                	location.href = data;
                },
                error: function(data){
                	alert("error : "+data);
                }
            });  
           
        };
        
       function initSch(){
    	   let zIndex = 99;
    	   let modal = document.getElementById('show-schedule');
    	   var mapContainer = document.getElementById('in-map'),
           mapOption = {
              center : new kakao.maps.LatLng(33.529252,126.589699), // 지도의 중심좌표
              level : 8
           // 지도의 확대 레벨
           };
           
           mapContainer.setStyle({
               width: '100%',
               height: '100%',
           });
           
           let dateAll = document.getElementById('all-date');
           let listAll = document.getElementById('all-schedule');
           // 노드를 이어붙일 애들 target
           let dpList = document.getElementsByClassName('daily-place-list');
           // 장소 추출할 친구 현재 2차원임;
           let dateList = document.querySelector("#left-date-list").cloneNode(true);
           let dailyBtn = dateList.children;
           let len = dailyBtn.length;
			for (let i = 0; i < len; i++) {
				if(i>0){
				dailyBtn[i].addEventListener("click",drawLine);
				}
				dailyBtn[i].addEventListener("click", (event) =>{
					let currTarget = event.currentTarget;
					let arr = [...dailyBtn];
			        let psuedoidx = arr.indexOf(currTarget);
			        for (let j = 0; j < len; j++) {
			        	dailyBtn[j].classList.remove("active");
					}
			        dailyBtn[psuedoidx].classList.add("active");
				})
             	dailyBtn[i].classList.remove("active");
			}
           dailyBtn[0].classList.add("active");
           // 일정 추출할 친구
           // 일정 생성 완료
           let dateLeng = dateList.children.length-1;
           
		   let leng = dpList.length;
           for (let i = 0; i < leng; i++) {
              
             let objs = document.createElement('ul');
             dnd(objs).sortable({
             	start:function(event, ui) {
             		ui.item.data('pos-idx', ui.item.index());
             		console.log(ui.item.index());
            	},
            	stop:function(event, ui) {
             		var startPos = ui.item.data('pos-idx');
             		var endPos = ui.item.index();
             		console.log(startPos+ " : " + endPos); // 시작점 : 끝나는점 
             	}
             });
             dnd(objs).disableSelection();

              objs.setAttribute('class','daily-place-dt');
              objs.style.display = 'block';
              objs.innerText=i+1+"일차";
              listAll.appendChild(objs);
			  // 일차 리스트에 이어 붙여주기          
			  
              let len = dpList[i].children.length; //span wrap div -1 
              for (let j = 0; j < len; j++) {
              let dailyplace = dpList[i].children[j].cloneNode(true); //span wrap div +1
              dailyplace.setAttribute('class','place-perday-list');
              dailyplace.lastElementChild.addEventListener('click',deleteInLeft);
              objs.appendChild(dailyplace);
          }
        }
           dateAll.appendChild(dateList);  
           // 모달 div 뒤에 희끄무레한 레이어
           let bg = document.createElement('div');
           bg.setAttribute("class", "modal-background");
           bg.setStyle({
               position: 'fixed',
               zIndex: zIndex,
               left: '0px',
               top: '0px',
               width: '100%',
               height: '100%',
               overflow: 'scroll',
               backgroundColor: 'rgba(0,0,0,0.4)'
           });
           document.body.append(bg);

           modal.querySelector('.modal_close_btn').addEventListener('click', function() {
               bg.remove();
                   modal.style.display = 'none';
          $("#all-schedule").empty();
          $("#all-date").empty()         
           });

           modal.setStyle({
               position: 'fixed',
               display: 'flex',
               boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

               zIndex: zIndex + 1,

               // div center 정렬!!
               top: '50%',
               left: '50%',
               transform: 'translate(-50%, -50%)',
               msTransform: 'translate(-50%, -50%)',
               webkitTransform: 'translate(-50%, -50%)'
           });
       
       
           const showCurrList = function (event){
         	 let idx = $(this).index()-1;
        	 let plcdtList = document.getElementsByClassName("place-dt-list");
        	   if(!(plcdtList[idx]==undefined)){
        		   return;
        	   }
  			 let currList = document.getElementsByClassName("daily-place-dt")[idx]; 
  			 let leng = currList.children.length;
  			 let tmpList = document.createElement("ul");
  			 let title = document.createElement("span");
  			 title.innerText = (idx+1)+"일차";
  			 tmpList.setAttribute("class","place-dt-list");
  			 let transit = sessionStorage.getItem("transit");
  			 let geocoder = new kakao.maps.services.Geocoder();
  			 
  			 const geoChanger = (mX,mY) => {
  				 return new Promise((resolve,reject) => {
  					   geocoder.transCoord(mX, mY, (result,status) => {
  		  	               if (status === kakao.maps.services.Status.OK) {
  		  	            	    resolve(result);
  		  	                   } else {
  		  	       				reject(status); 
  		  	       			   }
  		  	               }, {
  			               input_coord: kakao.maps.services.Coords.WGS84,
  			               output_coord: kakao.maps.services.Coords.WCONGNAMUL
  			           });
  				})   
  			   }
  			 let geoArr = [];
  			 for (let i = 0; i < leng; i++) {
  				   let locaData = currList.children[i];
  				   let x = locaData.dataset["lng"];
  				   let y = locaData.dataset["lat"];
  				   let promise = geoChanger(x,y);
  				   geoArr.push(promise);
         } // for currList end 
         let pAll = Promise.all(geoArr);
         
		 let curClone = currList.cloneNode(true);
         for (let i = 0; i < geoArr.length; i++) {
			let locaData = currList.children[i];
			pAll.then(result => {
				let owdiv = document.createElement("outplcdt-wrap-div");
				 resultset.push({x:result[i][0].x,y:result[i][0].y,title:locaData.dataset["title"]});
		         let dailyplace = locaData.cloneNode();
		         dailyplace.setAttribute("class", "place-dt-perday");
		         dailyplace.innerText = dailyplace.dataset["title"];
		         let rsid = resultset.length||0;
		         if(rsid>1){
		        	 let URL = `https://map.kakao.com/?map_type=TYPE_MAP&target=\${transit}&rt=\${resultset[rsid-2]["x"]},\${resultset[rsid-2]["y"]},\${resultset[rsid-1]["x"]},\${resultset[rsid-1]["y"]}&rt1=\${resultset[rsid-2]["title"]}&rt2=\${resultset[rsid-1]["title"]}&rtIds=%2C&rtTypes=%2C`;
		        	 let button = document.createElement("button");
			         button.setAttribute("type", "button");
			         button.addEventListener("click",() => {
                         window.open(URL, "카카오 지도", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" ); 
			         })
			         button.innerText="상세보기 "
			         let icon2 = document.createElement("i");
			         icon2.setAttribute("class", "fas fa-sort-down");
			         button.appendChild(icon2);
		        	 let span = document.createElement("span");
		        	 span.innerText = "STEP"+i;
		        	 
		        	 let icon1 = document.createElement("i");
		        	 icon1.setAttribute("class", "fas fa-long-arrow-alt-down");
		        	 
		        	 let dailypair = currList.children[i-1].cloneNode();
			         dailypair.setAttribute("class", "place-dt-perday");
			         dailypair.innerText = dailypair.dataset["title"];
		        	 let wdiv = document.createElement("div");
		        	 wdiv.setAttribute("class", "plcdt-wrap-div");
		        	 wdiv.appendChild(span);
		        	 wdiv.appendChild(dailypair);
		        	 wdiv.appendChild(icon1);
		        	 wdiv.appendChild(dailyplace);
		        	 wdiv.append(button);
		         	 tmpList.appendChild(wdiv)
		         } // if end // resolve end
		         	 owdiv.appendChild(title);
		         	 owdiv.appendChild(tmpList);
			         listAll.appendChild(owdiv);
	   				}, status => {console.log(status)}					         
			); // end then
			         resultset = []; // resultset을 다시금 초기화 해주는 작업;	   
		}
         
         		}    
  		for (let i = 0; i < dateLeng; i++) {
  	           dateList.children[i+1].addEventListener("click",showCurrList);
  		} // for event Listener end
         inmap = new kakao.maps.Map(mapContainer,
                 mapOption); // 지도를 생성합니다
                 mapContainer.style.width = '100%';
                mapContainer.style.height = '100%';
                
                 inmap.relayout();
         };   
       
       function drawLine(ele) {
    	   colors = ["#b61aae","#f07b3f","#ea5455","#2d4059","#fdb827","#21209c","#583d72","#3ec1d3","#3490de","#086972"];
    	   let leftList = document.querySelector("#left-place-list");
    	   let idx = $(this).index()-1;
    	   let latlngList = leftList.children[idx].children;
    	   let leng = latlngList.length-1;
    	   for (let i = 0; i < leng; i++) {
    		let pos1 = new kakao.maps.LatLng(latlngList[i].dataset["lat"],latlngList[i].dataset["lng"])
    		let pos2 = new kakao.maps.LatLng(latlngList[i+1].dataset["lat"],latlngList[i+1].dataset["lng"])
    		let markerPosition  = new kakao.maps.LatLng(latlngList[i].dataset["lat"],latlngList[i].dataset["lng"]); 
    		// 이미지 지도에 표시할 마커
    		// 이미지 지도에 표시할 마커는 Object
    		let mark1 = new kakao.maps.Marker({
                   position : pos1, // 마커의 위치
                   clickable: true
                });
    		mark1.setMap(inmap);
    		
    		kakao.maps.event.addListener(mark1, 'click', () => {
    		      let placeNo = latlngList[i].dataset["plcNo"]
    		      let URL = "https://place.map.kakao.com/"+placeNo;
                  window.open(URL, "카카오 지도", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );
    		});
    		
    	   let polyline = new kakao.maps.Polyline({
    		    map: inmap,
    		    path: [
    		        pos1,
    		        pos2
    		    ],
    		    endArrow: true,
    		    strokeWeight: 4,
    		    strokeColor: colors[idx],
    		    strokeOpacity: 0.8,
    		    strokeStyle: 'solid'
    		})
    		console.log((polyline.getLength()/1000).toFixed("2")+"km"); 
    	   }
       }
       
       function searchAction(event) {
         let placeValue = $("#search-value").val();
         if(placeValue==""){
            alert("검색어를 입력해주세요");
            return;
         }
         let placeList = $(".right-place-list");
         let pageNum = event.currentTarget.dataset["num"]||1;
         let regionNo = document.getElementsByClassName("data-range-picker")[0].dataset["regionNo"];
         
         let leftPlace = document.getElementsByClassName("selected-place");
         let index = getActiveDay();
         let leftPlaceList = document.getElementsByClassName("daily-wrap-div");
         let activePlaceList = leftPlaceList[index].children;
         placeList.empty();
         let tmplist = [];
         
         placeService.getList({
        	title:placeValue,
            regionNo:regionNo,
            pageNum:pageNum
            },
            (map) => {
                 let list = map["list"];
                 let pageMaker = map["pageMaker"];
                 let len = list.length||0;
                 let leng = activePlaceList.length||0;
                  
                  for (let i= 0; i<len-leng; i++) {
                     for (let j = 0; j < leng; j++) {
                           if(activePlaceList[j].dataset["title"]==list[i].plcTitle){
                              list.splice(i,1);
                        }
                     }
                  }
                  
                  const pagingWithpageMaker = (pageMaker)=> {
                      let pagingBar = document.getElementsByClassName("right-paging-bar")[0];
                      pagingBar.innerHTML = null;
                      let wrapperDiv = document.createElement("div");
                      wrapperDiv.setAttribute("class", "pageNoWrap");
                    let endPage = pageMaker.endPage;
                    let startPage = pageMaker.startPage;
                    if(pageMaker.prev) {
                       let btnObj = document.createElement("button");
                       btnObj.setAttribute("type", "button");
                       btnObj.setAttribute("class", "prev-btn");
                       btnObj.setAttribute("data-num", startPage-1);
                       btnObj.innerText ="<";
                       btnObj.addEventListener('click',searchAction);
                       pagingBar.appendChild(btnObj);
                    }
                    
                    for (let k = startPage; k <= endPage; k++) {
                       let pageObj = document.createElement("div");
                       pageObj.setAttribute("data-num", k);
                       pageObj.innerText = k;
                       pageObj.addEventListener('click',searchAction);
                       wrapperDiv.appendChild(pageObj);
                    }
                    pagingBar.appendChild(wrapperDiv);
                    if(pageMaker.next) {
                       let btnObj = document.createElement("button");
                       btnObj.setAttribute("type", "button");
                       btnObj.setAttribute("class", "next-btn");
                       btnObj.setAttribute("data-num", endPage+1);
                       btnObj.addEventListener('click',searchAction);
                       btnObj.innerText =">";
                       pagingBar.appendChild(btnObj);
                    }
                 }
                  pagingWithpageMaker(pageMaker);
                  
                  for (let i = 0; i < len; i++) {
                     let liobj = document.createElement("li");   
                     liobj.setAttribute('class', 'left clearfix');
                     let objs1 = document.createElement("div");
                     objs1.setAttribute('class','hoverable-place');
                     objs1.setAttribute('data-title',list[i].plcTitle);
                     objs1.setAttribute('data-region-no',list[i].regionNo);
                     objs1.setAttribute('data-address-dt',list[i].addressDt);
                     objs1.setAttribute('data-plc-no',list[i].plcNo);
                     objs1.setAttribute('data-holiday',list[i].holiday);
                     objs1.setAttribute('data-lat',list[i].lat);
                     objs1.setAttribute('data-lng',list[i].lng);
                     objs1.setAttribute('data-opening-h',list[i].openingH);
                     objs1.setAttribute('data-p-cate',list[i].pCate);
                     let span = document.createElement("span");
                     span.innerText=list[i].plcTitle + " ";
                     objs1.addEventListener('mouseover',placeOver);
                     let objs1img = document.createElement('img');
                     objs1img.setAttribute('src',list[i].plcImg);
                     objs1img.setAttribute('style','width:5rem;height:5rem;');
                     
                     
                     let btnobj1 = document.createElement("button");
                     btnobj1.setAttribute('class', 'add-button');
                     let iconobj1 = document.createElement("i");
                     iconobj1.setAttribute('class', 'fas fa-plus');
                     btnobj1.addEventListener('click', show);
                     btnobj1.addEventListener('click', (event) => {
                         let currTarget = event.currentTarget.parentElement;
                         let index = document.getElementsByClassName("left-place-list")
                         let parentI = (currTarget.children)[0].cloneNode();
                         let dailyPlaceList = document.getElementsByClassName("daily-place-list");
                         let idx = getActiveDay(); // idx 를 얻었다.
                         let currentList = dailyPlaceList[idx];
                         let currentPlaceList = currentList.children;
                         if(currentPlaceList.length>=6){
                        	 alert("하루에 장소는 6개까지만 가능합니다.")
                        	 return;
                         }
                         for (let i = 0; len = currentPlaceList.length ,i < len; i++) {
                            if(currTarget.dataset["plcNo"]==currentPlaceList[i].dataset["plcNo"]){
                               return;
                            }
                         }
                                     let objs1 = currTarget.cloneNode();
                                     objs1.setAttribute('class','selected-place');
                                     let span = document.createElement("span");
                                     span.innerText = currTarget.dataset['title'];
                                     
                                     objs1.append(parentI);
									 objs1.append(span);
                                     let btnobj1 = document.createElement("button");
                                     btnobj1.setAttribute('class', 'delete-button');
                                     let iconobj1 = document.createElement("i");
                                     iconobj1.setAttribute('class', 'fas fa-times');
                                     btnobj1.addEventListener('click',deleteInLeft);
                                     btnobj1.appendChild(iconobj1);
                                     objs1.appendChild(btnobj1);
                                     currentList.append(objs1);
                                     
                         
                         if(markers.length||0){
                            markers[0].setMap(null);
                            markers.pop();
                         }
                         

                         dnd( function() {
                            dnd( ".daily-place-list" ).sortable();
                            dnd( ".daily-place-list" ).disableSelection();
                            
                            } );
                      });
                     btnobj1.appendChild(iconobj1);
                     
                     let btnobj2 = document.createElement("button");
                     btnobj2.setAttribute('class', 'detail-button');
                     let iconobj2 =document.createElement("i");
                     iconobj2.setAttribute('class', 'fas fa-search-plus');
                     btnobj2.addEventListener('click', (event) => { // 상세 정보 보기 페이지 URL + palceNo로 이루어져있다
                         let clickedBtn = event.currentTarget;
                         let placeNo = clickedBtn.parentElement.dataset["plcNo"];
                         let URL = "https://place.map.kakao.com/"+placeNo;
                         window.open(URL, "카카오 지도", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" ); 
                      });
                     btnobj2.appendChild(iconobj2);
                     
                     objs1.prepend(objs1img);
                     objs1.appendChild(span);
                     objs1.appendChild(btnobj1);
                     objs1.appendChild(btnobj2);
                     liobj.appendChild(objs1);
                     placeList.append(liobj);
                  }
               })
         return;
      }
       
      function deleteInLeft(event) {
         let deleteElement = event.currentTarget;
         deleteElement.parentElement.remove(); 
      }
      
      function getActiveDay(){
         let dateList = document.getElementsByClassName("daily-wrap-div");
         let idx;
         for (let i = 0; i < dateList.length; i++) {
            
            if(dateList[i].style.display=="block"){
               idx = i;
            }
         }
         return idx;
      }

      
      
      function placeOver(event) {
             let currTarget = event.currentTarget;
             // 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
             var bounds = new kakao.maps.LatLngBounds();
             
             const addMaker = (position) => {
                 marker = new kakao.maps.Marker({
                    position : position, // 마커의 위치
                 });
                 markers.push(marker);
                 marker.setMap(map); // 지도 위에 마커를 표출합니다
                 return marker;
              } 
                 
	          const panTo = (marker) => {
	               // 이동할 위도 경도 위치를 생성합니다 
	               let moveLatLon = new kakao.maps.LatLng(marker.getPosition().getLat(),marker.getPosition().getLng());
	               // 지도 중심을 부드럽게 이동시킵니다
	               // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
	               map.setProportion;
	               map.panTo(moveLatLon);            
	          }
             /*  for (var i = 0; i < markers.length||0; i++) {
               //  굳이 marker배열을   쓸 필요가 없으면 필요없을거 같기도 하다.
            } */
	                var placePosition = new kakao.maps.LatLng(
	                      (currTarget.dataset["lat"]),
	                      (currTarget.dataset["lng"])),
	                marker = addMaker(placePosition);
	                panTo(marker);
	                
	                currTarget.addEventListener("mouseout",() => {
	                   marker.setMap(null);
	                   markers.pop();
	                }) 
      		  }
   </script>
</body>
</html>