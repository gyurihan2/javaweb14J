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
		
		// 상영관 생성 page(modal)
		function theaterCreate(){
			let name = $("#name").val();
			let thema = $("#thema").val();
			let seat = $("#seat").val();
			
			if(seat%10 != 0 && seat > 0) {
				seat = seat-seat%10+10;
			}
			
			if(name.trim() == ""){
				alert("상영관 이름을 입력하세요");
				myform.name.focus();
				return false;
			}
			else if(thema == ""){
				alert("상영관 테마를 입력하세요");
				myform.thema.focus();
				return false;
			}
			else if(seat <= 0 ){
				alert("좌석수 확인하세요");
				myform.seat.focus();
				return false;
			}
			
			// 가격 설정
			let price=0;
			if(thema == "Nomal") price=15000;
			else if(thema == "Imax") price=17000;
			else if(thema == "4DX") price=20000;
			else if(thema == "ScreenX") price=17000;
			
			$.ajax({
				type:"post",
				url:"${ctp}/TheaterCreateOk.ad",
				data:{
					name:name,
					thema:thema,
					seat:seat,
					price:price
				},
				success:function(res){
					if(res=="1"){
						alert("상영관 생성 완료");
						location.reload();
					}
					else{
						alert("생성실패");
					}
				},
				error:function(){
					alert("전송 실패");
				}
			});
			
		}
		
		// 상영관 상세 보기 Page(modal)
		function theaterDatail(index){
			let name = $("#name"+index).text();
			let thema = $("#thema"+index).text();
			let seat = $("#seat"+index).text();
			let price = $("#price"+index).text();
			let work = $("#work"+index).text();
			let regDate = $("#regDate"+index).val().substring(0,10);
			let modifyDate = $("#modifyDate"+index).val().substring(0,10);
			
			$("#dName").val(name);
			$("#dThema").val(thema).prop("selected",true);
			$("#dSeat").val(seat);
			$("#dPrice").val(price);
			$("#dWork").val(work).prop("selected",true);
			$("#dRegDate").val(regDate);
			$("#dModifyDate").val(modifyDate);
		}
		
		// 상영관 수정하기 Page(modal)
		function theaterModify(index){
			let name = $("#name"+index).text();
			let thema = $("#thema"+index).text();
			let seat = $("#seat"+index).text();
			let price = $("#price"+index).text();
			let work = $("#work"+index).text();
			let idx = $("#idx"+index).val();
			
			$("#mName").val(name);
			$("#mThema").val(thema).prop("selected",true);
			$("#mSeat").val(seat);
			$("#mPrice").val(price);
			$("#mWork").val(work).prop("selected",true);
			$("#mIdx").val(idx);
		}
		
		// 상영관 수정(aJax)
		function theaterModifyOk(){
			// 공백 및 유효성 검사 필요
			let name = $("#mName").val();
			let thema = $("#mThema").val();
			let seat = $("#mSeat").val();
			let price = $("#mPrice").val();
			let work = $("#mWork").val();
			let idx = $("#mIdx").val();

			// 가격 설정
			if(thema == "Nomal") price=15000;
			else if(thema == "Imax") price=17000;
			else if(thema == "4DX") price=20000;
			else if(thema == "ScreenX") price=17000;
			
			let query ={
				name:name,
				thema:thema,
				seat:seat,
				price:price,
				work:work,
				idx:idx
			};
			
			$.ajax({
				type:"post",
				url:"${ctp}/TheaterModifyOk.ad",
				data:query,
				success:function(res){
					if(res=="1"){
						alert("수정 완료");
						location.reload();
					}
					else{
						alert("수정 실패");
					}
				},
				error:function(){
					alert("전송 실패");
				}
			});
		}
		
		// 상영관 삭제
		function theaterDelete(index){
			let chk = confirm("상영관 "+$("#name"+index).text()+"을 삭제하시겠습니까?");
			
			if(!chk) return false;
			
			$.ajax({
				type:"post",
				url:"${ctp}/TheaterDeleteOk.ad",
				data:{
					idx:index
				},
				success:function(res){
					if(res=="1"){
						alert("삭제 완료되었습니다.");
						location.reload();
					}
					else{
						alert("삭제 실패");
					}
				},
				error:function(){
					alert("전송 오류");
				}
			});
			
			
			
		}
	</script>
