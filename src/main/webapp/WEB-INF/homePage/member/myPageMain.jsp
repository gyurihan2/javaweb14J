<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>MyPage</title>
	<jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">
	<h2 class="mb-5">My Page</h2>

	<h4><b>회원 정보</b></h4>
	<div class="row">
		<div class="container ml-3">
			<div class="row">
				<div class="col mt-2 mb-2">
					<span><font size="5em"><b>${vo.name}님</b></font></span>
					<span class="ml-1"><font size="3em">(${vo.mid})</font></span>
					<span class="ml-3"><font size="4em">닉네임: ${vo.nickName}</font></span>
					<span class="ml-3"><button class="btn btn-info btn-sm">회원정보 수정</button></span>
				</div>
			</div>
			<div class="row mt-3">
				<h5 class="ml-3">보유 포인트: ${vo.point}</h5>
				<h5 class="ml-3">VIP 누적 포인트: ${vo.totPoint}/10000</h5>
			</div>
		</div>
	</div>
  <hr/>
  <h4><b>My 예매 내역</b></h4>
  <div class="ml-3">
	  <div class='border' style="height:50px">
	  	예매 내역이 존재하지 않습니다.
	  </div>
  </div>
  <div class="row mt-3">
  	<div class="col border">
  		내가 본 영화
  	</div>
  	<div class="col border">
  		내가 쓴 평점
  	</div>
  	<div class="col border">
  		결재 내역
  	</div>
  </div>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>