<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
<link rel="stylesheet" href="../style.css">
</head>
<body>

<div style="margin:0 auto;text-align:center;display:inline">

<h3>Enter all the correct details below to reset your password.</h3>


<%
// Print prior error login message if present
if (session.getAttribute("forgotPassMsg") != null)
	out.println("<p>"+session.getAttribute("forgotPassMsg").toString()+"</p>");
%>

<br>
<form name="MyForm" method=get >
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
	<td><input type="text" name="username"  size=20 maxlength=20></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2"></font></div></td>
	<td><input type="text" name="lastName" size=20 maxlength="20"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Email :</font></div></td>
	<td><input type="text" name="email" size=30 maxlength="30"></td>
</tr>

</table>
<br/>


<button type="submit" formaction="validateInfo.jsp">Forgot Password</button>
