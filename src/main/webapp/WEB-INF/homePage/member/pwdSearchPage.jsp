<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/include/bs4.jsp" />
<style>
  /* The Modal (background) */
  .myModal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 10; /* Sit on top */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
  }
 
  /* Modal Content/Box */
  .search-modal-content  {
    background-color: #fefefe;
    margin: 15% auto; /* 15% from the top and centered */
    padding: 20px;
    border: 1px solid #888;
    width: 70%; /* Could be more or less, depending on screen size */
  }
</style>
<script>
	'use strict';
	/* 이메일 정규식 처리 */
	function chkReg(str, reg) {
    	return reg.test(str);
	}
	
	function regEmail(email){
	    const regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	    
	    let status=document.getElementById("regEmail");

	    if(email.value==""){
	    	 status.innerText="";
	    	 return false;
	    }
	    else if(!regExp.test(email.value)){
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
	/* 비밀번호 정규식 */	
	function regPwd(pwd){
	    const regExp =  /^(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{5,20}/g;
	    let status = document.getElementById("regPwd");

	    if(pwd.value == ""){
	        status.innerText="";
	        return false;
	    }
	    else if(!regExp.test(pwd.value)){
	        status.style.color="red";
	        status.style.fontWeight="bold";
	        status.innerText="사용 불가합니다.(최소5~15문자(특수문자 1개 이상, 5~20문자))";
	        status.focus();
	        return false;
	    }
	    
	    status.innerText=""; 
	    return true; 
	    
	}
	
	/* 비밀번호 찾기 aJax( res:1 성공 / res:0 실패) */
	function pwdSearch(){
		if(regEmail(myform.email)){
			let mid = $("#mid").val();
			let email = $("#email").val();
			$.ajax({
				type:"post",
				url:"${ctp}/PwdSearchOk.mem",
				data:{
					mid:mid,
					email:email
				},
				success:function(res){
					if(res=="1"){
						$("#modalMid").val(mid);
						$(".myModal").show();
					}
					else{
						alert("찾으신 결과가 없습니다.");
					}
				},
				error:function(){
					alert("전송 실패")
				}
			});
		}
		else{
			alert("아이디 또는 이메일을 입력하세요");
		}
	}
	
	// 비밀번호 찾기 후 비밀번호 변경 처리 aJax(res:1 성공 / res:0 실패)
	function chagnePwd() {
		/* if(regPwd(document.getElementById("chgPwd"))){ */
			$.ajax({
				type:"post",
				url:"${ctp}/PwdChangeOk.mem",
				data:{
					mid:$("#modalMid").val(),
					chgPwd:$("#chgPwd").val()
				},
				success:function(res){
					if(res == "1"){
						alert("비밀번호 변경 완료");
						closeModal();
						window.close();
					}
					else{
						alert("비밀번호 변경 실패");
					}
				},
				error:function(){
					alert("전송 실패");
				}
			});
		/* } */
	}
	
	/* 모달창  닫기 */
	function closeModal() {
  	$('.myModal').hide();
  };

	jQuery(function(){
		$("#email").change(function(){
			 	regEmail(this);
		});
		$("#chgPwd").change(function(){
			 	regPwd(this);
	  }); 
	});
</script>
</head>
<body>
<div class="container">
  <div class="modal-dialog">
	  <div class="modal-content p-4">
		  <h2 class="text-center">비밀번호 찾기</h2>
		  <p class="text-center">(회원 아이디와 이메일주소를 입력해 주세요)</p>
		  
		  <form name="myform" method="post" action="${ctp}/IdSearchOk.mem" class="was-validated">
		    <div class="form-group">
		      <label for="mid">회원 아이디</label>
		      <input type="text" class="form-control" name="mid" id="mid" value="${param.name}" placeholder="이름을 입력하세요." required autofocus />
		      <div class="valid-feedback">Ok!!!</div>
		      <div class="invalid-feedback">아이디를 입력해 주세요.</div>
		    </div>
		    <div class="form-group">
		      <label for="email">이메일</label><span id="regEmail" class="ml-3"></span>
		      <input type="text" class="form-control" name="email" id="email" placeholder="Enter email" required />
		      <div class="valid-feedback">Ok!!!</div>
		      <div class="invalid-feedback">이메일을 입력해 주세요.</div>
		    </div>
		    <div class="form-group text-center">
			    <button type="button" class="btn btn-info mr-1" onclick="pwdSearch()">비밀번호 찾기</button>
		    	<button type="reset" class="btn btn-warning mr-1">다시입력</button>
		    </div>
		  </form>
		  <div id="searchRes" style="display:none"></div>
	  </div>
  </div>
</div>
<!-- 모달창 참조: https://newehblog.tistory.com/28-->
<div id="modal" class="myModal">
    <div class="search-modal-content">
        <div class="page-header">
            <h3>비밀번호 변경</h3>
        </div>
        <div class="row mt-2">
            <div class="col-sm-12">
                <div class="row">
                    <div class="col-sm-12">
                        <input type="password" id="chgPwd" placeholder="변경할 비밀번호를 입력하세요" class="form-control"/>
                        <span id="regPwd" class="ml-3" style="font-size:0.7em"></span>
                    </div>
                </div>
                <div class="mt-3 text-center">
                	<input type="button" value="변경" class="btn btn-sm btn-info" onclick="chagnePwd()">
                	<input type="button" value="취소" onclick="closeModal()" class="btn btn-sm btn-warning">
                	<input type="hidden" id="modalMid" name="modalMid">
                </div>
            </div>
        </div>
        <hr>
    </div>
</div>
</body>
</html>