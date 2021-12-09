<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
<link rel="stylesheet" href="../../style.css">
</head>
<body>

<div style="margin:0 auto;text-align:center;display:inline">

<h3>Enter Required Admin Details.</h3>


<%
// Print prior error login message if present
if (session.getAttribute("addAdminMessage") != null)
	out.println("<p>"+session.getAttribute("addAdminMessage").toString()+"</p>");
%>

<br>
<form name="MyForm" method=get >
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">First Name:</font></div></td>
	<td><input type="text" name="firstName"  size=30 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Last Name:</font></div></td>
	<td><input type="text" name="lastName"  size=30 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">User Name:</font></div></td>
	<td><input type="text" name="username"  size=30 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password :</font></div></td>
	<td><input type="password" name="password" size=30 maxlength="20"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Confirm Password:</font></div></td>
	<td><input type="password" name="cnfmpassword" size=30 maxlength="20"></td>
</tr>

</table>
<br/>

<button type="submit" formaction="addNewAdmin.jsp">Add</button>

