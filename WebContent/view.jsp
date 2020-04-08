<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> 
<%@ page import="bbs.Bbs" %> 
<%@ page import="bbs.BbsDAO" %>
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
	int bbsID = 0;
	if (request.getParameter("bbsID") != null){
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
		
	}
	if (bbsID == 0){
		PrintWriter script = response.getWriter();
		   script.println("<script>");
		   script.println("alert('유효하지 않은 글입니다')");
		   script.println("location.href = 'bbs.jsp'");
		   script.println("</script>");
		
	}
	Bbs bbs = new BbsDAO().getBbs(bbsID); //유효한 글
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
         <div class="collapse navbar-collapse" id="bs=example-navbar-collapse-1">
           <ul class="nav navbar-nav">
             <li><a href="main.jsp">메인</a></li>
             <li class="active"><a href="bbs.jsp">게시판</a></li>
           </ul>
           <% //로그인이 되어있지않은 경우 나오게 
           		if(userID == null ){
            %>
             <ul class="nav navbar-nav navbar-right"><!-- 로그인이 되어 있지 않은 사람은 join이나login을 할 수있도록  -->
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
      	<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd" > <!-- striped : 게시판 글 목록들이 홀짝이 번갈아가면서 색상도 변경되도록 해서 보기 좋게 만듬 -->
      			<thead>
      				<tr>
      					<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
      					
      				</tr>
      			</thead>
      			<tbody>
      				<tr> 
      					<td style="width: 20%;"> 글 제목 </td>
      					<td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replaceAll(">", "gt;").replaceAll("\n", "<br>")%></td>
      				</tr>
      				<tr> 
      					<td>작성자</td>
      					<td colspan="2"><%= bbs.getUserID()%></td>
      				</tr>
					<tr> 
      					<td>작성일자</td>
      					<td colspan="2"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시" + bbs.getBbsDate().substring(14, 16) + "분" %></td>
      				</tr>
      				<tr> 
      					<td>내용</td>
      					<td colspan="2" style="min-height: 200px; text-align: left;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replaceAll(">", "gt;").replaceAll("\n", "<br>") %></td>
						<!-- replace~:보안상의 문제를 해결해줌, 악성스크립트를 삽입 하려해도 자체를 눈에 보이게 함으로써 해킹을 예방-->
      				</tr>      				
      			</tbody>
      		</table>
      		<a href="bbs.jsp" class="btn btn-primary">목록</a>
      		<% 
      			if(userID != null && userID.equals(bbs.getUserID())){
      		%>
      				<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
      				<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
      		<%
      			}
      		%>
      	</div>
      </div>
          
   
   <script src="https://code.jquery.com/jquery-3.1.1.min.js"> </script>
   <script src="js/bootstrap.js"></script>
</body>
</html>