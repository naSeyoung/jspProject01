<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="bbs.BbsDAO" %>
    <%@ page import="java.io.PrintWriter" %>
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/>
    <jsp:setProperty name="bbs" property="bbsTitle"/> <!-- login.jsp에서 가져오는 userID -->
    <jsp:setProperty name="bbs" property="bbsContent"/><!-- login.jsp에서 가져오는 userPassword -->
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹사이트 </title>
</head>
<body>
   <!-- userDAO 라는 하나의 인스턴스  -->
   <%
	String userID = null; //로그인을 한 사람은 회원가입 페이지에 접속 못함  
   if(session.getAttribute("userID") != null) {
	   userID = (String) session.getAttribute("userID");
   }
   if( userID == null) {
	   PrintWriter script = response.getWriter();
	   script.println("<script>");
	   script.println("alert('로그인을 하세요 ')");
	   script.println("location.href = 'login.jsp'");
	   script.println("</script>");
   } else {
	   if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null){
			  
			   		  PrintWriter script = response.getWriter();
			   		  script.println("<script>");
			   		  script.println("<alert('입력이 안된 사항이 있습니다. ')");
			   		  script.println("history.back()");
			   		  script.println("</script>");
			   	  } else {
			   		BbsDAO bbsDAO = new BbsDAO();
			         int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
			          if(result == -1){
			            PrintWriter script = response.getWriter();
			            script.println("<script>");
			            script.println("alert('글쓰기에 실패했습니다 ')"); //데이터베이스 오류 
			            script.println("history.back()");
			            script.println("</script>");
			            
			         }
			          else {
			            PrintWriter script = response.getWriter();
			            script.println("<script>");
			            script.println("location.href = 'bbs.jsp'");  
			            script.println("</script>");
			            
			         }
			   	  }
   }
			       
			      
   
   	  
      
      
      %>

   

</body>
</html>