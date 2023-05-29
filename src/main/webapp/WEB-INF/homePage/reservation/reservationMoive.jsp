<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>회차 선택</title>
	<jsp:include page="/include/bs4.jsp" />
	<style>
		* {box-sizing: border-box}
		body {font-family: "Lato", sans-serif;}
		
		/* Style the tab */
		.tab {
		  float: left;
		  border: 1px solid #ccc;
		  background-color: #f1f1f1;
		  width: 20%;
		 
		}
		
		/* Style the buttons inside the tab */
		.tab button {
		  display: block;
		  background-color: inherit;
		  color: black;
		  padding: 22px 16px;
		  width: 100%;
		  border: none;
		  outline: none;
		  text-align: left;
		  cursor: pointer;
		  transition: 0.3s;
		  font-size: 17px;
		}
		
		/* Change background color of buttons on hover */
		.tab button:hover {
		  background-color: #ddd;
		}
		
		/* Create an active/current "tab button" class */
		.tab button.active {
		  background-color: #ccc;
		}
		
		/* Style the tab content */
		.tabcontent {
		  float: left;
		  padding: 0px 12px;
		  
		  width: 80%;
		  border-left: none;
		 
		}
	</style>
	<script>
		'use strict';
		
		function openCity(evt, order,scheduleIdx) {
			$.ajax({
				url:"${ctp}/MovieSeatChk.res",
				type:"post",
				data:{
					scheduleIdx:scheduleIdx
				},
				success:function(res){
					let totSeat=${vos[0].seat};
					$("#scheduleList_"+scheduleIdx).text("총 좌석수: "+${vos[0].seat}+" / 예약 가능 좌석수: "+(totSeat-res));
				
				},
				error:function(){
					alert("전송 실패");
				}
			});
			
		  var i, tabcontent, tablinks;
		  tabcontent = document.getElementsByClassName("tabcontent");
		  for (i = 0; i < tabcontent.length; i++) {
		    tabcontent[i].style.display = "none";
		  }
		  tablinks = document.getElementsByClassName("tablinks");
		  for (i = 0; i < tablinks.length; i++) {
		    tablinks[i].className = tablinks[i].className.replace(" active", "");
		  }
		  document.getElementById(order).style.display = "block";
		  evt.currentTarget.className += " active";
		}
		
		function selectMovieOrder(scheduleIdx){
			location.href="${ctp}/SeatSelectPage.res?scheduleIdx="+scheduleIdx+"&totSeat=${vos[0].seat}&theaterName=${param.theaterName}";
		}
			
		
		// Get the element with id="defaultOpen" and click on it
		$(function(){
			// 윈도우 로드 시 1회차 클릭
			document.getElementById("order1").click();
		})
		
	</script>
</head>
<body>
<p><br/></p>
	<div class="tab">
	  <c:forEach var="vo" items="${vos}">
	  	<button class="tablinks text-center" onclick="openCity(event, 'orderChk${vo.screenOrder}','${vo.idx}')" id="order${vo.screenOrder}">
	  		${vo.screenOrder}회차 (${fn:substring(vo.startTime,0,5)})
	  	</button>
	  </c:forEach>
	</div>

	<c:forEach var="vo" items="${vos}" >
		<div id="orderChk${vo.screenOrder}" class="tabcontent">
		  <h3>${param.title} ${vo.screenOrder}회차 좌석 리스트</h3>
		  <div id="scheduleList_${vo.idx}"></div>
		  <button type="button" onclick="selectMovieOrder('${vo.idx}')">${vo.screenOrder} 회차 예약</button>
		</div>
	</c:forEach>
	
	<div></div>
<p><br/></p>
</body>
</html>