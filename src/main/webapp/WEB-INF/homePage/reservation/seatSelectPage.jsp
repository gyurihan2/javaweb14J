<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>title</title>
	<jsp:include page="/include/bs4.jsp" />
</head>
<body>
<p><br/></p>
<div class="container">
	<form class="row justify-content-center">
		<fmt:formatNumber minIntegerDigits="2" type="number" value="1" var="seatNum"/>
		<table class="col">
			<tr>
				<c:forEach var="seat" items="${seatArr}" varStatus="st">
					<td>
						<c:if test="${seat == 1 }">
							<input type="checkbox" id="${st.count}" name="seatNo" checked readonly>${seatNum}
						</c:if>
						<c:if test="${seat == 0 }">
							<input type="checkbox" id="${st.count}" name="seatOk">${seatNum}
						</c:if>
					</td>
					<c:if test="${st.count%10==0}"></tr><tr></c:if>
					<c:set var="seatNum" value="${seatNum= seatNum+1}"/>
					<fmt:formatNumber minIntegerDigits="2" type="number" value="${seatNum}" var="seatNum"/>
				</c:forEach>
			</tr>
		</table>
		<div class="col">
			
		</div>
	</form>
	
</div>
<p><br/></p>
</body>
</html>