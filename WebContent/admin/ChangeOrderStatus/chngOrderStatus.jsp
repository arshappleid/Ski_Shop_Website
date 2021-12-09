<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
<link rel="stylesheet" href="../../style.css">
</head>
<body>

<div style="margin:0 auto;text-align:center;display:inline">

<h4>Enter the Order Id for the order, and the new Details. Which will be forcibly override the previous Details.</h4>


<%
// Print prior error login message if present
if (session.getAttribute("updtOrderMsg") != null)
	out.println("<p>"+session.getAttribute("updtOrderMsg").toString()+"</p>");
%>

<br>
<form name="MyForm" method=get >
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="4">Order id:</font></div></td>
	<td><input type="text" name="orderId"  size=30 maxlength=30></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="4">Ship Address:</font></div></td>
	<td><input type="text" name="address" size=80 maxlength="100"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="4">City:</font></div></td>
	<td><input type="text" name="city" size=30 maxlength="30"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="4">State :</font></div></td>
	<td><input type="text" name="state" size=20 maxlength="25"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="4">Postal Code :</font></div></td>
	<td><input type="text" name="postalCode" size=20 maxlength="25"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="4"> Country :</font></div></td>
	<td><input type="text" name="country" size=20 maxlength="25"></td>
</tr>
</table>
<br/>

<button type="sumbmit" formaction="./changeStatus.jsp?orderId="+orderId)>Update</button>

