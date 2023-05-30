<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>title</title>
	<jsp:include page="/include/bs4.jsp"/>
	<style>
	a{
  	text-decoration: none;
	}
    #td1,#td8,#td15,#td22,#td29,#td36 {color:red}
    #td7,#td14,#td21,#td28,#td35 {color:blue}
    .today {
      background-color: skyblue;
      color: #fff;
      font-weight: bolder;
    }
  </style>
  <script>
  	'use script';
  	
  	// 상영관 검색
  	function theaterSearch(){
  		let startDate = $("#startDate").val();
  		let endDate = $("#endDate").val();
  		
  		if(startDate == ""){
  			alert("상영 시작 일자를 선택 하세요");
  			return false;
  		}
  		else if(endDate==""){
  			alert("상영 종료 일자를 선택 하세요");
  		}
  		
  		let url="${ctp}/ScheduleTheater.ad?startDate="+startDate+"&endDate="+endDate;
  		window.open(url,'상영관 스케줄','width=1000px,height=700px');
  	}
  	
  	// 영화 검색
  	function MovieSearch(){
  		
  		let startDate = $("#startDate").val();
  		if(startDate == ""){
  			alert("상영 시작 일자를 선택 하세요");
  			return false;
  		}
  		
  		let url="${ctp}/MovieListPage.ad?startDate="+startDate;
  		window.open(url,'영화 조회','width=1000px,height=700px');
  	}
  	
	 	// 동적폼(일정추가)
		function orderAdd(){
			let cnt = $("input[name=order]").length;
			let playTime = Number($("#moviePlayTime").val());
			
			// 영화 조회 확인
			let movieStatus = $("#movieName").val();
			if(movieStatus==""){
				alert("영화조회를 먼저 하세요");
				return false;
			}
			
			// 상영시간 10분 단위로 세팅
			if(playTime%10 != 0){
				playTime = playTime+(10-(playTime%10));
			}
			
			// 이전 시간 값 
			let orderval = $("#order"+cnt).val();
		
			if(orderval==""){
				alert("이전 일정의 시간을 정하세요");
				return false;
			}
			
			// 시간 계산을 위한 값 세팅
			let date = new Date('2012-05-17 '+ orderval);
			
			
			// 다음 영화 상영될 시간의 min값 
			date.setMinutes(date.getMinutes() + playTime+5);
			let nextOrderMinTime = date+"";
			
			nextOrderMinTime = nextOrderMinTime.substring(16,21);
			
			// 다음 영화 상영될 시간 + 휴게시간(5+15분)
			date.setMinutes(date.getMinutes() +15);
			let nextOrderTime = date+"";
			
			nextOrderTime = nextOrderTime.substring(16,21);
			
			cnt++;
			
			let fileBox = '';
			fileBox += '<div id="fBox'+cnt+'" class="input-group">';
			fileBox += '<input type="time" name="order" id="order'+cnt+'" min='+nextOrderMinTime+' value='+nextOrderTime+' class="form-control border mb-2 mr-2" style="width:70%" required/>';
			fileBox += '<input type="button" value="삭제" onclick="deleteBox('+cnt+')" class="btn-danger btn-sm" style="float:left;"/>';
			fileBox += '</div>';
			$("#orderAppend").append(fileBox);
		
		}
		//추가된 파일박스 삭제 처리( 중간 삭제 시 시간 세팅 안됨 - > 처리 필요)
		function deleteBox(cnt){
			
			$("#fBox"+cnt).remove();
			$("#img"+cnt).remove();
			
		}
		// 해당일의 버튼 클릭시 상영관 정보 및 상영중인 영화 및 일정 확인
		function scheduleTheaterChk(theaterName,playDate){
			let url="{ctp}/ScheduleTheaterChkPage.ad?theaterName="+theaterName+"&playDate="+playDate;
	  	window.open(url,'상영관 일정 확인','width=1000px,height=700px');
		}
  	
		$(function(){
			// 상영 일 날짜 보다 이전 날짜 선택 X
			 $("#startDate").change(function(){
				$("#endDate").prop("min", $("#startDate").val());
			  });
			
		});
  </script>
</head>
<body>
<jsp:include page="/include/side_nav.jsp"/>
<p><br/></p>

