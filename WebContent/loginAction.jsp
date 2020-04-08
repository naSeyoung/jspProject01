<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="User.UserDAO" %>
    <%@ page import="java.io.PrintWriter" %>
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id="user" class="User.User" scope="page"/>
    <jsp:setProperty name="user" property="userID"/> <!-- login.jsp에서 가져오는 userID -->
    <jsp:setProperty name="user" property="userPassword"/><!-- login.jsp에서 가져오는 userPassword -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹사이트 </title>
</head>
<body>
   <!-- userDAO 라는 하나의 인스턴스  -->
   <%
   String userID = null; //로그인을 한 사람은 또다시 로그인을 못하게 함 
   if(session.getAttribute("userID") != null) {
	   userID = (String) session.getAttribute("userID");
   }
   if( userID != null) {
	   PrintWriter script = response.getWriter();
	   script.println("<script>");
	   script.println("alert('이미 로그인이 되어있습니다')");
	   script.println("location.href = 'main.jsp'");
	   script.println("</script>");
	   
   } 
      UserDAO UserDAO = new UserDAO();
      int result = UserDAO.login(user.getUserID(), user.getUserPassword());
      // login.jsp에서 입력된 아이디 비밀번호 값들이 login함수 에 넣어서 실행을 함,
      // -2부터 1까지 각각의 값들이 result에 담김 *userDAO참고 
       if(result == 1){
    	 session.setAttribute("userID", user.getUserID()); //세션아이디 부여받음 
         PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("location.href = 'main.jsp'");
         script.println("</script>");
         
      }
       else if(result == 0){ //비밀번호가 틀린경우 
         PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('비밀번호가 틀립니다.')");
         script.println("history.back()");
         script.println("</script>");
         
      }
      else if(result == -1){
         PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('존재하지 않는 아이디입니다.')");
         script.println("history.back()");
         script.println("</script>");
         
      }
      else if(result == -2){
         PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('데이터베이스 오류가 발생했습니다.')");
         script.println("history.back()");
         script.println("</script>");
         
      }
      
      
      %>

   

</body>
</html>