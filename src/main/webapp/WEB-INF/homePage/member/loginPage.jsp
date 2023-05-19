<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String cRemberMid="0";
	String cMid="";
	
	/* 아이디 기억 / 아이디 쿠키값 저장*/
	Cookie[] cookies = request.getCookies();
	for(int i=0; i<cookies.length; i++){
		if(cookies[i].getName().equals("cSaveMid")){
			pageContext.setAttribute("cSaveMid", cookies[i].getValue());
		}
		else if(cookies[i].getName().equals("cMid")){
			pageContext.setAttribute("cMid", cookies[i].getValue());
		}
	}
%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>title</title>
	<jsp:include page="/include/bs4.jsp"/>
</head>
<body>
<jsp:include page="/include/header.jsp"/>
<p><br/></p>
<div class="container">
	 <div class="modal-dialog">
	  <div class="modal-content p-4">
		  <h2 class="text-center">회원 로그인</h2>
		  <p class="text-center">(회원 아이디와 비밀번호를 입력해 주세요)</p>
		  
		  <form name="myform" method="get" action="${ctp}/MemberLoginOk.mem" class="was-validated">
		    <div class="form-group">
		      <label for="mid">회원 아이디</label>
		      <input type="text" class="form-control" name="mid" id="mid" value="${cMid}" placeholder="Enter ID" required autofocus />
		      <div class="valid-feedback">Ok!!!</div>
		    </div>
		    <div class="form-group">
		      <label for="pwd">비밀번호</label>
		      <input type="password" class="form-control" name="pwd" id="pwd" placeholder="Enter Password" required />
		      <div class="valid-feedback">Ok!!!</div>
		    </div>
		    <div class="form-group text-center">
		    	<button type="submit" class="btn btn-primary mr-1">로그인</button>
		    	<button type="button" onclick="location.href='${ctp}/SignUpPage.mem';" class="btn btn-success">회원가입</button>
		    </div>
		    <div class="row text-center" style="font-size:12px">
		      <span class="col"><input type="checkbox" name="idSave" id="idSave"/>아이디 저장</span>
		      <span class="col">
		        [<a href="${ctp}/MemberMidSearch.mem" onclick="window.open(this.href,'nWin','width=580px,height=450px'); return false;">아이디찾기</a>] /
		        [<a href="#">비밀번호찾기</a>]
		      </span>
		    </div>
		  </form>
	  </div>
  </div>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>