<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/include/bs4.jsp" />
<script>
	function chkReg(str, reg) {
    	return reg.test(str);
	}
	
	function chkEmail(email){
	    const regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	    
	    let status=document.getElementById("regEmail");

	    if(!regExp.test(email.value)){
	        status.style.color="red";
	        status.style.fontWeight="bold";
	        status.innerText="이메일 형식을 확인하세요";
	        email.focus();
	        return false;
	    }
	    else{
	        status.innerText="";
	        return true;
	    }
	}
	
	function searchMid(){
		if(chkEmail(myform.email)){
			myform.submit();
		}
	}
	


	jQuery(function(){
		if(${!empty mid}){
			$("#searchRes").css("display","block");
			$("#searchRes").html("<font color='green'>아이디 검색 성공 : <b>${mid}</b></font>");
		}
		else if(${!empty param.sw}){
			$("#searchRes").css("display","block");
			$("#searchRes").html("<font color='red'><b>아이디 검색 실패</b></font>");
		}
		
		$("#email").change(function(){
			 	chkEmail(this);
	
	    });
	});
</script>
</head>
<body>
<div class="container">
  <div class="modal-dialog">
	  <div class="modal-content p-4">
		  <h2 class="text-center">아이디 찾기</h2>
		  <p class="text-center">(회원 이름과 이메일주소를 입력해 주세요)</p>
		  
		  <form name="myform" method="post" action="${ctp}/IdSearchOk.mem" class="was-validated">
		    <div class="form-group">
		      <label for="mid">회원 이름</label>
		      <input type="text" class="form-control" name="name" id="name" value="${param.name}" placeholder="이름을 입력하세요." required autofocus />
		      <div class="valid-feedback">Ok!!!</div>
		      <div class="invalid-feedback">이름을 입력해 주세요.</div>
		    </div>
		    <div class="form-group">
		      <label for="email">이메일</label><span id="regEmail" class="ml-3"></span>
		      <input type="text" class="form-control" name="email" id="email" placeholder="Enter email" required />
		      <div class="valid-feedback">Ok!!!</div>
		      <div class="invalid-feedback">이메일을 입력해 주세요.</div>
		    </div>
		    <div class="form-group text-center">
		    	<c:if test="${empty rMid}">
			    	<button type="button" class="btn btn-primary mr-1" onclick="searchMid()">아이디 찾기</button>
		    	</c:if>
		    	<c:if test="${!empty mid}">
			    	<button type="button" class="btn btn-info mr-1" onclick="location.href='${ctp}/PwdSearchPage.mem'">비밀번호 찾기</button>
		    	</c:if>
		    	<button type="reset" class="btn btn-warning mr-1">다시입력</button>
		    </div>
		  </form>
		  <div id="searchRes" style="display:none"></div>
	  </div>
  </div>
</div>
</body>
</html>