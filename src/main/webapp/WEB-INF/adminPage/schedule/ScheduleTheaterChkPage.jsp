<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="today" value="<%=new java.util.Date()%>" />
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>상영관 상세 일정 보기</title>
	<jsp:include page="/include/bs4.jsp"/>
	 <style>
	 
		.star{
		
		position: relative;
		font-size: 20px;
		color: #ddd;
		}

		.star span {
		width: 0;
		position: absolute;
		left: 0;
		color: rgb(230, 230, 19);
		overflow: hidden;
		pointer-events: none;
		}
		#movieTable th{
			text-align:right;
		}
  </style>

</head>
<body>
<p><br/></p>
<c:set var="playDateArr" value="${fn:split(vos[0].playDate,'-')}"></c:set>
<hr/>
<h4 class="text-center">${playDateArr[0]}년${playDateArr[1]}월${playDateArr[2]}일 <font color="#567795">${vos[0].theatherName}</font> 상세 일정</h4>
<hr/>
<div class="container">
	<div class="row justify-content-center">
		<img src="${ctp}/images/movieChart/${vos[0].movieMainImg}" width="150px" class="center-block">
		<div>
			<table class="ml-2 text-center" id="movieTable">
				<tr>
					<th>영화 제목: </th>
					<td colspan="2">${vos[0].movieTitle}</td>
				</tr>
				<tr>
					<th>상영시간: </th>
					<td colspan="2">${vos[0].moviePlayTime}분</td>
				</tr>
				<tr>
					<th>누적 관객수: </th>
					<td colspan="2">${vos[0].totalView} 명</td>
				</tr>
				<tr>
					<th>평점 : </th>
					<td>
						<span class="star">★★★★★
		        	<span style="width:${vos[0].movieRating*20}%">★★★★★</span>
	    			</span>
					</td>
					<td>
						(${vos[0].movieRating})
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="continer">
		<table class="modal-dialog table table-hover table-border table-striped text-center" style="width: 500px">
			<tr class="text-dark table-dark">
				<th>순서</th>
				<th>상영 시작 시간</th>
				<th>상영 종료 시간</th>
				<th>상태</th>
			</tr>
			<!-- 참고:https://ifuwanna.tistory.com/22 -->
			<!-- 오늘 날짜 + 시간 -->
			<fmt:formatDate var="chkToday" value="${today}" pattern="yyyy-MM-dd"/>
			<fmt:formatDate var="chkTime" value="${today}" pattern="HH:mm:ss"/>
			
			<!-- 시간 기준이 1970-01-01 00:00:00 이므로 임으로 스트링으로 변환후 다시 오늘 날짜 기준으로 변환 09:00:00이 0ms -->
			<c:set var="chkTimeStr" value="${chkTime}"/>
			<fmt:parseDate var="chkTimeStr_d" value="${chkTimeStr}" pattern="HH:mm:ss"/>
			<fmt:parseNumber var="chkTimeStr_n" value="${chkTimeStr_d.time/(1000*60)}" integerOnly="true"/>
			
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<!-- 시작/종료 시간 -> 분 변환 -->
				<fmt:parseDate var="startTime_D" value="${vo.startTime}"  pattern="HH:mm:ss"/>
				<fmt:parseNumber var="startTime_N" value="${(startTime_D.time)/(1000*60)}" integerOnly="true" />
				<c:if test="${vo.moviePlayTime%10 != 0}"><c:set var="setMoiveTime" value="${vo.moviePlayTime+(10-vo.moviePlayTime%10)}"/></c:if>
				<c:if test="${vo.moviePlayTime%10 == 0}"><c:set var="setMoiveTime" value="${vo.moviePlayTime}"/></c:if>
				<fmt:parseNumber var="endTime_N" value="${(startTime_D.time + setMoiveTime*60*1000)/(1000*60)}" integerOnly="true" />
				<fmt:parseNumber var="breakTime_N" value="${(startTime_D.time + (setMoiveTime+20)*60*1000)/(1000*60)}" integerOnly="true" />
				
				<!-- 종료 시간 시:분 변환(초는 00로)-->
				<fmt:parseNumber var="endTimeHour" value="${(endTime_N+540)/60}" integerOnly="true"/>
				<c:if test="${endTimeHour > 24}"> <c:set var="endTimeHour" value="${endTimeHour-24}"/></c:if>
				<fmt:parseNumber var="endTimeMin" value="${(endTime_N+540)%60}" integerOnly="true"/>
				<fmt:formatNumber var="endTimeHour_f" value="${endTimeHour}"  minIntegerDigits="2" />
				<fmt:formatNumber var="endTimeMin_f" value="${endTimeMin}"  minIntegerDigits="2" />
				<%--현재시간: ${chkTimeStr_n}
						시작시간: ${startTime_N}
						종료시간: ${endTime_N }
						휴식시간: ${breakTime_N } --%>
				<tr>
					<td>${st.count}</td>
					<td>${vo.startTime}</td>
					<td>${endTimeHour_f}:${endTimeMin_f}:00</td>
					<td>
						<fmt:parseDate var="selectDay" value="${vo.playDate}" pattern="yyyy-mm-dd"/>
						<!-- 현재 날짜 기준 이전 -->
						<c:if test="${chkToday > vo.playDate}">
							<font color="#DF6464"><b>상영완료</b></font>
						</c:if>
						<!-- 현재 날짜 기준 이후 -->
						<c:if test="${chkToday < vo.playDate}">
							<font color="#C9BC46"><b>상영 준비중</b></font>
						</c:if>
						
						<!-- 현재 날짜 기준 같을떄 -->
						<c:if test="${chkToday == vo.playDate}">
							<c:if test="${endTime_N < chkTimeStr_n}"><font color="#DF6464"><b>상영 종료</b></font></c:if>
							<c:if test="${startTime_N <= chkTimeStr_n && chkTimeStr_n < endTime_N}">
								<font color="#3CB371"><b>상영중</b></font>
							</c:if>
							<c:if test="${endTime_N < chkTimeStr_n && chkTimeStr_n < breakTime_N}">
								<font color="#C9BC46"><b>BreakTime</b></font>
							</c:if>
							<c:if test="${startTime_N > chkTimeStr_n }">
								<font color="#C9BC46"><b>상영 대기중</b></font>
							</c:if>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>		
	</div>
		
</div>
<p><br/></p>
</body>
</html>