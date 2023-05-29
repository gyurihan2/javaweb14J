<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>title</title>
	<jsp:include page="/include/bs4.jsp" />
	<style>
	body {font-family: Arial;}
	
	/* Style the tab */
	.tab {
	  overflow: hidden;
	  border: 1px solid #ccc;
	  background-color: #f1f1f1;
	}
	
	/* Style the buttons inside the tab */
	.tab button {
	  background-color: inherit;
	  float: left;
	  border: none;
	  outline: none;
	  cursor: pointer;
	  padding: 14px 16px;
	  transition: 0.3s;
	  font-size: 17px;
	}
	
	/* Change background color of buttons on hover */
	.tab button:hover {
	  background-color: #ddd;
	}
	
	/* Create an active/current tablink class */
	.tab button.active {
	  background-color: #ccc;
	}
	
	/* Style the tab content */
	.tabcontent {
	  display: none;
	  padding: 6px 12px;
	  border: 1px solid #ccc;
	  border-top: none;
	}
	
	/* 영화 리스트 */
		.column {
	  float: left;
	  width: 230px;
	  margin-bottom: 16px;
	  padding: 0 8px;
	}
	
	.card {
	  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
	}
	
	.container {
	  padding: 0 16px;
	}
	
	.container::after, .row::after {
	  content: "";
	  clear: both;
	  display: table;
	}
	
	.title {
	  color: grey;
	}
	
	.button {
	  border: none;
	  outline: 0;
	  display: inline-block;
	  padding: 8px;
	  color: white;
	  background-color: #000;
	  text-align: center;
	  cursor: pointer;
	  width: 100%;
	}
	
	.button:hover {
	  background-color: #555;
	}
	</style>
	<script>
	function openCity(evt, playDate) {
	  var i, tabcontent, tablinks;
	  tabcontent = document.getElementsByClassName("tabcontent");
	  
	  // 상영관 별 상여중인 영화 리스트 출력
	  $.ajax({
		  url:"${ctp}/ScheduelMoiveChk.res",
			type:"post",
			data:{
				playDate:playDate
			},
			success:function(res){
				
				$("#movieList_"+playDate).empty();
				let js = JSON.parse(res);
				
				let str="";
				for(let i=0; i<js.length; i++){
					str +="<div class='column'>";
					str +="<div class='card'>";
					str +="<img src='${ctp}/images/movieChart/"+js[i].mainImg+"' style='width:100%'>";
					str +="<div class='container'>";
					str +="<hr/><h5 class='text-center'>"+js[i].theaterName+"</h5>";
					str +="<div class='text-center'>"+js[i].title+"</div><hr/>";
					str +="<p><button type='button' class='button' name='reserMovie' value='"+playDate+"/"+js[i].theaterName+"/"+js[i].title+"'>예매하기</button></p>";
					str +="</div></div></div>";
				}
				$("#movieList_"+playDate).append(str);
			},
			error:function(){
				alert("전송 실패");
				return false;
			}
	  });
	  
	  // 예매하기 클릭 버튼
		$(document).on("click","button[name=reserMovie]",function(){
			// 0: playDate 1: theaterName 2:title
			let arr = $(this).val().split("/");
			console.log(arr);
			let url="http://localhost:9090${ctp}/ReservationMoive.res?playDate="+arr[0]+"&theaterName="+arr[1]+"&title="+arr[2];
			window.open(url,'영화 예매','width=1000px,height=700px,location=no');
	  });
	 
	 
	  
	  for (i = 0; i < tabcontent.length; i++) {
	    tabcontent[i].style.display = "none";
	  }
	  tablinks = document.getElementsByClassName("tablinks");
	  for (i = 0; i < tablinks.length; i++) {
	    tablinks[i].className = tablinks[i].className.replace(" active", "");
	  }
	  document.getElementById(playDate).style.display = "block";
	  evt.currentTarget.className += " active";
	}
</script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">
	<h3>영화 예약 페이지</h3>
	
	<div class="tab">
		<c:forEach var="playDate" items="${reservationDate}">
		  <button class="tablinks" onclick="openCity(event, '${playDate}')">${playDate}</button>
		</c:forEach>
	</div>
	<c:forEach var="playDate" items="${reservationDate}">
	 <div id="${playDate}" class="tabcontent ml-3">
		  <div class="row" id="movieList_${playDate}">
		  </div>
		</div>
	</c:forEach>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>