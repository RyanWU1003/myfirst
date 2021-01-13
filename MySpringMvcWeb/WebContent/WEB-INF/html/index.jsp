<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="login.css">
</head>
<body>
<div class="container">
<form method="post" action="login.chechController">
 <h2>Login</h2>
            <input type="text" name="userName"  placeholder="Username" class="name" autocomplete="off" >
            <input type="password" name="password" placeholder="Password" class="pass">
            <input type="submit" id="btn-submit" value="submit"/>
            <span id="warning">${err.msg}${err.userName}<br>${err.password}</span>
            <span>
                <a href="#" class="create">帳號jojo密碼9527</a>
            </span>
</form>
</div>

</body>
</html>