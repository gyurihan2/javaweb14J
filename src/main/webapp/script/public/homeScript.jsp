<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://kit.fontawesome.com/fa3667321f.js" crossorigin="anonymous"></script>
<style>
.top_title{
    width:1140px;
}
#topLogoImg{
    width:117px; 
    height:53px;
}
.topTitleSide a{
    text-decoration: none;
}
.topTitleSide a img{
    width: 26px; height:26px;
}

.mainMenu{
    width:1140px; 
}

.menubar a{
    margin-left: 20px;
    text-decoration: none;    
}

/* 트레일러 */
.mainTrailer{
    background: radial-gradient(rgb(54, 52, 52), black); 
    height: 500px;
}
#trailer{
    position: relative;
    height: 100%;
    width: 950px;
}
#trailer iframe{
    position: absolute;
    width: 100%;
    height: 100%;
}
/* 영화 목록 */
.mainContainer{
    background-color:#FBFBFB;
}
#movieContets{
    width:1140px; 
    height: 350px; 
}
#movieAllView button{
    border-radius: 30px;
    font-size: smaller; 
    border: 1px solid black;
}
.moviecontent img{
    width: 170px; 
    height: 234px;
}

/* 상영관 */
.specialhall_list{
    width: 100%;
    height: 350px;
}

#specialhall{
    position: relative;
    margin: auto;
    width: 889px;
    height: 340px;
}
#specialhall_content{
    float: right;
    width: 889px;
}
#hall_imags img{
    width: 350px; 
    height: 185px;
    border-radius:30px 30px;
}
#hall_lists{
    width: 500px;
    float: left;
}
#hall_list{
    list-style-type: none;
}
#hall_list > li{
    padding: 10px;
    border-top: 1px solid black;
}
#hall_list > li:hover{
   background-color: antiquewhite;
}
#hall_list > li span{
    float: right;
}
</style>
<script>
'use strict';
let ctp ="/javaweb14J/images"

function changeImgHall(hall){
   document.getElementById('hallImgSrc').src = ctp+"/theater/"+hall.id+".png";
}

let movieHallCnt=0;
let movieHall=['imax.png','4dx.png','screenx.png','primium.png'];
let statusTime;

function moviehall(id){
    id.src= ctp+"/theater/"+movieHall[movieHallCnt++];
    if(movieHallCnt == movieHall.length) movieHallCnt=0;
}

function movieHallAutoStart(){
    moviehall(document.getElementById("hallImgSrc"));
    statusTime = setTimeout(movieHallAutoStart,3000);
}
function movieHallAutoStop(){
    clearTimeout(statusTime);
}

window.onload = function(){
    movieHallAutoStart();
    hall_lists.addEventListener('mouseout',()=>{
        movieHallAutoStart();
    })
   
}
</script>