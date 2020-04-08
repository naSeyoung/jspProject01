<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="User.UserDAO" %>
    <%@ page import="java.io.PrintWriter" %>
   
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹사이트 </title>
</head>
<body>
   <!-- userDAO 라는 하나의 인스턴스  -->
   <%
     session.invalidate(); //페이지에 접속한 회원이 세션을 빼앗기도록 해서 로그아웃
      
    %>
      <script>
      	location.href = 'main.jsp';
      </script>

   

</body>
</html>