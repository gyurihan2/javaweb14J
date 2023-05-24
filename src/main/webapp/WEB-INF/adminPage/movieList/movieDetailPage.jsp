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
	<script>
		'use strict';
		
		// 수정 처리
		function submitOk(){
			//유효성/정규식 체크 필요
			
			myform.submit();
		

		}
		$(function(){
			 opener.location.reload();
		});
	</script>
</head>
<body>
<p><br/></p>
<div class="container">
	<form method="post" action="${ctp}/MovieUpdateOk.ad" name="myform" id="myform" class="was-validated bordered">
  	<div class="modal-body row justify-content-center">
    	<div class="input-group mb-3">
				<div class="input-group-prepend">
		    	<span class="input-group-text">영화코드</span>
				</div>
	      <input type="text" class="form-control" name="idx" id="idx" placeholder="영화코드를 입력하세요" value="${vo.idx}" readonly/>
	      <div class="input-group-prepend">
  				<span class="input-group-text">영화제목</span>
				</div>
			 	<input type="text" class="form-control" name="title" id="title" placeholder="영화제목 입력하세요" value="${vo.title}">
			</div>
			
	 		<div class="input-group mb-3">
  			<div class="input-group-prepend">
    			<span class="input-group-text">등록된 포스터</span>
  			</div>
  			<div>
  				<c:set var="images" value="${fn:split(vo.images,'/')}"/>
  				<c:set var="imgFNames" value="${fn:split(vo.imgFName,'/')}"/>
  				<c:forEach var="imgSrc" items="${imgFNames}" varStatus="st">
  					<div class=" float-right mr-2">
			  			<img src="${ctp}/images/movieChart/${imgSrc}" width="75px" style="display:inline">
		  				<div class="custom-control custom-radio">
						    <input type="radio" class="custom-control-input" id="customRadio${st.index}" name="mainImg" <c:if test="${vo.mainImg == imgFNames[st.index]}">checked</c:if>  value="${imgFNames[st.index]}">
						    <label class="custom-control-label" for="customRadio${st.index}"><font size="0.7em">${imgFNames[st.index]}</font></label>
						  </div>
					  </div>
  				</c:forEach>
  			</div>
			</div>
		  <div id="fileBoxAppend"></div>
  		<div class="imgDemo" id="imgDemo"></div>
	 		<div class="input-group mb-3">
				<div class="input-group-prepend mr-1">
  				<span class="input-group-text">장르</span>
				</div>
				<c:set var="genreArr" value="${fn:split('액션/로맨스/코미디/만화/공포/드라마/SF/판타지/재난/다큐','/') }"/>
				<c:forEach var="tempGenre" items="${genreArr}" varStatus="st">
					<div class="form-check-inline">
					  <label class="form-check-label">
			    	<input type="checkbox"  name= "genre" value="${tempGenre}" <c:if test="${fn:contains(vo.genre,genreArr[st.index]) }">checked</c:if> />${tempGenre}
			    	 </label>
			    </div>
		    </c:forEach>
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
  				<span class="input-group-text">상영시간</span>
				</div>
			 	<input type="number" class="form-control" name="playTime" id="playTime" placeholder="상영시간을 입력하세요" value="${vo.playTime}">
			 	<div class="input-group-prepend">
  				<span class="input-group-text">개봉일</span>
				</div>
			 	<input type="date" class="form-control" name="openDate" id="openDate" value="${vo.openDate}">
			</div>
			
			<div class="input-group mb-3">
				<div class="input-group-prepend">
  				<span class="input-group-text">감독</span>
				</div>
			 	<input type="text" class="form-control" name="director" id="director" value="${vo.director}">
				<div class="input-group-prepend">
  				<span class="input-group-text">배우</span>
				</div>
			 	<input type="text" class="form-control" name="actor" id="actor" value="${vo.actor}">
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
  				<span class="input-group-text">제작국가</span>
				</div>
			 	<input type="text" class="form-control" name="nation" id="nation" value="${vo.nation}">
			 	<div class="input-group-prepend">
  				<span class="input-group-text">관람등급</span>
				</div>
				
			 	<select name="grade" class="custom-select">
			    <option value="All" <c:if test="${vo.grade == 'All' }">selected</c:if>>All</option>
			    <option value="12" <c:if test="${vo.grade == '12' }">selected</c:if>>12</option>
			    <option value="15" <c:if test="${vo.grade == '15' }">selected</c:if>>15</option>
			    <option value="19" <c:if test="${vo.grade == '19' }">selected</c:if>>19</option>
			  </select>
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
  				<span class="input-group-text">소개</span>
				</div>
			 	<textarea class="form-control" name="content" id="content" rows="10">${vo.content }</textarea>
			</div>
			<input type="button" onclick="submitOk()" value="수정하기" class="btn btn-info mr-2"/>
			<input type="button" onclick="window.close();" value="취소" class="btn btn-danger"/>
			<input type="hidden" value="${param.idx}" name="idx" />
		</div>
	</form>
</div>
<p><br/></p>
</body>
</html>