<div class="content">
	<div class="continer">
		<h3>영화 상영 일정표</h3>
		<div class="text-center">
		  <button type="button" onclick="location.href='${ctp}/ScheduleMgmtPage.ad?yy=${yy-1}&mm=${mm}';" class="btn btn-secondary btn-sm" title="이전년도">◁◁</button>
		  <button type="button" onclick="location.href='${ctp}/ScheduleMgmtPage.ad?yy=${yy}&mm=${mm-1}';" class="btn btn-secondary btn-sm" title="이전월">◀</button>
		  <font size="5">${yy}년 ${mm+1}월</font>
		  <button type="button" onclick="location.href='${ctp}/ScheduleMgmtPage.ad?yy=${yy}&mm=${mm+1}';" class="btn btn-secondary btn-sm" title="다음월">▶</button>
			<button type="button" onclick="location.href='${ctp}/ScheduleMgmtPage.ad?yy=${yy+1}&mm=${mm}';" class="btn btn-secondary btn-sm" title="다음년도">▷▷</button>
			&nbsp;&nbsp;
			<button type="button" onclick="location.href='${ctp}/ScheduleMgmtPage.ad';" class="btn btn-secondary btn-sm" title="오늘날짜">홈</button>
  </div>
  <div class="text-center container">
			<input type="button" value="일정 추가" class="btn btn-success btn-sm border"  style="float:right;" data-toggle="modal" data-target="#ScheduleInsertModal"/>
    <table class="table table-bordered mt-2">
      <tr class="table-dark text-dark">
        <th style="width:14%; vertical-align:middle; color:red">일</th>
        <th style="width:14%; vertical-align:middle;">월</th>
        <th style="width:14%; vertical-align:middle;">화</th>
        <th style="width:14%; vertical-align:middle;">수</th>
        <th style="width:14%; vertical-align:middle;">목</th>
        <th style="width:14%; vertical-align:middle;">금</th>
        <th  style="width:14%; vertical-align:middle; color:blue">토</th>
      </tr>
      <tr>
      	<!-- 시작월 이전의 공백을 이던달의 날짜로 채워준다. -->
      	<c:set var="gap" value="${1}"/>
      	<c:forEach var="prevDay" begin="${preLastDay - (startWeek - 2)}" end="${preLastDay}" varStatus="st">
      	  <td style="color:#ccc;font-size:0.6em; text-align:left;">${prevYear}-${prevMonth+1}-${prevDay}</td>
	      	<c:set var="gap" value="${gap + 1}"/>
      	</c:forEach>
      	
      	<!-- 해당월에 대한 첫째주 날짜부터 출력하되, gap이 7이되면 줄바꿈한다. -->
      	<c:forEach begin="1" end="${lastDay}" varStatus="st">
      	  <c:set var="todaySw" value="${toYear==yy && toMonth==mm && toDay==st.count ? 1 : 0}" />
      	  <td id="td${gap}" ${todaySw==1 ? 'class=today' : ''} style="text-align:left">
      	  <c:set var="ymd" value="${yy}-${mm+1}-${st.count}"/>
      	  <a href="${ctp}/ScheduleDetailPage.ad?ymd=${ymd}">${st.count}</a><br/>
      	  	<!-- 해당 날짜에 일정이 있다면 상영관을 출력하게한다. -->
      	  	<c:forEach var ="vo" items="${vos}">
      	  		<c:if test="${fn:substring(vo.playDate,8,10) == st.count}">
      	  			<!-- 구분자 '/' 기준으로 분리 -->
      	  			<c:set var="name" value="${fn:split(vo.theaterName,'/')}"/>
      	  				<c:forEach var="temp" items="${name}">
      	  					<c:if test="${toYear > yy}" >
      	  						<span style="background-color:#9D968F;" class="badge btn" onclick="scheduleTheaterChk('${temp}','${vo.playDate}')"><font color="#212121">${temp}</font></span>
      	  					</c:if>
      	  					<c:if test="${toYear == yy}">
      	  						<c:if test="${toMonth > mm}">
      	  							<span style="background-color:#9D968F;" class="badge btn" onclick="scheduleTheaterChk('${temp}','${vo.playDate}')"><font color="#212121">${temp}</font></span>
      	  						</c:if>
      	  						<c:if test="${toMonth == mm}">
		      	  					<c:if test="${toDay > st.count }">
			      	  					<span style="background-color:#9D968F;" class="badge btn" onclick="scheduleTheaterChk('${temp}','${vo.playDate}')"><font color="#212121">${temp}</font></span>
		      	  					</c:if>
		      	  					<c:if test="${toDay == st.count }">
			      	  					<span class="badge bg-success btn" onclick="scheduleTheaterChk('${temp}','${vo.playDate}')"><font color="#212121">${temp}</font></span>
		      	  					</c:if>
		      	  					<c:if test="${toDay < st.count }">
			      	  					<span style="background-color:#7D9FDB;" class="badge btn" onclick="scheduleTheaterChk('${temp}','${vo.playDate}')"><font color="#212121">${temp}</font></span>
		      	  					</c:if>
      	  						</c:if>
      	  						<c:if test="${toMonth < mm}">
      	  							<span style="background-color:#7D9FDB;" class="badge btn" onclick="scheduleTheaterChk('${temp}','${vo.playDate}')"><font color="#212121">${temp}</font></span>
      	  						</c:if>
      	  					</c:if>
      	  					<c:if test="${toYear < yy}" >
      	  						<span style="background-color:#7D9FDB;" class="badge btn" onclick="scheduleTheaterChk('${temp}','${vo.playDate}')"><font color="#212121">${temp}</font></span>
      	  					</c:if>
      	  				</c:forEach>
      	  		</c:if>
      	  	</c:forEach>
      	  	
      	  </td>
      	  <c:if test="${gap % 7 == 0}"></tr><tr></c:if>
      	  <c:set var="gap" value="${gap + 1}"/>
      	</c:forEach>
      	<!-- 마지막일 이후를 다음달의 시작일자부터 채워준다. -->
      	<c:forEach var="nextDay" begin="${nextStartWeek}" end="7" varStatus="st">
      		<td style="color:#ccc;font-size:0.6em; text-align:left;">${nextYear}-${nextMonth+1}-${st.count}</td>
      	</c:forEach>
      </tr>
    </table>
  </div>
	</div>