</head>
<body>
<jsp:include page="/include/side_nav.jsp"/>
<p><br/></p>
<div class="content">
	<div class="container">
		<h3>상영관 관리</h3>
		<p></p>
		<input type="button" value="상영관 추가" class="btn btn-info btn-sm float-right" data-toggle="modal" data-target="#theaterCreateModal"/>
		<c:if test="${!empty vos}">
			<table class="table table-hover mt-2 text-center" id="testTable">
				<tr class="table-dark text-dark">
					<th>이름</th>
					<th>테마</th>
					<th>좌석수</th>
					<th>가격</th>
					<th>사용여부</th>
					<th>비고</th>
				</tr>
				<c:forEach var="vo" items="${vos}" varStatus="st">
					<tr>
						<td id="name${vo.idx}" onclick="theaterDatail(${vo.idx})" data-toggle="modal" data-target="#theaterDetailModal">${vo.name}</td>
						<td id="thema${vo.idx}">${vo.thema}</td>
						<td id="seat${vo.idx}">${vo.seat}</td>
						<td id="price${vo.idx}">${vo.price}</td>
						<td id="work${vo.idx}">${vo.work}</td>
						<td>
							<input type="button" value="수정" class="btn btn-info btn-sm" onclick="theaterModify(${vo.idx})" data-toggle="modal" data-target="#theaterModifyModal">
							<input type="button" value="삭제" class="btn btn-danger btn-sm" onclick="theaterDelete(${vo.idx})"/>
							<input type="hidden" id="regDate${vo.idx}" value="${vo.regDate }"/>
							<input type="hidden" id="modifyDate${vo.idx}" value="${vo.modifyDate }"/>
							<input type="hidden" id="idx${vo.idx}" value="${vo.idx}"/>
						</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
	</div>
