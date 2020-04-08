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
             <li class="active"><a href="bbs.jsp">게시판</a></li>
           </ul>
           <% //로그인이 되어있지않은 경우 나오게 
           		if(userID == null ){
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
      	<div class="row">
      	<form method="post" action="writeAction.jsp">
      	<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd" > <!-- striped : 게시판 글 목록들이 홀짝이 번갈아가면서 색상도 변경되도록 해서 보기 좋게 만듬 -->
      			<thead>
      				<tr>
      					<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
      					
      				</tr>
      			</thead>
      			<tbody>
      				<tr> <!-- input:특정한 정보를 action페이지에 넘기기 위해 사용  -->
      					<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
      					</tr>
      				<tr>
      					<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px;"></textarea> </td>
      				</tr>
      			</tbody>
      		</table>
      		<input type="submit"  class="btn btn-primary pull-right" value="글쓰기">
      	</form>
      	</div>
      </div>
          
   
   <script src="https://code.jquery.com/jquery-3.1.1.min.js"> </script>
   <script src="js/bootstrap.js"></script>
</body>
</html>