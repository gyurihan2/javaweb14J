<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>MyPage</title>
	<jsp:include page="/include/bs4.jsp" />
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${ctp}/script/member/woo.js" ></script>
	<script>
		'use script';
		
		
			function modifyOk(){
				/* 유효성 검사 필요 */
				let name = $("#name").val();
				let birthday = $("#name").val();
				let email = $("#email1").val() + "@" + $("#email2").val();
				let phone = $("#phone1").val()+"-"+$("#phone2").val()+"-"+$("#phone3").val();
				
				let postcode1 = myform.postcode.value == "" ? " " : myform.postcode.value;
				let roadAddress1 = myform.roadAddress.value == "" ? " " : myform.roadAddress.value;
				let detailAddress1 = myform.detailAddress.value == "" ? " " : myform.detailAddress.value;
				let extraAddress1 = myform.extraAddress.value == "" ? " " : myform.extraAddress.value;
				let address1 = postcode1 + "/" + roadAddress1 + "/"+detailAddress1+"/"+extraAddress1;
				let query={
						mid:'${vo.mid}',
						name:name,
						birthday:birthday,
						email:email,
						phone:phone,
						address1:address1
				};
				
				$.ajax({
					type:"post",
					url:"${ctp}/MemberModifyOk.mem",
					data:query,
					success:function(res){
						if(res=="1"){
							alert("회원정보가 수정 되었습니다.");
							location.reload();
						}
						else{
							alert("회원정보 수정을 실패했습니다.");
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
					<span class="ml-3"><button class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModal1">회원정보 수정</button></span>
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
<!-- 회원 정보 수정 Modal -->
<div class="modal fade" id="myModal1">
  <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">회 원 정 보 수 정</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

      <!-- Modal body -->
      <div class="modal-body row justify-content-center">
	      <form name="myform" method="post" class="was-validated bordered" style="width:500px">
		    <br/>
		    <div class="form-group">
		    	아이디 : &nbsp; &nbsp;
		      <input type="text" class="form-control" name="mid" id="mid" value="${vo.mid}" readonly/>
		    </div>
		    <div class="form-group">
		    	닉네임 : &nbsp; &nbsp;
		      <input type="text" class="form-control" id="nickName" name="nickName" value="${vo.nickName}" readonly />
		    </div>
		    <div class="form-group">
		    	성명 :
		      <input type="text" class="form-control" id="name" name="name" value="${vo.name}" />
		    </div>
		    <div class="form-group">
		      주민번호:
	        <div class="input-group mb-3">
	        	<c:set var="identiNums" value="${fn:split(vo.identiNum,'-')}"/>
	          <input type="text" class="form-control mr-1" id="identiNum1" name="identiNum1" value="${identiNums[0] == null ?'':identiNums[0]}" readonly />
	          <div class="input-group-append">
	            -<input type="password" class="form-control ml-1" id="identiNum2" name="identiNum2" value="${identiNums[1] == null ?'':identiNums[1]}" readonly />
	          </div>
	        </div>
		    </div>
		    <div class="form-group">
		      <div class="form-check-inline">
		        <span class="input-group-text">성별 :</span> &nbsp; &nbsp;
		        <label class="form-check-label">
		          <input type="radio" class="form-check-input" name="gender" value="남자"  <c:if test="${vo.gender == '남자' }">checked</c:if> onclick="return(false);">남자
		        </label>
		      </div>
		      <div class="form-check-inline">
		        <label class="form-check-label">
		          <input type="radio" class="form-check-input" name="gender" value="여자"  <c:if test="${vo.gender == '여자' }">checked</c:if> onclick="return(false);">여자
		        </label>
		      </div>
		    </div>
		    <div class="form-group">
		      <label for="birthday">생일</label>
		      <input type="date" name="birthday" class="form-control" value="${vo.birthday}"/>
		    </div>
		    <div class="form-group">
		    	<c:set var="phones" value="${fn:split(vo.phone,'-')}"></c:set>
		      <div class="input-group mb-3">
		        <div class="input-group-prepend">
		          <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;
		            <select name="phone1" id="phone1" class="custom-select">
		           
		              <option value="010" <c:if test="${phones[0]=='010'}">selected</c:if>>010</option>
		              <option value="02"  <c:if test="${phones[0]=='02'}">selected</c:if>>02</option>
		              <option value="031" <c:if test="${phones[0]=='031'}">selected</c:if>>031</option>
		              <option value="032" <c:if test="${phones[0]=='032'}">selected</c:if>>032</option>
		              <option value="041" <c:if test="${phones[0]=='041'}">selected</c:if>>041</option>
		              <option value="042" <c:if test="${phones[0]=='042'}">selected</c:if>>042</option>
		              <option value="043" <c:if test="${phones[0]=='043'}">selected</c:if>>043</option>
		              <option value="051" <c:if test="${phones[0]=='051'}">selected</c:if>>051</option>
		              <option value="052" <c:if test="${phones[0]=='052'}">selected</c:if>>052</option>
		              <option value="061" <c:if test="${phones[0]=='061'}">selected</c:if>>061</option>
		              <option value="062" <c:if test="${phones[0]=='062'}">selected</c:if>>062</option>
		            </select>-
		        </div>
		        <input type="number" name="phone2" id="phone2" size=4 maxlength=4 class="form-control" value="${phones[1]==null?'' : phones[1]}"/>-
		        <input type="number" name="phone3" id="phone3" size=4 maxlength=4 class="form-control" value="${phones[2]==null?'' : phones[2]}"/>
		      </div>
		    </div>
		    <div class="form-group">
		    	<c:set var="emails" value="${fn:split(vo.email,'@') }"/>
		      <label for="email1">Email address:</label>
		      <span class="ml-3" id="regEmail"></span>
		        <div class="input-group mb-3">
		          <input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" required value="${emails[0]}" />
		          <div class="input-group-append">
		            <select name="email2" id="email2" class="custom-select">
		              <option value="naver.com" <c:if test="${emails[1] == 'naver.com' }">selected</c:if>>naver.com</option>
		              <option value="hanmail.net" <c:if test="${emails[1] == 'hanmail.net' }">selected</c:if>>hanmail.net</option>
		              <option value="hotmail.com" <c:if test="${emails[1] == 'hotmail.com' }">selected</c:if>>hotmail.com</option>
		              <option value="gmail.com" <c:if test="${emails[1] == 'gmail.com' }">selected</c:if>>gmail.com</option>
		              <option value="nate.com" <c:if test="${emails[1] == 'nate.com' }">selected</c:if>>nate.com</option>
		              <option value="yahoo.com" <c:if test="${emails[1] == 'yahoo.com' }">selected</c:if>>yahoo.com</option>
		            </select>
		          </div>
		        </div>
		    </div>
		    <div class="form-group" >
		    	<c:set var="addresses" value="${fn:split(vo.address,'/')}"/>
		      <label for="address">주소</label>
		      <input type="hidden" name="address" id="address">
		      <div class="input-group mb-1">
		        <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control" readonly value="${addresses[0]}">
		        <div class="input-group-append">
		          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
		        </div>
		      </div>
		      <input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1" readonly value="${addresses[1]}">
		      <div class="input-group mb-1">
		        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control" value="${addresses[2]}"> &nbsp;&nbsp;
		        <div class="input-group-append">
		          <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control" readonly value="${addresses[3]}">
		        </div>
		      </div>
		    </div>
		    <button type="button" class="btn btn-info form-control" id="memberJoin" onclick="modifyOk()">수정하기</button> &nbsp;
		    <input type="hidden" name="phone"/>
		    <input type="hidden" name="email"/>
		    <input type="hidden" name="address1"/>
		    <input type="hidden" name="identiNum"/>
		  </form>
    </div>  
     <!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/include/footer.jsp" />
</body>
</html>