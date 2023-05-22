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
	<script>
		'use strict';
		
		 function imgCheck(input) {
    	if(input.files && input.files[0]) {
    		let reader = new FileReader();
    		reader.onload = function(e) {
    			document.getElementById("demo").src = e.target.result;
    		}
    		reader.readAsDataURL(input.files[0]);
    	}
    	else {
    		document.getElementById("demo").src = "";
    	}
    }
	</script>
</head>
<body>
<jsp:include page="/include/side_nav.jsp"/>
<p><br/></p>
<div class="content">
	<div class="container">
		<h3>영화 관리</h3>
		<input type="button" value="영화 추가" class="btn btn-info btn-sm float-right" data-toggle="modal" data-target="#movieInsertModal"/>
	
	</div>
</div>
<p><br/></p>
<!-- 영화 추가 Modal -->
<div class="modal fade" id="movieInsertModal">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">영화 추가</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
      <!-- Modal body -->
			<form method="post" action="${ctp}/movieInsertOk.ad" name="myform" id="myform" class="was-validated bordered" enctype="multipart/form-data">
      	<div class="modal-body row justify-content-center">
	      	<div class="input-group mb-3">
    				<div class="input-group-prepend">
				    	<span class="input-group-text">영화코드</span>
    				</div>
			      <input type="text" class="form-control" name="idx" id="idx" placeholder="영화코드를 입력하세요" required />
			      <div class="input-group-prepend">
      				<span class="input-group-text">영화제목</span>
    				</div>
					 	<input type="text" class="form-control" name="title" id="title" placeholder="영화제목 입력하세요">
	  			</div>
					
			 		<div class="input-group mb-3">
	    			<div class="input-group-prepend">
	      			<span class="input-group-text">메인이미지</span>
	    			</div>
	    			<input type="file" name="posterImg" id="posterImg" onchange="imgCheck(this)" class="mb-2" />
	    			<div class="input-group-prepend">
	      			<span class="input-group-text">이미지</span>
	    			</div>
	    			<input type="file" name="img" id="img" onchange="imgCheck(this)" class="mb-2" multiple/>
  	  			<div><img id="demo" width="150px"/></div>
	  			</div>
			 		<div class="input-group mb-3">
						<div class="input-group-prepend mr-1">
		  				<span class="input-group-text">장르</span>
						</div>
					 	<div class="form-check-inline">
						  <label class="form-check-label">
						    <input type="checkbox" class="form-check-input" value="">액션
						  </label>
						</div>
						<div class="form-check-inline">
						  <label class="form-check-label">
						    <input type="checkbox" class="form-check-input" value="">로맨스
						  </label>
						</div>
						<div class="form-check-inline">
						  <label class="form-check-label">
						    <input type="checkbox" class="form-check-input" value="">코미디
						  </label>
						</div>
						<div class="form-check-inline">
						  <label class="form-check-label">
						    <input type="checkbox" class="form-check-input" value="">만화
						  </label>
						</div>
						<div class="form-check-inline">
						  <label class="form-check-label">
						    <input type="checkbox" class="form-check-input" value="">공포
						  </label>
						</div>
						<div class="form-check-inline">
						  <label class="form-check-label">
						    <input type="checkbox" class="form-check-input" value="">드라마
						  </label>
						</div>
						<div class="form-check-inline">
						  <label class="form-check-label">
						    <input type="checkbox" class="form-check-input" value="">SF
						  </label>
						</div>
						<div class="form-check-inline">
						  <label class="form-check-label">
						    <input type="checkbox" class="form-check-input" value="">판타지
						  </label>
						</div>
						<div class="form-check-inline">
						  <label class="form-check-label">
						    <input type="checkbox" class="form-check-input" value="">재난
						  </label>
						</div>
						<div class="form-check-inline">
						  <label class="form-check-label">
						    <input type="checkbox" class="form-check-input" value="">다큐
						  </label>
						</div>
					</div>
					<div class="input-group mb-3">
	  				<div class="input-group-prepend">
	    				<span class="input-group-text">상영시간</span>
	  				</div>
					 	<input type="number" class="form-control" name="playTime" id="playTime" placeholder="상영시간을 입력하세요">
					 	<div class="input-group-prepend">
	    				<span class="input-group-text">개봉일</span>
	  				</div>
					 	<input type="date" class="form-control" name="openDate" id="openDate">
					</div>
					
					<div class="input-group mb-3">
	  				<div class="input-group-prepend">
	    				<span class="input-group-text">감독</span>
	  				</div>
					 	<input type="text" class="form-control" name="director" id="director">
					</div>
					<div class="input-group mb-3">
	  				<div class="input-group-prepend">
	    				<span class="input-group-text">배우</span>
	  				</div>
					 	<input type="text" class="form-control" name="actor" id="actor">
					</div>
					<div class="input-group mb-3">
	  				<div class="input-group-prepend">
	    				<span class="input-group-text">소개</span>
	  				</div>
					 	<textarea class="form-control" name="content" id="content"></textarea>
					</div>
	 			</div>
	 			<input type="button" onclick="submitOk()" value="추가하기"/>
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