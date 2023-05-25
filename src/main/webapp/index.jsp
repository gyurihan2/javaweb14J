<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>title</title>
	<script>
		location.href="${ctp}/MainHomepage.mem";
	</script>
</head>
<body>
<jsp:include page="/script/public/homeScript.jsp"/>
<jsp:include page="/include/header.jsp"/>
<p><br/></p>

<p><br/></p>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>