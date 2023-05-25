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
	 <style>
        .star {
        position: relative;
        font-size: 32px;
        color: #ddd;
        }

        .star input {
        width: 100%;
        height: 100%;
        
        padding-top: 20px;
        position: absolute;
        left: 0;
        opacity: 0;
        }

        .star span {
        width: 0;
        position: absolute;
        left: 0;
        color: rgb(230, 230, 19);
        overflow: hidden;
        pointer-events: none;
        }
        .test1{
            height: 50px;
        }
    </style>

    <script>
        'use strict';
        
        function drawStar(e){
            let star = e.value*20;
           
            $(".star span").css({width:star+"%"});
            $("#demo").html(e.value)
        }
        
       
    </script>
</head>
<body>

<p><br/></p>
<jsp:include page="/include/side_nav.jsp"/>
<div class="content container">
	<h3>상세일정 보기</h3>
	<c:if test="${!empty vos}">
		<table	class="table table-hover text-center">
			<tr class="text-dark table-dark">
				<th>포스터</th>
				<th>상영관</th>
				<th>상영 영화</th>
				<th>상영 시간</th>
				<th>총 관람수</th>
				<th>평점</th>
			</tr>
			<c:forEach var="vo" items="${vos}">
				<tr>
					<td><img src="${ctp}/images/movieChart/${vo.movieMainImg}" width="75px"></td>
					<td>${vo.theatherName}</td>
					<td>${vo.movieTitle}</td>
					<td>총 ${vo.moviePlayTime}분</td>
					<td>${vo.totalView}</td>
					<td>
						<span class="star">★★★★★
		        	<span style="width:${vo.movieRating*20}%">★★★★★</span>
	    			</span>
    			</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<c:if test="${empty vos}">
		일정이 없습니다.
	</c:if>
</div>
<p><br/></p>
</body>
</html>