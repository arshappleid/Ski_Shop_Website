<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
<link rel="stylesheet" href="../style.css">
</head>
<body>

<div style="margin:0 auto;text-align:center;display:inline">

<h3>Enter all the correct details below to reset your password.</h3>

<br>
<form name="MyForm" method=get >
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username :</font></div></td>
	<td><input name="username" type="hidden" value=<%=request.getParameter("username") %>></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Enter New Password:</font></div></td>
	<td><input type="password" name="newpass"  size=20 maxlength=20></td>
</tr>
</table>
<br/>

<button type=\"submit\" formaction="changePassword.jsp">Change Password</button>

