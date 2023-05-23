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
		//영화 신규 생성
		function submitOk(){
			let title = $("#title").val();
			let img = $("#posterImg").val();
			console.log(img);
			
			let genre="";
			$('input:checkbox[name=genre]').each(function (index) {
				if($(this).is(":checked")==true){
			    	genre += $(this).val()+"/";
			    }
			});
			
			let playTime = $("#playTime").val();
			let openDate = $("#openDate").val();
			let director = $("#director").val();
			let actor = $("#actor").val();
			let content = $("#content").val();
			
			// 유효성 / 정규식 체크 필요
			
			myform.submit();
		}
		
		// 그림 미리보기
		 function posterAppend(e,index){
    	//그림파일 체크
    	let file = e.files[0];
    	
			if(!file.type.match("image.*")){
				alert("업로드파일을 확인하세요(이미지 파일만 가능)");
				return false;
			}

  		let img = document.createElement("img");
  		let reader = new FileReader();
  		reader.onload = function(e){
  			img.setAttribute("src",e.target.result);
  			img.setAttribute("width",150);
  			img.setAttribute("id","img"+index);
  		}
  		reader.readAsDataURL(e.files[0]);
  		document.querySelector(".imgDemo").appendChild(img);
  		
    }
		
		// 동적폼(파일 업로드)
		let cnt = 1;
		function posterAdd(){
			cnt++;
			
			let fileBox = '';
			fileBox += '<div id="fBox'+cnt+'" class="input-group">';
			fileBox += '<input type="file" name="fName'+cnt+'" id="file'+cnt+'" class="form-control-file border mb-2 mr-2" style="width:70%" onchange="posterAppend(this,'+cnt+')"/>';
			fileBox += '<input type="button" value="삭제" onclick="deleteBox('+cnt+')" class="btn-danger btn-sm" style="float:left; width:15%"/>';
			fileBox += '</div>';
			$("#fileBoxAppend").append(fileBox);
		}
		
		//추가된 파일박스 삭제 처리
		function deleteBox(cnt){
			$("#fBox"+cnt).remove();
			$("#img"+cnt).remove();
		}
		
		// 페이지 사이즈 변경
		function pageCheck() {
			let pageSize = $("#pageSize").val();
			location.href = "${ctp}/MovieMgmtPage.ad?pag=1&pageSize="+pageSize;
		}
		
		// 영화 리스트 삭제
		function movieDelete(idx,title){
			
	    let ans = confirm("선택한 영화 "+title+"를 삭제하시겠습니까?");
	    if(!ans)  return false;
	     
	    $.ajax({
	       type:"post",
	       url:"${ctp}/MovieDeleteOk.ad",
	       data:{idx:idx},
	       success: function(res){
	    	   if(res=="1"){
	    		   alert("삭제 완료");
		         location.reload();
	    	   }
	    	   else{
	    		   alert("삭제실패")
	    	   } 
	       },
	       error:function(){
	          alert("전송 실패");
	       }
	    });
	  }
		 // 일괄삭제
		function rangeDelete(){
			let items =[];
			
			$("input:checkbox[name=rangeChk]").each(function(index,item){
			  if(item.checked){
			      let idx = item.id.split("/")[1];
			      items.push({idx:idx});
			  }
			});
			// 배열을 보내기 위한 JSON 처리
			let jsonItems= JSON.stringify(items);
			console.log(items);
			console.log(jsonItems);
			$.ajax({
	      type:"post",
	      url:"${ctp}/MovieRangeDeleteOk.ad",
	      data:{movieIdxArr:jsonItems},
	      success: function(res){
	          if(res == "1"){
	              alert("일괄삭제 완료");
	              location.reload();
	          }
	          else alert("일괄삭제 실패~~");
	      },
	      error:function(){
	          alert("전송실패");
	      }
	    });
	  	      
		}
		
		jQuery(function(){
			// 이동 페이지가 총 페이지보다 클 경우 마지막 페이지로
			if(${totPage} < ${pag}){
				let pageSize = document.getElementById("pageSize").value;
				location.href = "${ctp}/MovieMgmtPage.ad?pag=${totPage}&pageSize="+pageSize;
			}
			
		 });
	</script>
