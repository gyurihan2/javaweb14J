<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>title</title>
	<jsp:include page="/include/bs4.jsp"/>
	<script>
		'use strict';
		
		// 페이지 사이즈 변경
		function pageCheck() {
			let pageSize = $("#pageSize").val();
			location.href = "${ctp}/MovieListPage.ad?pag=1&pageSize="+pageSize+"&startDate=${param.startDate}";
		}
		
		function selectMovie(idx,title,playTime){
			$("#movieName", opener.document).val(title);
			$("#movieIdx", opener.document).val(idx);
			$("#moviePlayTime", opener.document).val(playTime);
			
			window.close();
		}

		jQuery(function(){
			// 이동 페이지가 총 페이지보다 클 경우 마지막 페이지로
			if(${totPage} < ${pag}){
				let pageSize = document.getElementById("pageSize").value;
				location.href = "${ctp}/MovieListPage.ad?pag=${totPage}&pageSize="+pageSize+"&startDate=${param.startDate}";
			}
			
		 });
	</script>
</head>
<body>

<p><br/></p>
<div class="container">
	<h3>영화 리스트</h3>
		<table class="table table-boderless">
		<tr>
			<td>
	    	<select name="pageSize" id="pageSize" onchange="pageCheck()">
		    		<option <c:if test="${pageSize==5}">selected</c:if>>5</option>
		    		<option <c:if test="${pageSize==10}">selected</c:if>>10</option>
		    		<option <c:if test="${pageSize==30}">selected</c:if>>30</option>
		    		<option <c:if test="${pageSize==50}">selected</c:if>>50</option>
	    	</select> 건
    		</td>
		</tr>
	</table>
	<table class="table table-hover text-center">
			<tr class="table-dark text-dark">
				<th></th>
				<th>영화 코드</th>
				<th>영화 제목</th>
				<th>장르</th>
				<th>등급</th>
				<th>개봉일</th>
				<th>비고</th>
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td>
							<img src="${ctp}/images/movieChart/${vo.mainImg}" width="75px">
					</td>
					<td>
						${vo.idx}
					</td>
					<td>${vo.title}</td>
					<td>${vo.genre}</td>
					<td>${vo.grade}</td>
					<td>${vo.openDate}</td>
					<td>
						<input type="button" value="선택" class="btn btn-warning btn-sm" onclick="selectMovie('${vo.idx}','${vo.title}','${vo.playTime}')"/>
					</td>
				</tr>
			</c:forEach>
			<tr><td colspan="6" class="m-0 p-0"></td></tr>
		</table>
		<!-- 블록 페이징 -->
		<div class="text-center">
	  	<ul class="pagination justify-content-center pagination-sm">
		  	<c:if test="${curBlock*pageSize > 1}">
		  		 <li class="page-item"><a class="page-link text-secondary" href="${ctp}/MovieListPage.ad?pageSize=${pageSize}&pag=1&startDate=${param.startDate}">첫페이지</a></li>
		  	</c:if>
		  	<c:if test="${curBlock > 0 }">
		  		 <li class="page-item"><a class="page-link text-secondary" href="${ctp}/MovieListPage.ad?pageSize=${pageSize}&pag=${((curBlock-1)*blockSize)+blockSize}&startDate=${param.startDate}">이전블록</a></li>
		  	</c:if>
		  	<c:forEach var="i" begin="${curBlock*blockSize+1}" end="${curBlock*blockSize+ blockSize}" varStatus="st">
		  		<c:if test="${i<=totPage && i==pag}">
		  			 <li class="page-item active"><a class="page-link text-white bg-secondary">${i}</a></li>
		  		</c:if>
		  		<c:if test="${i<=totPage && i!=pag}">
		  			 <li class="page-item"><a class="page-link text-secondary" href="${ctp}/MovieListPage.ad?pageSize=${pageSize}&pag=${i}&startDate=${param.startDate}">${i}</a></li>
		  		</c:if>
		  	</c:forEach>
		  	<c:if test="${curBlock < lastBlock }">
		  		 <li class="page-item"><a class="page-link text-secondary" href="${ctp}/MovieListPage.ad?pageSize=${pageSize}&pag=${((curBlock+1)*blockSize)+1}&startDate=${param.startDate}">다음블록</a></li>
		  	</c:if>
		  	<c:if test="${(curBlock+1)*pageSize < totPage}">
		  		 <li class="page-item"><a class="page-link text-secondary" href="${ctp}/MovieListPage	.ad?pageSize=${pageSize}&pag=${totPage}&startDate=${param.startDate}">마지막 페이지</a></li>
		  	</c:if>
	  	</ul>
		</div>
</div>

<p><br/></p>
</body>
</html>