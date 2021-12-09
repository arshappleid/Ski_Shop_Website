<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
<link rel="stylesheet" href="../../style.css">
</head>
<body>

<div style="margin:0 auto;text-align:center;display:inline">

<h3>Admin Login.</h3>


<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");

session.setAttribute("addProdMessage",null);
session.setAttribute("loginMessage",null);
session.setAttribute("addAdminMessage",null);
%>

<br>
<form name="MyForm" method=get >
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
	<td><input type="text" name="username"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
	<td><input type="password" name="password" size=10 maxlength="10"></td>
</tr>
</table>
<br/>

<button type="submit" formaction="validateAdminLogin.jsp">Login</button>

