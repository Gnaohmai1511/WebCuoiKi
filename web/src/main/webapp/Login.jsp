<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Login</h1>
<form action = /web/LoginServlet method="post">
   <label>Email </label>
   <input type="email" id="email" name="email" placeholder="Enter your email" ><br>
   <label>Password </label>
   <input type="password" id="password" name="password" placeholder="Enter your password"><br>
   <a href="Register.jsp">Don't have any account? Register here!</a><br>
   <a href="ForgotPW.jsp">Forgot password ?</a><br>
   <input type="submit" name="submit" value="Login">
</form>
</body>
</html>