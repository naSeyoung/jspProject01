<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css"> 
<link rel="stylesheet" href="css/custom.css">

<title>JSP 게시판 웹 사이트 </title>


</head>
<!-- 첫  홈페이지 = index파일 . -->
<!-- nav태그는 문서에서 탐색(Navigation)링크를정의함, 다른페이지나 다른곳으로의 링크를 유도  -->



<body>
   <nav class="navbar navbar-default"> <!-- 하나의 웹사이트에 전반적인 구성을 보여줌 -->
      <div class="navbar-header"></div>
         <button type="button" class="navbar-toggle collapsed" 
         data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
         aria-expanded="false">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
         </button>
         <a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트 </a>
          </div>
         <div class="collapse navbar-collapse" id="bs=example-navbar-collapse-1">
           <ul class="nav navbar-nav">
             <li><a href="main.jsp">메인</a></li>
             <li><a href="bbs.jsp">게시판</a></li>
           </ul>
          <ul class="nav navbar-nav navbar-right">
             <li class="dropdown">
                <a href="#" class="dropdown-toggle"
                   data-toggle="dropdown" role="button" aria-haspopup-"true"
                   aria-expanded="false">접속하기<span class="caret"></span></a>
                <ul class="dropdown-menu">
                   <li class="active"><a href="login.jsp">로그인</a></li>
                   <li><a href="join.jsp">회원가입</a></li>
          </ul>
          </div>
          </nav>
   <div class="container">
      <div class="col-lg-4"></div>
      <div class="col-lg-4">
         <div class="jumbotron" style="padding-top: 20px;">
             <form method="post" action="joinAction.jsp">
                <h3 style="text-align: center;">회원가입화면</h3>
                <div class="form-group">
                   <input type="text" class="form-control" placeholder="아이디" name ="userID" maxlength="20">
                </div>
                <div class="form-group">
                   <input type="password" class="form-control" placeholder="비밀번호" name ="userPassword" maxlength="20">
                </div>
                <div class="form-group">
                   <input type="text" class="form-control" placeholder="이름" name ="userName" maxlength="20">
                </div> 
                <div class="form-group" style = "text-align: center;">
                	<div class="btn-group" data-toggle="buttons"> 
                		<label class = "btn btn-primary active">
                			<input type ="radio" name = "userGender" autocomplete="off" value="남자" checked>남자
                		</label>
                		<label class = "btn btn-primary">
                			<input type ="radio" name = "userGender" autocomplete="off" value="여자" checked>여자
                		</label>
                	</div>
                	</div>
                	<div class="form-group">
                   <input type="email" class="form-control" placeholder="이메일" name ="userEmail" maxlength="20">
                </div> 
                <input type="submit" class="btn btn-primary form-control" value="회원가입">
               </form>
          </div>
       </div>
      <div class="col-lg-4"></div>
   </div>
   <script src="https://code.jquery.com/jquery-3.1.1.min.js"> </script>
   <script src="js/bootstrap.js"></script>
</body>
</html>