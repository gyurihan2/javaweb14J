<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>title</title>
</head>
<body>
<jsp:include page="/script/public/homeScript.jsp"/>
<jsp:include page="/include/header.jsp"/>
<p><br/></p>
<div class="container-fluid text-center" style="background: radial-gradient(rgb(54, 52, 52), black); height: 500px;">
<!-- 메인 영화 예고편 -->
	<div class="row">
	<div class="col ">
    	<!-- <iframe width="889" height="500" src="https://www.youtube.com/embed/d2VN6NNa9BE?" title="YouTube video player" frameborder="0" 
    	allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen"></iframe> -->
	</div>
	</div>
</div>
<!-- 영화 목록 -->
<div class="container-fluid  p-3 mainContainer">
  <div class="row">
    <div class="col">
      <div class="container-xl" id="movieContets">
        <div class="row">
            <div class="col-4  text-left" id="movieStaus">
                <button type="button" class="btn btn-light text-secondary font-weight-bold">무비차트</button>
                <button type="button" class="btn btn-light text-secondary font-weight-bold">상영예정</button>
            </div>
            <div class="col "></div>
            <div class="col-2  text-right" id="movieAllView"><button><b>전체 보기 ></b></button></div>
        </div>
        <div class="row mt-3">
            <div class="col align-self-center"> <!--왼쪽 공백-->
               <button class="btn" type="button" onclick="movieChartPrevious()" style="visibility: hidden;" id="moviePrevious">
                   <p><i class="fas fa-long-arrow-left fa-4x" style="color: #363535;"></i></p>
               </button>  
            </div>
            <div class="col text-center moviecontent movienext" >
                <a href="#"><img name="movieChartImg" src="/javaweb/cgvProject/images/jw.jpg"></a>
                <br/><span name="movieChartName">존윅4</span>
            </div>
            <div class="col text-center moviecontent">
                <a href="#"><img name="movieChartImg" src="/javaweb/cgvProject/images/slamdunk.jpg"></a>
                <br/><span name="movieChartName">슬램덩크</span>
            </div>
            <div class="col text-center moviecontent">
                <a href="#"><img name="movieChartImg" src="/javaweb/cgvProject/images/스즈메.jpg"></a>
                <br/><span name="movieChartName">스즈메의 문단속</span>
            </div>
            <div class="col text-center moviecontent">
                <a href="#"><img name="movieChartImg" src="/javaweb/cgvProject/images/rebound.jpg"></a>
                <br/><span name="movieChartName">리바운드</span>
            </div>
            <div class="col align-self-center movienext"><!--오른쪽 공백-->   
                <button class="btn" type="button" onclick="movieChartNext()" id="movieNext">
                    <p><i class="fas fa-long-arrow-right fa-4x" style="color: #363535;"></i></p>
                </button>  
            </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- 특별관 목록 -->
<div class="container-fluid  p-3 mainContainer">
	<div class="row mt-5">
      <div class="col">
        <div class="specialhall_list">
          <div id="specialhall">
            <div><h2>특별관</h2></div>
              <div id="specialhall_content">
                <div id="hall_imags" style="float: left; padding-top: 10px;">
                    <img id="hallImgSrc" src="${ctp}/images/theater/imax.png">
                </div>
                <div id="hall_lists" onmouseover=movieHallAutoStop()>
									<ul id="hall_list">
										<li id="imax" onmouseover=changeImgHall(this)><a href="#"><strong>IMAX</strong><span>#대형스크린 #최고의몰입감</a></span></li>
										<li id="4dx" onmouseover=changeImgHall(this)><a href="#"><strong>4DX</strong><span>#모션 시트 #오감체험</span></li></a>
										<li id="screenx" onmouseover=changeImgHall(this)><a href="#"><strong>SCREENX </strong><span>#3면 확장스크린 #270도스크린</span></li></a>
										<li id="primium" onmouseover=changeImgHall(this)><a href="#"><strong>PREMIUM </strong><span>#리클라이너#최고급 좌석</span></a>
										</li>
									</ul> 
                </div>
              </div>
          </div>
        </div>
      </div>
  </div>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>