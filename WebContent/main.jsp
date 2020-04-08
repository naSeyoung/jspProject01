<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css"> 
<link rel="stylesheet" href="css/custom.css"> 

<title>JSP 게시판 웹 사이트 </title>
</head>
<!-- 첫  홈페이지 = index파일 . -->
<!-- nav태그는 문서에서 탐색(Navigation)링크를정의함, 다른페이지나 다른곳으로의 링크를 유도  -->
<body>
<%
	String userID = null; 
	if (session.getAttribute("userID") != null) { //로그인 정보를 담을 수 있도록 
		userID = (String) session.getAttribute("userID");// 현재 세션에 존재하는 사람이라면 id값을 받아서관리하도록	
	}
%>

   
   <nav class="navbar navbar-default"> <!-- 하나의 웹사이트에 전반적인 구성을 보여줌 -->
      <div class="navbar-header">
         <button type="button" class="navbar-toggle collapsed" 
       	 	 data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
         	 aria-expanded="false">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
         </button>
         <a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트 </a>
      </div>
      <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
          <ul class="nav navbar-nav">
             <li class="active"><a href="main.jsp">메인</a></li>
             <li><a href="bbs.jsp">게시판</a></li>
          </ul>
           <% //로그인이 되어있지않은 경우 나오게 
           		if(userID == null){
           		
            %>
         <ul class="nav navbar-nav navbar-right"> <!-- 로그인이 되어 있지 않은 사람은 join이나login을 할 수있도록  -->
             <li class="dropdown">
                <a href="#" class="dropdown-toggle"
                   data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">접속하기<span class="caret"></span></a>
                <ul class="dropdown-menu">
                   <li><a href="login.jsp">로그인</a></li>
                   <li><a href="join.jsp">회원가입</a></li>
          		</ul>
          	</li>
         </ul>
          
          
            
       	   <%	
           		} else { //로그인이 된 사람들이 볼 수 있는 화면창 
            %>
      
        <ul class="nav navbar-nav navbar-right"> <!-- 로그인이 되어 있는 사람이 볼 수 있는 메 뉴   -->
             <li class="dropdown">
                <a href="#" class="dropdown-toggle"
                   data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">회원관리<span class="caret"></span></a>
                <ul class="dropdown-menu">
                   <li><a href="logoutAction.jsp">로그아웃</a></li>
         </ul>
        </li>
        </ul>
             
        <%
           		}
        %>
      </div>
   </nav>
   <div class="container">
   		<div class="jumbotron">
   			<div class="container">
   				<h1>웹 사이트 소개 </h1> <!-- # 에 웹사이트 링크를 넣어도 됨  -->
   				<p> 이 웹사이트는 부트스트랩으로 만든 JSP 웹사이트 입니다 최소한의 간단한 로직만을 이용해 개발 하였습니다. </p>
   				<p><a class="btn btn-primary btn-pull" href="#" role="button"> 자세히 알아보기 </a></p>
   			</div>
    	</div>
   </div>
   <div class="container">
   		<div id="myCarousel" class="carousel slide" data-ride="carousel">
   			<ol class="carousel-indicators">
   				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
   				<li data-target="#myCarousel" data-slide-to="1"></li>
   				<li data-target="#myCarousel" data-slide-to="2"></li>
   			</ol>
   			<div class="carousel-inner">
   				<div class="item active">
   					<img src="images/1.jpg">
   				</div>
   				<div class="item">
   					<img src="images/2.jpg">
   				</div>
   				<div class="item">
   					<img src="images/3.jpg">
   				</div>
   			</div>
   			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
   				<span class="glyphicon glyphicon-chevron-left"></span>
   			</a>
   			<a class="right carousel-control" href="#myCarousel" data-slide="next">
   				<span class="glyphicon glyphicon-chevron-right"></span>
   			</a>
   			</div>
   	</div>

   <script src="https://code.jquery.com/jquery-3.1.1.min.js"> </script>
   <script src="js/bootstrap.js"></script>
</body>
</html>