</head>
<body>
<jsp:include page="/include/side_nav.jsp"/>
<p><br/></p>
<div class="content">
	<div class="container">
		<h3>영화 관리</h3>
		<table class="table table-boderless">
		<tr>
			<td>
				<input type="button" value="일괄 삭제" class="btn btn-danger btn-sm float-right border" onclick="rangeDelete()"/>
				<input type="button" value="영화 추가" class="btn btn-success btn-sm float-right border" data-toggle="modal" data-target="#movieInsertModal"/>
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
					<td><input type="checkbox" name="rangeChk" id="rangeChk/${vo.idx}" /> </td>
					<td>
						${vo.idx}
					</td>
					<td>${vo.title}</td>
					<td>${vo.genre}</td>
					<td>${vo.grade}</td>
					<td>${vo.openDate}</td>
					<td>
						<input type="button" value="수정" class="btn btn-info btn-sm" onclick=""/>
						<input type="button" value="삭제" class="btn btn-warning btn-sm" onclick="movieDelete('${vo.idx}','${vo.title }')"/>
					</td>
				</tr>
			</c:forEach>
			<tr><td colspan="6" class="m-0 p-0"></td></tr>
		</table>
		<!-- 블록 페이징 -->
		<div class="text-center">
	  	<ul class="pagination justify-content-center pagination-sm">
		  	<c:if test="${curBlock*pageSize > 1}">
		  		 <li class="page-item"><a class="page-link text-secondary" href="${ctp}/MovieMgmtPage.ad?pageSize=${pageSize}&pag=1">첫페이지</a></li>
		  	</c:if>
		  	<c:if test="${curBlock > 0 }">
		  		 <li class="page-item"><a class="page-link text-secondary" href="${ctp}/MovieMgmtPage.ad?pageSize=${pageSize}&pag=${((curBlock-1)*blockSize)+blockSize}">이전블록</a></li>
		  	</c:if>
		  	<c:forEach var="i" begin="${curBlock*blockSize+1}" end="${curBlock*blockSize+ blockSize}" varStatus="st">
		  		<c:if test="${i<=totPage && i==pag}">
		  			 <li class="page-item active"><a class="page-link text-white bg-secondary">${i}</a></li>
		  		</c:if>
		  		<c:if test="${i<=totPage && i!=pag}">
		  			 <li class="page-item"><a class="page-link text-secondary" href="${ctp}/MovieMgmtPage.ad?pageSize=${pageSize}&pag=${i}">${i}</a></li>
		  		</c:if>
		  	</c:forEach>
		  	<c:if test="${curBlock < lastBlock }">
		  		 <li class="page-item"><a class="page-link text-secondary" href="${ctp}/MovieMgmtPage.ad?pageSize=${pageSize}&pag=${((curBlock+1)*blockSize)+1}">다음블록</a></li>
		  	</c:if>
		  	<c:if test="${(curBlock+1)*pageSize < totPage}">
		  		 <li class="page-item"><a class="page-link text-secondary" href="${ctp}/MovieMgmtPage.ad?pageSize=${pageSize}&pag=${totPage}">마지막 페이지</a></li>
		  	</c:if>
	  	</ul>
	  </div>
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
			<form method="post" action="${ctp}/MovieInsertOk.ad" name="myform" id="myform" class="was-validated bordered" enctype="multipart/form-data">
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
	      			<span class="input-group-text">포스터</span>
	    			</div>
	    			<div id="fileBoxAppend" >
		    			<input type="file" class="posterImg" name="posterImg" class="mb-2 form-control-file border" onchange="posterAppend(this,1)"/>
	    			
	    			</div>
	    		<div><input type="button" class="btn-sm btn-info" value="추가" onclick="posterAdd()"></div>
	  			</div>
  	  		<div class="imgDemo" id="imgDemo"></div>
			 		<div class="input-group mb-3">
						<div class="input-group-prepend mr-1">
		  				<span class="input-group-text">장르</span>
						</div>
					 	<div class="form-check-inline">
						  <label class="form-check-label">
						    <input type="checkbox" name="genre" class="form-check-input" value="액션">액션
						  </label>
						</div>
						<div class="form-check-inline">
						  <label class="form-check-label">
						    <input type="checkbox" name="genre" class="form-check-input" value="로맨스">로맨스
						  </label>
						</div>
						<div class="form-check-inline">
						  <label class="form-check-label">
						    <input type="checkbox" name="genre" class="form-check-input" value="코미디">코미디
						  </label>
						</div>
						<div class="form-check-inline">
						  <label class="form-check-label">
						    <input type="checkbox" name="genre" class="form-check-input" value="만화">만화
						  </label>
						</div>
						<div class="form-check-inline">
						  <label class="form-check-label">
						    <input type="checkbox" name="genre" class="form-check-input" value="공포">공포
						  </label>
						</div>
						<div class="form-check-inline">
						  <label class="form-check-label">
						    <input type="checkbox" name="genre" class="form-check-input" value="드라마">드라마
						  </label>
						</div>
						<div class="form-check-inline">
						  <label class="form-check-label">
						    <input type="checkbox" name="genre" class="form-check-input" value="SF">SF
						  </label>
						</div>
						<div class="form-check-inline">
						  <label class="form-check-label">
						    <input type="checkbox" name="genre" class="form-check-input" value="판타지">판타지
						  </label>
						</div>
						<div class="form-check-inline">
						  <label class="form-check-label">
						    <input type="checkbox" name="genre" class="form-check-input" value="재난">재난
						  </label>
						</div>
						<div class="form-check-inline">
						  <label class="form-check-label">
						    <input type="checkbox" name="genre" class="form-check-input" value="다큐">다큐
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
	  				<div class="input-group-prepend">
	    				<span class="input-group-text">배우</span>
	  				</div>
					 	<input type="text" class="form-control" name="actor" id="actor">
					</div>
					<div class="input-group mb-3">
	  				<div class="input-group-prepend">
	    				<span class="input-group-text">제작국가</span>
	  				</div>
					 	<input type="text" class="form-control" name="nation" id="nation">
					 	<div class="input-group-prepend">
	    				<span class="input-group-text">관람등급</span>
	  				</div>
					 	<input type="number" class="form-control" name="grade" id="grade">
					</div>
					<div class="input-group mb-3">
	  				<div class="input-group-prepend">
	    				<span class="input-group-text">소개</span>
	  				</div>
					 	<textarea class="form-control" name="content" id="content"></textarea>
					</div>
	 			</div>
	 			<input type="button" onclick="submitOk()" value="추가하기" class="btn btn-info"/>
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