</div>
<p><br/></p>
<!-- 일정 추가 Modal -->
<div class="modal fade" id="ScheduleInsertModal">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">일정 추가</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
      <!-- Modal body -->
			<form method="post" action="${ctp}/ScheduleInsertOk.ad" name="myform" id="myform">
      	<div class="modal-body row justify-content-center">
	      	<div class="input-group mb-3">
    				<div class="input-group-prepend">
				    	<span class="input-group-text">상영 시작일</span>
    				</div>
    				<c:if test="${toMonth+1<10}"><c:set var="strToMonth" value="0${toMonth+1}"/></c:if>
    				<c:set var="today" value="${toYear}-${strToMonth}-${toDay}"/>
			      <input type="date" class="form-control" name="startDate" id="startDate" min="${today}" required/>
    				<div class="input-group-prepend">
				    	<span class="input-group-text">상영 종료일</span>
    				</div>
			      <input type="date" class="form-control" name="endtDate" id="endDate" required/>
	  			</div>
	      	<div class="input-group mb-3">
    				<div class="input-group-prepend">
				    	<span class="input-group-text">상영관</span>
    				</div>
			      <input type="text" class="form-control" name="theaterName" id="theaterName" placeholder="상영관 조회를 하세요" readonly required/>
			      <input type="hidden" class="form-control" name="theaterIdx" id="theaterIdx"/>
					 	<input type="button" class="btn btn-info btn-sm" value="상영관 조회" onclick="theaterSearch()">
    				<div class="input-group-prepend">
				    	<span class="input-group-text">영화</span>
    				</div>
			      <input type="text" class="form-control" name="movieName" id="movieName" placeholder="영화 조회를 하세요" readonly required/>
			      <input type="hidden" class="form-control" name="movieIdx" id="movieIdx"/>
			      <input type="hidden" class="form-control" name="moviePlayTime" id="moviePlayTime"/>
					 	<input type="button" class="btn btn-info btn-sm" value="영화 조회" onclick="MovieSearch()">
	  			</div>
	      	<div class="input-group mb-3">
    				<div class="input-group-prepend">
				    	<span class="input-group-text">상영 일정 설정</span>
    				</div>
			      <input type="time" class="form-control" name="order" id="order1" required/>
					 	<input type="button" class="btn btn-success btn-sm" value="일정 추가" onclick="orderAdd()">
	  			</div>
					<div id="orderAppend"></div>
	 			</div>
	 			<input type="submit"  value="등록" class="btn btn-primary form-control"/>
			</form>
     	<!-- Modal footer --> 
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="location.reload();">Close</button>
			</div>
		</div>
	</div>
</div>
</body>
</html>