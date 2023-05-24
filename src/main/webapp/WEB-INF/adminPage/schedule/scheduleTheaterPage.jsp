<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>사용 가능한 상영관</title>
	<jsp:include page="/include/bs4.jsp"/>
	<script>
		'use strict';
		
		// 선택한 상영관의 idx와 name을 부모창으로 전달 후 close
		function theaterSelect(idx,name){
			$("#theaterIdx", opener.document).val(idx);
			$("#theaterName", opener.document).val(name);
			
			window.close();
		}
	</script>
</head>
<body>
<p><br/></p>
<div class="container">
	<c:if test="${empty vos }">
		사용 가능한 상영관이 없습니다.<br/>
		일정표를 확인하세요
	</c:if>
	<c:if test="${!empty vos }">
		<table class="table text-center">
	    <tr class="table-dark text-dark">
	      <th scope="col">상영관 이름</th>
	      <th scope="col">테마</th>
	      <th scope="col">좌석수</th>
	      <th scope="col">입장료</th>
	      <th scope="col">개방여부</th>
	      <th scope="col">비고</th>
	    </tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
			    <tr>
			      <td>${vo.name}</td>
			      <td>${vo.thema }</td>
			      <td>${vo.seat}</td>
			      <td>${vo.price}</td>
			      <td>${vo.work}</td>
			      <td>
			      	<input type="button" value="선택" onclick="theaterSelect('${vo.idx}','${vo.name}')"/>
			      </td>
			    </tr>
		</c:forEach>
		</table>
	</c:if>
</div>
<p><br/></p>
</body>
</html>