</div>
<p><br/></p>
<!-- 상영관 신규 생성 Modal -->
<div class="modal fade" id="theaterCreateModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
			<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">상영관 신규 생성</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
	      <!-- Modal body -->
				<form method="post" action="" name="myform" id="myform">
	      	<div class="modal-body row justify-content-center">
	      		<div class="input-group mb-3">
		    			<div class="input-group-prepend">
		      			<span class="input-group-text">상영관이름</span>
		    			</div>
	    				<input type="text" class="form-control" name="name" id="name" placeholder="상영관이름을 입력하세요">
	  				</div>
	      		<div class="input-group mb-3">
	    				<div class="input-group-prepend">
	      				<span class="input-group-text">상영관 테마</span>
	    				</div>
					  <select name="thema" id="thema" class="custom-select">
					    <option value="" selected>상영관 테마를 선택하세요</option>
					    <option value="Nomal">일반</option>
					    <option value="Imax">Imax</option>
					    <option value="4DX">4DX</option>
					    <option value="ScreenX">ScreenX</option>
					  </select>
			 		</div>
			 		<div class="input-group mb-3">
	    			<div class="input-group-prepend">
	      			<span class="input-group-text">좌석수</span>
	    			</div>
	    			<input type="number" class="form-control" name="seat" id="seat" step="10" min="0">
	  			</div>
				 	<input type="button" class="form-control btn btn-info text-center" value="생성하기" onclick="theaterCreate()" style="width:80%	">
			 	</div>
			</form>
     <!-- Modal footer --> 
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<!-- 상영관 상세 보기 Modal -->
<div class="modal fade" id="theaterDetailModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
			<!-- Modal Header -->
			<form method="post" action="" name="myform1" id="myform1">
				<div class="modal-header">
					<h4 class="modal-title">상영관 상세 보기</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
	      <!-- Modal body -->
	      <div class="modal-body row justify-content-center">
	      	<div class="input-group mb-3">
	    			<div class="input-group-prepend">
	      			<span class="input-group-text">상영관이름</span>
	    			</div>
	    			<input type="text" class="form-control" name="dMame" id="dName" readonly>
	  			</div>
	      	<div class="input-group mb-3">
	    			<div class="input-group-prepend">
	      			<span class="input-group-text">상영관 테마</span>
	    			</div>
	    			
					  <select name="dThema" id="dThema" class="custom-select" disabled>
					    <option value="Nomal">일반</option>
					    <option value="Imax">Imax</option>
					    <option value="4DX">4DX</option>
					    <option value="ScreenX">ScreenX</option>
					  </select>
			 		</div>
			 		<div class="input-group mb-3">
	    			<div class="input-group-prepend">
	      			<span class="input-group-text">좌석수</span>
	    			</div>
	    			<input type="number" class="form-control" name="dSeat" id="dSeat" readonly>
	  			</div>
			 		<div class="input-group mb-3">
	    			<div class="input-group-prepend">
	      			<span class="input-group-text">가격</span>
	    			</div>
	    			<input type="number" class="form-control" name="dPrice" id="dPrice" readonly>
	  			</div>
			 		<div class="input-group mb-3">
			 			<div class="input-group-prepend">
	      			<span class="input-group-text">사용여부</span>
	    			</div>
	      			<select name="dWork" id="dWork" class="custom-select form-control" disabled>
						    <option value="OK">작동중</option>
						    <option value="NO">정지</option>
					  	</select>
	  			</div>
			 		<div class="input-group mb-3">
	    			<div class="input-group-prepend">
	      			<span class="input-group-text">등록 날짜</span>
	    			</div>
	    			<input type="date" class="form-control" name="dRegDate" id="dRegDate" readonly>
	  			</div>
			 		<div class="input-group mb-3">
	    			<div class="input-group-prepend">
	      			<span class="input-group-text">수정한 날짜</span>
	    			</div>
	    			<input type="date" class="form-control" name="dModifyDate" id="dModifyDate" readonly>
	  			</div>
			 	</div>	
			</form>
     <!-- Modal footer --> 
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<!-- 상영관 수정 하기 Modal -->
<div class="modal fade" id="theaterModifyModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
			<!-- Modal Header -->
			<form method="post" action="" name="myform2" id="myform2">
				<div class="modal-header">
					<h4 class="modal-title">상영관 상세 보기</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
	      <!-- Modal body -->
	      <div class="modal-body row justify-content-center">
	      	<div class="input-group mb-3">
	    			<div class="input-group-prepend">
	      			<span class="input-group-text">상영관이름</span>
	    			</div>
	    			<input type="text" class="form-control" name="mMame" id="mName">
	  			</div>
	      	<div class="input-group mb-3">
	    			<div class="input-group-prepend">
	      			<span class="input-group-text">상영관 테마</span>
	    			</div>
					  <select name="mThema" id="mThema" class="custom-select">
					    <option value="Nomal">일반</option>
					    <option value="Imax">Imax</option>
					    <option value="4DX">4DX</option>
					    <option value="ScreenX">ScreenX</option>
					  </select>
			 		</div>
			 		<div class="input-group mb-3">
	    			<div class="input-group-prepend">
	      			<span class="input-group-text">좌석수</span>
	    			</div>
	    			<input type="number" class="form-control" name="mSeat" id="mSeat">
	  			</div>
			 		<div class="input-group mb-3">
	    			<div class="input-group-prepend">
	      			<span class="input-group-text">가격</span>
	    			</div>
	    			<input type="number" class="form-control" name="mPrice" id="mPrice">
	  			</div>
			 		<div class="input-group mb-3">
	    			<div class="input-group-prepend">
	      			<span class="input-group-text">작동여부</span>
	    			</div>
      			<select name="mWord" id="mWork" class="custom-select">
					    <option value="OK">작동중</option>
					    <option value="NO">정지</option>
				  	</select>
	  			</div>
			 	</div>
			 	<input type="button" value="수정하기" class="form-control btn btn-info" onclick="theaterModifyOk()"/>	
			 	<input type="hidden" name="mIdx" id="mIdx"/>	
			</form>
     <!-- Modal footer --> 
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
</body>
</html>