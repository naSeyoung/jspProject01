<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="User.UserDAO" %>
    <%@ page import="java.io.PrintWriter" %>
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id="user" class="User.User" scope="page"/>
    <jsp:setProperty name="user" property="userID"/> <!-- login.jsp에서 가져오는 userID -->
    <jsp:setProperty name="user" property="userPassword"/><!-- login.jsp에서 가져오는 userPassword -->
	<jsp:setProperty name="user" property="userName"/>
	<jsp:setProperty name="user" property="userGender"/>
	<jsp:setProperty name="user" property="userEmail"/>
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
   if( userID != null) {
	   PrintWriter script = response.getWriter();
	   script.println("<script>");
	   script.println("alert('이미 로그인이 되어있습니다')");
	   script.println("location.href = 'main.jsp'");
	   script.println("</script>");
	   
   }
   	  if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
   	  || user.getUserGender() == null || user.getUserEmail() == null){
   		  PrintWriter script = response.getWriter();
   		  script.println("<script>");
   		  script.println("<alert('입력이 안된 사항이 있습니다. ')");
   		  script.println("history.back()");
   		  script.println("</script>");
   	  } else {
   		 UserDAO userDAO = new UserDAO();
         int result = userDAO.join(user);
          if(result == -1){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('이미 존재하는 아이디입니다. ')");
            script.println("location.href = 'main .jsp'");
            script.println("</script>");
            
         }else if (result == 0){
        	session.setAttribute("userID", user.getUserID());
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href = 'main.jsp'"); // 메인페이지 이동, 회원가입성공. 
            script.println("</script>");
            
         }
   	  }
     
       
      
      
      
      %>

   

</body>
</html>