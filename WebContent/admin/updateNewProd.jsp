<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
<link rel="stylesheet" href="../style.css">
</head>
<body>

<div style="margin:0 auto;text-align:center;display:inline">

<h3>Update Product.</h3>


<%
// Print prior error login message if present
if (session.getAttribute("addAdminMessage") != null)
	out.println("<p>"+session.getAttribute("addAdminMessage").toString()+"</p>");
%>

<br>
<form name="MyForm" method=get >
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="4">Product Id:</font></div></td>
	<td><input type="text" name="productId"  size=30 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="4">Product Name:</font></div></td>
	<td><input type="text" name="productName"  size=30 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="4">Product Desc:</font></div></td>
	<td><input type="text" name="productDesc"  size=30 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="4">Category Id:</font></div></td>
	<td><input type="text" name="categoryId" size=30 maxlength="10"></td>
</tr>
</table>
<br/>

<button type="submit" formaction="updateNewProd.jsp">Update</button>